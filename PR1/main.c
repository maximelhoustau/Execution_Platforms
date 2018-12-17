#include <stdio.h>
#include "function.c"

int main() {
  char * s = "Salut";
  char * s1 = "Coucou ";
  char * s2 = "a b c";

  printf("Resultat : %d, %d, %d\n",f(s), f(s1), f(s2));
  return 0;
}
