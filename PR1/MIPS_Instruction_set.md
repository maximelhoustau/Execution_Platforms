## Question 1

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

## MIPS Tool Chain

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

If we compile it without optimization. The assembly code is
quite different, much longer and most instructions are useless.
It uses register S8 which is the frame pointer. But here it is useless
as we know the size of the stack. Sp could have done the job, and here
sp = fp, so really it's useless. Moreover the code never uses other
register than v0 and it always store it's value in the stack (thanks to s8)
and load values from the stack.

With some optimization we get better results, and we no longer use S8.
The closest result is when we compile the code with an optmization for
the size (-Os).

## MIPS Architecture

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


|  PC |  instruction |   a0  |   a1  |  v0  |  v1  |  explaination                  |
|----:|:-------------|:-----:|:-----:|:----:|:----:|:-------------------------------|
|0x0  |beq a0, 0, 0xD|0x200  |0x0    | 0x0  | 0x0  |a0 != 0 so the branch is untaken|
|0x4  |nop           |0x200  |0x0    | 0x0  | 0x0  |no change                       |
|0x8  |lb a0, a1, 0x0|0x200  |0x0    | 0x0  | 0x0  |read from memory[0x200] to a1   |
|0xc  |nop           |0x200  |0x61   | 0x0  | 0x0  |no change wait for loading      |
|0X10 |beq a1, 0, 0x7|0x200  |0x61   | 0x0  | 0x0  |a1 != 0 so the branch is untaken|
|0x14 |or v0, 0, 0   |0x200  |0x61   | 0x0  | 0x0  |v0 <= 0                         |
|0x18 |addiu a0, a0, 0x1|0x201  |0x61   | 0x0  | 0x0  |a0 <= a0 + 1                 |
|0x1c |xori v1, a1, 0x20|0x201  |0x61   | 0x0  |0x41  |v1 <= a1 ^ 0x20              |
|0x20 |lb a0, a1, 0x0|0x201  |0x61   | 0x0  | 0x41 |read from memory[0x201] to a1   |
|0x24 |sltu v1, 0, v1|0x201  |0x20   | 0x0  | 0x1  |compare v1 to 0 and store the result in v1|
|0x28 |bne a1, 0, 0xfffb|0x201  |0x20   | 0x0  | 0x1  |a1 != 0 so the branch is taken|
|     |              |       |       |      |      |                                |
|     |              |       |       |      |      |                                |
|     |              |       |       |      |      |                                |
|     |              |       |       |      |      |                                |
|     |              |       |       |      |      |                                |
|     |              |       |       |      |      |                                |
|     |              |       |       |      |      |                                |
|     |              |       |       |      |      |                                |
|     |              |       |       |      |      |                                |
|     |              |       |       |      |      |                                |
