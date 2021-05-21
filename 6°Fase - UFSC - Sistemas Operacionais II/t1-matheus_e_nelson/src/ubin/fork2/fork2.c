#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>


int main() {
    for (int i = 0; i < 4; ++i) {
        int childCreated = fork();
        if (childCreated) {
            printf("Processo pai %d, criou %d\n", getpid(), childCreated);
            fflush(stdout);
        } else {
		while (i > 2) {}
                printf("Processo filho %d\n", getpid());
                break;
        }
    }
    return 0;
}
