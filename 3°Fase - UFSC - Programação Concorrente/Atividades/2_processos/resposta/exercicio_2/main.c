#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <string.h>

//                          (principal)
//                               |
//              +----------------+--------------+
//              |                               |
//           filho_1                         filho_2
//              |                               |
//    +---------+-----------+          +--------+--------+
//    |         |           |          |        |        |
// neto_1_1  neto_1_2  neto_1_3     neto_2_1 neto_2_2 neto_2_3

// ~~~ printfs  ~~~
//      principal (ao finalizar): "Processo principal %d finalizado\n"
// filhos e netos (ao finalizar): "Processo %d finalizado\n"
//    filhos e netos (ao inciar): "Processo %d, filho de %d\n"

// Obs:
// - netos devem esperar 5 segundos antes de imprmir a mensagem de finalizado (e terminar)
// - pais devem esperar pelos seu descendentes diretos antes de terminar

int main(int argc, char** argv) {
    pid_t pid_1 = fork();
    pid_t pid_2 = fork();
    if (pid_1 > 0 && pid_2 > 0) { // Parent
        printf("Processo pai criou %d\n", pid_1);
        printf("Processo pai criou %d\n", pid_2);
        wait(NULL);
        printf("Processo principal %d finalizado\n", getpid());
        return 0;
    } else if (pid_1 == 0 && pid_2 > 0) { // Child 1
        printf("Processo %d, filho de %d\n", getpid(), getppid());
        for (int i = 0; i < 3; i++) {
            fflush(stdout);
            if (fork() == 0) { // Child 1 i
                printf("Processo %d, filho de %d\n", getpid(), getppid());
                sleep(3);
                printf("Processo %d finalizado\n", getpid());
                exit(0);
            }
        }
        for (int i = 0; i < 3; i++) {
            wait(NULL);
        }
        printf("Processo %d finalizado\n", getpid());
        exit(0);
    } else if (pid_1 > 0 && pid_2 == 0) { // Child 2
        printf("Processo %d, filho de %d\n", getpid(), getppid());
        for (int j = 0; j < 3; j++) {
            fflush(stdout);
            if (fork() == 0) { // Child 2 i
                printf("Processo %d, filho de %d\n", getpid(), getppid());
                sleep(3);
                printf("Processo %d finalizado\n", getpid());
                exit(0);
            }
        }
        for (int j = 0; j < 3; j++) {
            wait(NULL);
        }
        printf("Processo %d finalizado\n", getpid());
        exit(0);
    } else if (pid_1 < 0 || pid_2 < 0) { // Error Parent
        fprintf(stderr, "Falha na execucao do fork\n");
        return 1;
    }

    /*************************************************
     * Dicas:                                        *
     * 1. Leia as intruções antes do main().         *
     * 2. Faça os prints exatamente como solicitado. *
     * 3. Espere o término dos filhos                *
     *************************************************/

}
