00000000 <f>:
   0:	27bdffe8 	addiu	sp,sp,-24
   4:	afbe0014 	sw	s8,20(sp)
   8:	03a0f025 	move	s8,sp
   c:	afc40018 	sw	a0,24(s8)
  10:	8fc20018 	lw	v0,24(s8)
  14:	00000000 	nop
  18:	14400004 	bnez	v0,2c <f+0x2c>
  1c:	00000000 	nop
  20:	2402ffff 	li	v0,-1
  24:	10000021 	b	ac <f+0xac>
  28:	00000000 	nop
  2c:	8fc20018 	lw	v0,24(s8)
  30:	00000000 	nop
  34:	90420000 	lbu	v0,0(v0)
  38:	00000000 	nop
  3c:	a3c20008 	sb	v0,8(s8)
  40:	83c20008 	lb	v0,8(s8)
  44:	00000000 	nop
  48:	14400013 	bnez	v0,98 <f+0x98>
  4c:	00000000 	nop
  50:	00001025 	move	v0,zero
  54:	10000015 	b	ac <f+0xac>
  58:	00000000 	nop
  5c:	83c20008 	lb	v0,8(s8)
  60:	00000000 	nop
  64:	38420020 	xori	v0,v0,0x20
  68:	0002102b 	sltu	v0,zero,v0
  6c:	304200ff 	andi	v0,v0,0xff
  70:	afc2000c 	sw	v0,12(s8)
  74:	8fc20018 	lw	v0,24(s8)
  78:	00000000 	nop
  7c:	24420001 	addiu	v0,v0,1
  80:	afc20018 	sw	v0,24(s8)
  84:	8fc20018 	lw	v0,24(s8)
  88:	00000000 	nop
  8c:	90420000 	lbu	v0,0(v0)
  90:	00000000 	nop
  94:	a3c20008 	sb	v0,8(s8)
  98:	83c20008 	lb	v0,8(s8)
  9c:	00000000 	nop
  a0:	1440ffee 	bnez	v0,5c <f+0x5c>
  a4:	00000000 	nop
  a8:	8fc2000c 	lw	v0,12(s8)
  ac:	03c0e825 	move	sp,s8
  b0:	8fbe0014 	lw	s8,20(sp)
  b4:	27bd0018 	addiu	sp,sp,24
  b8:	03e00008 	jr	ra
  bc:	00000000 	nop

mips-prog.o:     file format elf32-tradbigmips


Disassembly of section .text:

00000000 <f>:
   0:	27bdffe8 	addiu	sp,sp,-24
   4:	afbe0014 	sw	s8,20(sp)
   8:	03a0f025 	move	s8,sp
   c:	afc40018 	sw	a0,24(s8)
  10:	8fc20018 	lw	v0,24(s8)
  14:	00000000 	nop
  18:	14400004 	bnez	v0,2c <f+0x2c>
  1c:	00000000 	nop
  20:	2402ffff 	li	v0,-1
  24:	10000028 	b	c8 <f+0xc8>
  28:	00000000 	nop
  2c:	8fc20018 	lw	v0,24(s8)
  30:	00000000 	nop
  34:	90420000 	lbu	v0,0(v0)
  38:	00000000 	nop
  3c:	a3c20008 	sb	v0,8(s8)
  40:	83c20008 	lb	v0,8(s8)
  44:	00000000 	nop
  48:	14400004 	bnez	v0,5c <f+0x5c>
  4c:	00000000 	nop
  50:	00001025 	move	v0,zero
  54:	1000001c 	b	c8 <f+0xc8>
  58:	00000000 	nop
  5c:	afc0000c 	sw	zero,12(s8)
  60:	10000014 	b	b4 <f+0xb4>
  64:	00000000 	nop
  68:	83c20008 	lb	v0,8(s8)
  6c:	00000000 	nop
  70:	38420020 	xori	v0,v0,0x20
  74:	0002102b 	sltu	v0,zero,v0
  78:	304200ff 	andi	v0,v0,0xff
  7c:	00401825 	move	v1,v0
  80:	8fc2000c 	lw	v0,12(s8)
  84:	00000000 	nop
  88:	00431021 	addu	v0,v0,v1
  8c:	afc2000c 	sw	v0,12(s8)
  90:	8fc20018 	lw	v0,24(s8)
  94:	00000000 	nop
  98:	24420001 	addiu	v0,v0,1
  9c:	afc20018 	sw	v0,24(s8)
  a0:	8fc20018 	lw	v0,24(s8)
  a4:	00000000 	nop
  a8:	90420000 	lbu	v0,0(v0)
  ac:	00000000 	nop
  b0:	a3c20008 	sb	v0,8(s8)
  b4:	83c20008 	lb	v0,8(s8)
  b8:	00000000 	nop
  bc:	1440ffea 	bnez	v0,68 <f+0x68>
  c0:	00000000 	nop
  c4:	8fc2000c 	lw	v0,12(s8)
  c8:	03c0e825 	move	sp,s8
  cc:	8fbe0014 	lw	s8,20(sp)
  d0:	27bd0018 	addiu	sp,sp,24
  d4:	03e00008 	jr	ra
  d8:	00000000 	nop
  dc:	00000000 	nop
