
mips-prog.o:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <f>:
   0:	1080000e 	beqz	a0,3c <f+0x3c>
   4:	2402ffff 	li	v0,-1
   8:	80830000 	lb	v1,0(a0)
   c:	00000000 	nop
  10:	1060000a 	beqz	v1,3c <f+0x3c>
  14:	00001025 	move	v0,zero
  18:	24840001 	addiu	a0,a0,1
  1c:	80820000 	lb	v0,0(a0)
  20:	00000000 	nop
  24:	10400003 	beqz	v0,34 <f+0x34>
  28:	00000000 	nop
  2c:	1000fffa 	b	18 <f+0x18>
  30:	00401825 	move	v1,v0
  34:	38630020 	xori	v1,v1,0x20
  38:	0003102b 	sltu	v0,zero,v1
  3c:	03e00008 	jr	ra
  40:	00000000 	nop
	...
