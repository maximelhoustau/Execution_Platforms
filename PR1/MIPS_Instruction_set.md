# Question 1

line number | opcode | funct | MN | rs | rt | rd | immediate | traduction
--- | --- | --- | --- | --- | --- | --- | --- | ---
0 | 4 | | BEQ | 2 | 0 | | 13 | **if R[rs] = 0 (R[0] = 0) then PC = PC + 4 + 4\*13**
4 | | | | | | | | **nop**
8 : opcode: 32 LB rs = 4 rt = 5 immediate = 0 | **R[rt] = memory[ R[rs] + 0] as a byte maybe get the function argument**
c : | **nop**
10 : opcode 4 Branch on equal rs = 5 rt = 0 immediate = 7 | **if R[5] = 0 then PC = PC + 4 + 28**
14 : opcode : 0 funct: OR rs = 0 rt = 0 rd = 2 | **R[2] = 0**
18 : opcode : 9 ADDIU rs = 4 rt = 4 immediate = 1 | **R[4] = R[4] + 1**
1c : opcode : 14 XORI rs = 5 rt = 3 immediate = 0x20 | **R[3] = R[5] XOR 0x20 8th byte flipped**
20 : opcode : 32 LB rs = 4 rt = 5 immediate = 0 **R[5] = memory[R[4]] as a byte**

24 : opcode : 0 SLTU funct : 43 rs = 0 rt = 3 rd = 3 **R[3] = (0 < R[3])  so condition R[3] != 0 cause unsigned**

28 : opcode : 5 BNE rs = 5 rt = 0 immediate = 0xFFFB **if R[5] != 0 then branch at PC + 4 + 4\*0xFFFB**

2c : opcode : 0 funct : 33 ADDU rs = 2 rt = 3  rd = 2 **R[2] = R[2] + R[3]**

30 : opcode : 0 funct : 8 JR rs : 31 **Jump Register : PC = R[31]**

34 : **nop**

38 : opcode : 0 funct : 8 JR rs : 31 **Jump Register : PC = R[31]**
 
3c : opcode : 9 rs = 0 rt = 2 immediate = 0xFFFF **R[2] = 0xFFFF**


