# Question 1

line | opcode | funct | MN | rs | rt | rd | imm | traduction
--- | --- | --- | --- | --- | --- | --- | --- | ---
0 | 4 | | BEQ | 4 | 0 | | `OxD` | **if (R[4] [= a0] = 0) then PC = PC + 4 + 4\*13**
4 | | | | | | | | **nop**
8 | 32 | | LB | 4 | 5 | | `0x0` | **R[5] = memory[ R[4] + 0] as a byte maybe get the function argument**
c | | | | | | | | **nop**
10 | 4 | | BEQ | 5 | 0 | | `0x7` | **if R[5] = 0 then PC = PC + 4 + 7\*4**
14 | 0 | OR | OR | 0 | 0 | 2 | | **R[2] = 0**
18 | 9 | | ADDIU | 4 | 4 | | `0x1` | **R[4] = R[4] + 1**
1c | 14 | | XORI | 5 | 3 | | `0x20` | **R[3] = R[5] XOR 0x20 : 6th byte flipped en partant de 1**
20 | 32 | | LB | 4 | 5 | | `0x0` | **R[5] = memory[R[4]] as a byte**
24 | 0 | 43 | SLTU | 0 | 3 | 3 | | **R[3] = (0 < R[3])  so condition R[3] != 0 cause unsigned**
28 | 5 | | BNE | 5 | 0 | | `0xFFFB` | **if R[5] != 0 then branch at PC + 4 + 4\*0xFFFB**
2c | 0 | 33 | ADDU | 2 | 3 | 2 | | **R[2] = R[2] + R[3]**
30 | 0 | 8 | JR | 31 | | | | **Jump Register : PC = R[31] = lr**
34 | | | | | | | | **nop**
38 | 0 | 8 | JR | 31 | | | | **Jump Register : PC = R[31] = lr**
3c | 9 | | ? | 0 | 2 | | `0xFFFF` | **R[2] = 0xFFFF**

```c
int f(char *s) {
    if(s == 0) return -1;
    char c = *s;
    if(c == 0) return 0;
    int r;
    while(c != 0) {
        r = (c != ' ');
	c = *(++s);
    }
    return r;
}
```

This function takes a string as argument and returns :
* -1 if the string is a null pointer
* 0 if the last caracter is a space or if the string is empty
* 1 if the last caracter is not a space
