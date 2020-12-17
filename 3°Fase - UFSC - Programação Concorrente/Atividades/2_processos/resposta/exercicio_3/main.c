#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <stdio.h>
#include <string.h>


//        (pai)
//          |
//      +---+---+
//      |       |
//     sed    grep

// ~~~ printfs  ~~~
//        sed (ao iniciar): "sed PID %d iniciado\n"
//       grep (ao iniciar): "grep PID %d iniciado\n"
//          pai (ao iniciar): "Processo pai iniciado\n"
// pai (após filho terminar): "grep retornou com código %d,%s encontrou adamantium\n"
//                            , onde %s é
//                              - ""    , se filho saiu com código 0
//                              - " não" , caso contrário

// Obs:
// - processo pai deve esperar pelo filho
// - 1º filho, após o término do 1º deve trocar seu binário para executar
//   sed -i /silver/axamantium/g;s/adamantium/silver/g;s/axamantium/adamantium/g text
//   + dica: leia as dicas do grep
// - 2º filho deve trocar seu binário para executar "grep adamantium text"
//   + dica: use execlp(char*, char*...)
//   + dica: em "grep adamantium text",  argv = {"grep", "adamantium", "text"}

int main(int argc, char** argv) {
    printf("Processo pai iniciado\n");
    pid_t pids[2];
    fflush(stdout);
    pids[0] = fork();
    if (pids[0]) { // Pai

      wait(NULL); // Espera o primeiro filho (sed)

    	pids[1] = fork();
    	if (pids[1]) { // Ainda no pai

      		int stat;
          wait(&stat); // Espera o segundo filho (grep) e armazena seu retorno em stat

      		int exitCode = WEXITSTATUS(stat); // Mascara que retorna o exit code
          printf("%d\n", exitCode);
      		if (exitCode == 0) {
              printf("grep retornou com código 0, encontrou adamantium\n");
      		} else if (exitCode == 1 || exitCode == 2) { // Será 2 se arquivo não encontrado
              printf("grep retornou com código %d, não encontrou adamantium\n", exitCode);
          }

    	} else if(pids[1] == 0) { // Segundo filho (grep)
      		printf("grep PID %d iniciado\n", getpid());
      		fflush(stdout);
      		execlp("grep", "grep", "adamantium", "text", NULL);
    	} else {
          printf("error no fork\n");
    	}

    } else if(pids[0] == 0){ // Primeiro filho (sed)
      	printf("sed PID %d iniciado\n", getpid());
      	fflush(stdout);
      	execlp("sed", "sed", "-i", "-e", "s/silver/axamantium/g;s/adamantium/silver/g;s/axamantium/adamantium/g", "text", NULL);
    } else {
    	  printf("erro no fork\n");
    }

    /*************************************************
     * Dicas:                                        *
     * 1. Leia as intruções antes do main().         *
     * 2. Faça os prints exatamente como solicitado. *
     * 3. Espere o término dos filhos                *
     *************************************************/

    return 0;
}
