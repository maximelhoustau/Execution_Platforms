__attribute__((naked)) int f(char *s) {
    if(s == 0) return -1;
    char c = *s;
    if(c == 0) return 0;

    int r;
    while (c != 0) {
        r = (c != ' ');
	      c = *(++s);
    }
    return r;
}
