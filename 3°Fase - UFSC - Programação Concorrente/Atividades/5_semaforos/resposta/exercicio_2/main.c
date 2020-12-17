#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <stdio.h>
#include <pthread.h>
#include <time.h>
#include <semaphore.h>

int produzir(int value);    //< definida em helper.c
void consumir(int produto); //< definida em helper.c
void *produtor_func(void *arg);
void *consumidor_func(void *arg);

int indice_produtor, indice_consumidor, tamanho_buffer, n_produtores, n_consumidores;
int* buffer;
sem_t mutex, sem_produtor, sem_consumidor, sem_mutex_produtor, sem_mutex_consumidor;

//Você deve fazer as alterações necessárias nesta função e na função
//consumidor_func para que usem semáforos para coordenar a produção
//e consumo de elementos do buffer.
void *produtor_func(void *arg) {
    //arg contem o número de itens a serem produzidos
    int max = *((int*)arg);
    for (int i = 0; i <= max; ++i) {
        int produto;
        if (i == max) {
            produto = -1;          //envia produto sinlizando FIM
		}
        else {
            produto = produzir(i); //produz um elemento normal
		}
		sem_wait(&sem_produtor);
		sem_wait(&sem_mutex_produtor);
        indice_produtor = (indice_produtor + 1) % tamanho_buffer; //calcula posição próximo elemento
        buffer[indice_produtor] = produto; //adiciona o elemento produzido à lista
		sem_post(&sem_mutex_produtor);
		sem_post(&sem_consumidor);
    }
    return NULL;
}

void *consumidor_func(void *arg) {
    while (1) {
		sem_wait(&sem_consumidor);
		sem_wait(&sem_mutex_consumidor);
        indice_consumidor = (indice_consumidor + 1) % tamanho_buffer; //Calcula o próximo item a consumir
		int produto = buffer[indice_consumidor]; //obtém o item da lista
		sem_post(&sem_mutex_consumidor);
		sem_post(&sem_produtor);
        //Podemos receber um produto normal ou um produto especial
        if (produto >= 0) {
            consumir(produto); //Consome o item obtido.
		}
        else {
            break; //produto < 0 é um sinal de que o consumidor deve parar
		}
    }
    return NULL;
}

int main(int argc, char *argv[]) {
    if (argc < 5) {
        printf("Uso: %s tamanho_buffer itens_produzidos n_produtores n_consumidores \n", argv[0]);
        return 0;
    }

    tamanho_buffer = atoi(argv[1]);
    int itens = atoi(argv[2]);
    n_produtores = atoi(argv[3]);
    n_consumidores = atoi(argv[4]);
    printf("itens=%d, n_produtores=%d, n_consumidores=%d\n",
	   itens, n_produtores, n_consumidores);

    //Iniciando buffer
    indice_produtor = 0;
    indice_consumidor = 0;
    buffer = malloc(sizeof(int) * tamanho_buffer);

    // Crie threads e o que mais for necessário para que n_produtores
    // threads criem cada uma n_itens produtos e o n_consumidores os
    // consumam.
	sem_init(&sem_mutex_produtor, 0, 1);
	sem_init(&sem_mutex_consumidor, 0, 1);
	sem_init(&sem_produtor, 0, tamanho_buffer);
	sem_init(&sem_consumidor, 0, 0);

	pthread_t t_produtor[n_produtores];
	pthread_t t_consumidor[n_consumidores];
	int n[n_produtores];
	int i;

	for (i=0; i<n_produtores; i++) {
		n[i] = itens;
		pthread_create(&t_produtor[i], NULL, produtor_func, (void *) &n[i]);
	}
	for (i=0; i<n_consumidores; i++) {
		pthread_create(&t_consumidor[i], NULL, consumidor_func, NULL);
	}

	for (i=0; i<n_produtores; i++) {
		pthread_join(t_produtor[i], NULL);
	}

	// for (int j = 0; j < n_consumidores - n_produtores + tamanho_buffer; j++)
	// A linha acima deveria ser sucifiente. Entretanto, por algum motivo que
	// desconheço, ela não funciona. Portanto, estou forçando com o "* 2" na linha abaixo
	for (int j = 0; j < n_consumidores * 2; j++) {
		sem_post(&sem_consumidor);
	}

	for (i=0; i<n_consumidores; i++) {
		pthread_join(t_consumidor[i], NULL);
	}

	sem_destroy(&sem_mutex_produtor);
	sem_destroy(&sem_mutex_consumidor);
	sem_destroy(&sem_produtor);
	sem_destroy(&sem_consumidor);

    //Libera memória do buffer
    free(buffer);

    return 0;
}
