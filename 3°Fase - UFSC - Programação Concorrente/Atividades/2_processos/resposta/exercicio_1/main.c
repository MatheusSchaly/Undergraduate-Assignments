#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <string.h>

//       (pai)
//         |
//    +----+----+
//    |         |
// filho_1   filho_2


// ~~~ printfs  ~~~
// pai (ao criar filho): "Processo pai criou %d\n"
//    pai (ao terminar): "Processo pai finalizado!\n"
//  filhos (ao iniciar): "Processo filho %d criado\n"

// Obs:
// - pai deve esperar pelos filhos antes de terminar!


int main(int argc, char** argv) {
    pid_t pid_1, pid_2;
    pid_1 = fork();
    pid_2 = fork();
    if (pid_1 > 0 && pid_2 > 0) { // Parent
        printf("Processo pai criou %d\n", pid_1);
        printf("Processo pai criou %d\n", pid_2);
        while(wait(NULL) >= 0);
        printf("Processo pai finalizado!\n");
        return 0;
    } else if (pid_1 == 0 && pid_2 > 0) { // Child 1
        printf("Processo filho %d criado\n", getpid());
    } else if (pid_1 > 0 && pid_2 == 0) { // Child 2
        printf("Processo filho %d criado\n", getpid());
    } else if (pid_1 < 0 || pid_2 < 0) { // Error
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
