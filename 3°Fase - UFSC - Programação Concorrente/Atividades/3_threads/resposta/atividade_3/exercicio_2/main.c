#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <pthread.h>


// Lê o conteúdo do arquivo filename e retorna um vetor E o tamanho dele
// Se filename for da forma "gen:%d", gera um vetor aleatório com %d elementos
//
// +-------> retorno da função, ponteiro para vetor malloc()ado e preenchido
// |
// |         tamanho do vetor (usado <-----+
// |         como 2o retorno)              |
// v                                       v
double* load_vector(const char* filename, int* out_size);


// Avalia o resultado no vetor c. Assume-se que todos os ponteiros (a, b, e c)
// tenham tamanho size.
void avaliar(double* a, double* b, double* c, int size);

typedef struct batch_t {
	int starts_at;
	int ends_at;
	double *v_a;
	double *v_b;
	double *v_c;
} batch;

void *t_function(void *arg) {
	batch *b;
	b = (batch *)arg;
	for (int i=b->starts_at; i<b->ends_at; i++) {
		b->v_c[i] = b->v_a[i] + b->v_b[i];
	}
	return 0;
}

int main(int argc, char* argv[]) {
    // Gera um resultado diferente a cada execução do programa
    // Se **para fins de teste** quiser gerar sempre o mesmo valor
    // descomente o srand(0)
    srand(time(NULL)); //valores diferentes
    //srand(0);        //sempre mesmo valor

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
    //Cria vetor do resultado
    double* c = malloc(a_size*sizeof(double));

    // Calcula com uma thread só. Programador original só deixou a leitura
    // do argumento e fugiu pro caribe. É essa computação que você precisa
    // paralelizar
	if (n_threads > a_size) {
		n_threads = a_size;
	}

	int i, j;
	int chunk = a_size / n_threads;
    pthread_t t[n_threads];
	batch *batches[n_threads];
	for (i=0; i<n_threads; i++) {
		batches[i] = malloc(sizeof(batch));
		batches[i]->starts_at = chunk*i;
		batches[i]->ends_at = chunk*(i+1);
		batches[i]->v_a = a;
		batches[i]->v_b = b;
		batches[i]->v_c = c;
		pthread_create(&t[i], NULL, t_function, (void *)batches[i]);
	}

	// Células restantes
	for (j=batches[i-1]->ends_at; j<a_size; j++) {
		c[j] = b[j] + a[j];
	}

	for (i=0; i<n_threads; i++) {
		pthread_join(t[i], NULL);
	}

    //    +---------------------------------+
    // ** | IMPORTANTE: avalia o resultado! | **
    //    +---------------------------------+
    avaliar(a, b, c, a_size);

    //Importante: libera memória
    free(a);
    free(b);
    free(c);
	for (int i=0; i<n_threads; i++) {
		free(batches[i]);
	}

    return 0;
}
