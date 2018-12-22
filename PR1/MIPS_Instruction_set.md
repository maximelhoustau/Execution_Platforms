## Question 1

| line | opcode | funct | MN | rs | rt | rd | imm | traduction |
| ---: | ------:|:------:|:------ |:---:|:---:|:---:|:---:|:------------------------------------------------------ |
| 0    | 4 | | BEQ | 4 | 0 | | `OxD` | **if (R[4] [= a0] = 0) then PC = PC + 4 + 4\*13** |
| 4    | | | | | | | | **nop** |
| 8    | 32 | | LB | 4 | 5 | | `0x0` | **R[5] = memory[ R[4] + 0] as a byte maybe get the function argument (if we see R4 = a0 as pointer argument)** |
| c    | | | | | | | | **nop** |
| 10   | 4 | | BEQ | 5 | 0 | | `0x7` | **if R[5] = 0 then PC = PC + 4 + 7\*4** |
| 14   | 0 | OR | OR | 0 | 0 | 2 | | **R[2] = 0** |
| 18   | 9 | | ADDIU | 4 | 4 | | `0x1` | **R[4] = R[4] + 1** |
| 1c   | 14 | | XORI | 5 | 3 | | `0x20` | **R[3] = R[5] XOR 0x20 : 6th byte flipped** |
| 20   | 32 | | LB | 4 | 5 | | `0x0` | **R[5] = memory[R[4]] as a byte (we are reading a kind of tab)** |
| 24   | 0 | 43 | SLTU | 0 | 3 | 3 | | **R[3] = (0 < R[3])  <=> (R[3] != 0) as it is unsigned** |
| 28   | 5 | | BNE | 5 | 0 | | `0xFFFB` | **if R[5] != 0 then branch at PC + 4 + 4\*0xFFFB  (= PC - 16)** |
| 2c   | 0 | 33 | ADDU | 2 | 3 | 2 | | **R[2] = R[2] + R[3]** |
| 30   | 0 | 8 | JR | 31 | | | | **Jump Register : PC = R[31] = ra** |
| 34   | | | | | | | | **nop** |
| 38   | 0 | 8 | JR | 31 | | | | **Jump Register : PC = R[31] = ra** |
| 3c   | 9 | | ? | 0 | 2 | | `0xFFFF` | **R[2] = 0xFFFF ( = -1)** |


## MIPS Tool Chain

```c
int f(char *s) {
    if(s == 0) return -1;
    char c = *s;
    if(c == 0) return 0;
    int r = 0;
    while(c != 0) {
        r += (c != ' ');
	      c = *(++s);
    }
    return r;
}
```

This function takes a string as argument and returns :
* -1 if the string is a null pointer
* The number of char different than a space in the string otherwise.

If we compile it without optimization. The assembly code is
quite different, much longer and most instructions are useless.
It uses register S8 which is the frame pointer. But here it is useless
as we know the size of the stack. Sp could have done the job, and here
sp = fp, so really it's useless. Moreover the code never uses other
register than v0 and it always store it's value in the stack (thanks to s8)
and load values from the stack.

With some optimization we get better results, and we no longer use S8.
With -O2 optimization we have the exact same code. And with -Os we get even a shorter code (but maybe less efficient).

## MIPS Architecture


|  PC |  instruction |   a0  |   a1  |  v0  |  v1  |  explaination                  |
|----:|:-------------|:-----:|:-----:|:----:|:----:|:-------------------------------|
|0x0  |beq a0, 0, 0xD|0x200  |0x0    | 0x0  | 0x0  |a0 != 0 so the branch is untaken|
|0x4  |nop           |0x200  |0x0    | 0x0  | 0x0  |no change                       |
|0x8  |lb a0, a1, 0x0|0x200  |0x0    | 0x0  | 0x0  |read from memory[0x200] to a1 the value arrives in the next instruction|
|0xc  |nop           |0x200  |0x61   | 0x0  | 0x0  |no change wait for loading      |
|0X10 |beq a1, 0, 0x7|0x200  |0x61   | 0x0  | 0x0  |a1 != 0 so the branch is untaken|
|0x14 |or v0, 0, 0   |0x200  |0x61   | 0x0  | 0x0  |v0 <= 0                         |
|0x18 |addiu a0, a0, 0x1|0x201  |0x61   | 0x0  | 0x0  |a0 <= a0 + 1                 |
|0x1c |xori v1, a1, 0x20|0x201  |0x61   | 0x0  |0x41  |v1 <= a1 ^ 0x20              |
|0x20 |lb a0, a1, 0x0|0x201  |0x61   | 0x0  | 0x41 |read from memory[0x201] to a1 the value arrives in the next instruction|
|0x24 |sltu v1, 0, v1|0x201  |0x20   | 0x0  | 0x1  |v1 <= ( v1!= 0)      |
|0x28 |bne a1, 0, 0xfffb|0x201  |0x20   | 0x0  | 0x1  |a1 != 0 so the branch is taken. the next instruction is still executed|
|0x2c |addu v0, v1, v0|0x201  |0x20   | 0x1  | 0x1  |v0 <= v0 + v1 = 1             |
|0x18 |addiu a0, a0, 0x1|0x202  |0x20   | 0x1  | 0x1  |a0 <= a0 + 1                 |
|0x1c |xori v1, a1, 0x20|0x202  |0x20   | 0x1  |0x0   |v1 <= a1 ^ 0x20              |
|0x20 |lb a0, a1, 0x0|0x202  |0x20   | 0x1  | 0x0  |read from memory[0x202] to a1 the value arrives in the next instruction|
|0x24 |sltu v1, 0, v1|0x202  |0x62   | 0x1  | 0x0  |v1 <= ( v1!= 0)      |
|0x28 |bne a1, 0, 0xfffb|0x202  |0x62   | 0x1  | 0x0  |a1 != 0 so the branch is taken. the next instruction is still executed|
|0x2c |addu v0, v1, v0|0x202  |0x62   | 0x1  | 0x0  |v0 <= v0 + v1 = 1             |
|0x18 |addiu a0, a0, 0x1|0x203  |0x62   | 0x1  | 0x0  |a0 <= a0 + 1                 |
|0x1c |xori v1, a1, 0x20|0x203  |0x62   | 0x1  |0x42  |v1 <= a1 ^ 0x20              |
|0x20 |lb a0, a1, 0x0|0x203  |0x62   | 0x1  | 0x42 |read from memory[0x203] to a1 the value arrives in the next instruction|
|0x24 |sltu v1, 0, v1|0x203  |0x0    | 0x1  | 0x1  |v1 <= ( v1!= 0)      |
|0x28 |bne a1, 0, 0xfffb|0x203  |0x0    | 0x1  | 0x1  |a1 == 0 so the branch is not taken|
|0x2c |addu v0, v1, v0|0x203  |0x0    | 0x2  | 0x1  |v0 <= v0 + v1 = 2             |
|0x30 |jr ra         |0x203  |0x0    | 0x2  | 0x1  |end of function, returns. next instruction is still executed|
|0x34 |nop           |0x203  |0x0    | 0x2  | 0x1  |nop                             |

## Processor design

### Format list
The first format is **R-format**, the 16-bits instruction is divided in 4 part of 4 bits :

|0...3 |4...7 |8...11|12...15|
|:----:|:----:|:----:|:----: |
|opcode|Rs    |R1    |R2     |

(There are 16 registers, so register id are on 4 bits.)

The second format is **M-format**, used for memory access. The opcode is now on 3 bits, and the immediate value is on 5 bits :

|0...2 |3...6 |7...10|11...15  |
|:---: |:----:|:----:|:-----:  |
|opcode|Rs    |Ra    |immediate|

And the last format is **I-format**. The opcode is on only 2 bits, and the immediate value is on 10 bits (register id are still on 4 bits) :

|0...1 |2...5 |6...15      |
|:--:  |:----:|:----------:|
|opcode|R     |immediate   |

### Instructions list


| Assembly code | Format | Opcode | Traduction                                  |
|:---:          |:---:   |:----   |:-----------------------                     |
|ADD            |R       |0000    |Rs <- R1 + R2                                |
|AND            |R       |0001    |Rs <- R1 & R2                                |
|XOR            |R       |0010    |Rs <- R1 ^ R2                                |
|JR             |R       |0011    |PC <- Rs                                     |
|LB             |M       |010     |Rs <- SE*(Mem[Ra + SE(immediate)])           |
|SB             |M       |011     |Mem[Ra + SE(immediate)] <- Rs[7:0]           |
|MV             |I       |10      |R <- SE(immediate)                           |
|BNN            |I       |11      |If R != 0, then PC = PC + 2** x immediate      |

*SE = Sign Extend.

** Instructions are on 16 bits, so PC should always be an even number.

#### First exercise :
In order to load 65534 (= 0xFFFE) into a register with those instructions, we can do :

```
MV R0 0x3FF
ADD R0 R0 R0
```

The first line will set R0 to -1 = 0x3FF (on 10 bits). It means that after this instruction, R0 has 0xFFFF value due to sign extension. Then the second instruction do : R0 <= -1 + -1 = -2 (0xFFFF + 0xFFFF = 0xFFFE).


#### Second exercise :
