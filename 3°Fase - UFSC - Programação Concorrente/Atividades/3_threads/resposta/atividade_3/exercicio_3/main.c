#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <pthread.h>
#include <math.h>


// Lê o conteúdo do arquivo filename e retorna um vetor E o tamanho dele
// Se filename for da forma "gen:%d", gera um vetor aleatório com %d elementos
//
// +-------> retorno da função, ponteiro para vetor malloc()ado e preenchido
// |
// |         tamanho do vetor (usado <-----+
// |         como 2o retorno)              |
// v                                       v
double* load_vector(const char* filename, int* out_size);


// Avalia se o prod_escalar é o produto escalar dos vetores a e b. Assume-se
// que ambos a e b sejam vetores de tamanho size.
void avaliar(double* a, double* b, int size, double prod_escalar);

typedef struct batch_t {
	int starts_at;
	int ends_at;
	double *v_a;
	double *v_b;
} batch;

void *t_function(void *arg) {
	batch *b;
	b = (batch *)arg;
	double *sum = (double *)malloc(sizeof(double));
	for (int i=b->starts_at; i<b->ends_at; i++) {
		(*sum) += b->v_a[i] * b->v_b[i];
	}
	return sum;
}



int main(int argc, char* argv[]) {
    srand(time(NULL));

    //Temos argumentos suficientes?
    if(argc < 4) {
        printf("Uso: %s n_threads a_file b_file\n"
               "    n_threads    número de threads a serem usadas na computação\n"
               "    *_file       caminho de arquivo ou uma expressão com a forma gen:N,\n"
               "                 representando um vetor aleatório de tamanho N\n",
               argv[0]);
        return 1;
    }

    //Quantas threads?
    int n_threads = atoi(argv[1]);
    if (!n_threads) {
        printf("Número de threads deve ser > 0\n");
        return 1;
    }
    //Lê números de arquivos para vetores alocados com malloc
    int a_size = 0, b_size = 0;
    double* a = load_vector(argv[2], &a_size);
    if (!a) {
        //load_vector não conseguiu abrir o arquivo
        printf("Erro ao ler arquivo %s\n", argv[2]);
        return 1;
    }
    double* b = load_vector(argv[3], &b_size);
    if (!b) {
        printf("Erro ao ler arquivo %s\n", argv[3]);
        return 1;
    }

    //Garante que entradas são compatíveis
    if (a_size != b_size) {
        printf("Vetores a e b tem tamanhos diferentes! (%d != %d)\n", a_size, b_size);
        return 1;
    }

    //Calcula produto escalar. Paralelize essa parte
	if (n_threads > a_size) {
		n_threads = a_size;
	}

	int i, j;
	double result = 0;
	int chunk = a_size / n_threads;
    pthread_t t[n_threads];
	batch *batches[n_threads];
	for (i=0; i<n_threads; i++) {
		batches[i] = malloc(sizeof(batch));
		batches[i]->starts_at = chunk*i;
		batches[i]->ends_at = chunk*(i+1);
		batches[i]->v_a = a;
		batches[i]->v_b = b;
		pthread_create(&t[i], NULL, t_function, (void *)batches[i]);
	}

	// Células restantes
	for (j=batches[i-1]->ends_at; j<a_size; j++) {
		result += b[j] * a[j];
	}

	pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;

	// Somando os retornos das threads
	double *sum_thread;
	for (i=0; i<n_threads; i++) {
		pthread_join(t[i], (void *) &sum_thread);
		pthread_mutex_lock(&mutex);
		result += (*sum_thread);
		free(sum_thread);
		pthread_mutex_unlock(&mutex);
	}

    //    +---------------------------------+
    // ** | IMPORTANTE: avalia o resultado! | **
    //    +---------------------------------+
    avaliar(a, b, a_size, round(result));

    //Libera memória
    free(a);
    free(b);
	for (int i=0; i<n_threads; i++) {
		free(batches[i]);
	}

    return 0;
}
