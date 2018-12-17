#include <stdio.h>
#include "function.c"

int main() {
  char * s = "Salut";
  char * s1 = "Coucou ";


  printf("Resultat : %d, %d\n",f(s), f(s1));
  return 0;
}
