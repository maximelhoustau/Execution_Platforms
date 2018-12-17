
mips-prog.o:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <f>:
   0:	10800011 	beqz	a0,48 <f+0x48>
   4:	00000000 	nop
   8:	80820000 	lb	v0,0(a0)
   c:	00000000 	nop
  10:	14400004 	bnez	v0,24 <f+0x24>
  14:	00000000 	nop
  18:	03e00008 	jr	ra
  1c:	00001025 	move	v0,zero
  20:	00601025 	move	v0,v1
  24:	24840001 	addiu	a0,a0,1
  28:	80830000 	lb	v1,0(a0)
  2c:	00000000 	nop
  30:	1460fffb 	bnez	v1,20 <f+0x20>
  34:	38420020 	xori	v0,v0,0x20
  38:	03e00008 	jr	ra
  3c:	0002102b 	sltu	v0,zero,v0
  40:	03e00008 	jr	ra
  44:	00000000 	nop
  48:	03e00008 	jr	ra
  4c:	2402ffff 	li	v0,-1
