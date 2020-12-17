typedef struct {
	int contador;
	int dynamic_queue;
} semaforo_t;

int semaforo_inicializar(semaforo_t *s, unsigned int valor) {
	s->contador = valor;
}

int semaforo_entrar(semaforo_t *s) {
	if (s->contador > 0) {
		s->contador -= 1;
	} else {
		dynamic_queue.push()
	}
}

int semaforo_sair(semaforo_t *s) {
	if (s->contador != 0) {
		dynamic_queue.pop()
	} else {
		s->contador -= 1;
	}
}

int semaforo_destruir(semaforo_t *s) {
	free(s);
}
