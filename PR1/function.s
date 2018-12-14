	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	nooddspreg
	.abicalls
	.option	pic0
	.text
$Ltext0:
	.cfi_sections	.debug_frame
	.align	2
	.globl	f
	.cfi_sections .debug_frame
$LFB0 = .
	.file 1 "function.c"
	.loc 1 1 0
	.cfi_startproc
	.set	nomips16
	.set	nomicromips
	.ent	f
	.type	f, @function
f:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, gp= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
$LVL0 = .
	.loc 1 2 0
	beq	$4,$0,$L4
	nop

	.loc 1 3 0
	lb	$2,0($4)
	nop
$LVL1 = .
	.loc 1 4 0
	bne	$2,$0,$L3
	nop

	j	$31
	move	$2,$0

$LVL2 = .
$L6:
	move	$2,$3
$LVL3 = .
$L3:
	.loc 1 9 0
	addiu	$4,$4,1
$LVL4 = .
	lb	$3,0($4)
	nop
$LVL5 = .
	.loc 1 7 0
	bne	$3,$0,$L6
	xori	$2,$2,0x20

$LVL6 = .
	.loc 1 8 0
	j	$31
	sltu	$2,$0,$2

$LVL7 = .
	.loc 1 12 0
	j	$31
	nop

$LVL8 = .
$L4:
	.loc 1 2 0
	j	$31
	li	$2,-1			# 0xffffffffffffffff

	.set	macro
	.set	reorder
	.end	f
.cfi_endproc
$LFE0:
	.size	f, .-f
$Letext0:
	.section	.debug_info,"",@progbits
$Ldebug_info0:
	.4byte	0x75
	.2byte	0x4
	.4byte	$Ldebug_abbrev0
	.byte	0x4
	.uleb128 0x1
	.4byte	$LASF1
	.byte	0xc
	.4byte	$LASF2
	.4byte	$LASF3
	.4byte	$Ltext0
	.4byte	$Letext0-$Ltext0
	.4byte	$Ldebug_line0
	.uleb128 0x2
	.ascii	"f\000"
	.byte	0x1
	.byte	0x1
	.4byte	0x64
	.4byte	$LFB0
	.4byte	$LFE0-$LFB0
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x64
	.uleb128 0x3
	.ascii	"s\000"
	.byte	0x1
	.byte	0x1
	.4byte	0x6b
	.4byte	$LLST0
	.uleb128 0x4
	.ascii	"c\000"
	.byte	0x1
	.byte	0x3
	.4byte	0x71
	.4byte	$LLST1
	.uleb128 0x4
	.ascii	"r\000"
	.byte	0x1
	.byte	0x6
	.4byte	0x64
	.4byte	$LLST2
	.byte	0
	.uleb128 0x5
	.byte	0x4
	.byte	0x5
	.ascii	"int\000"
	.uleb128 0x6
	.byte	0x4
	.4byte	0x71
	.uleb128 0x7
	.byte	0x1
	.byte	0x6
	.4byte	$LASF0
	.byte	0
	.section	.debug_abbrev,"",@progbits
$Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x6
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2117
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loc,"",@progbits
$Ldebug_loc0:
$LLST0:
	.4byte	$LVL0-$Ltext0
	.4byte	$LVL4-$Ltext0
	.2byte	0x1
	.byte	0x54
	.4byte	$LVL4-$Ltext0
	.4byte	$LFE0-$Ltext0
	.2byte	0x1
	.byte	0x54
	.4byte	0
	.4byte	0
$LLST1:
	.4byte	$LVL1-$Ltext0
	.4byte	$LVL2-$Ltext0
	.2byte	0x1
	.byte	0x52
	.4byte	$LVL2-$Ltext0
	.4byte	$LVL3-$Ltext0
	.2byte	0x1
	.byte	0x53
	.4byte	$LVL3-$Ltext0
	.4byte	$LVL5-$Ltext0
	.2byte	0x1
	.byte	0x52
	.4byte	$LVL5-$Ltext0
	.4byte	$LVL7-$Ltext0
	.2byte	0x1
	.byte	0x53
	.4byte	$LVL7-$Ltext0
	.4byte	$LVL8-$Ltext0
	.2byte	0x2
	.byte	0x74
	.sleb128 0
	.4byte	0
	.4byte	0
$LLST2:
	.4byte	$LVL2-$Ltext0
	.4byte	$LVL6-$Ltext0
	.2byte	0xc
	.byte	0x72
	.sleb128 0
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x8
	.byte	0x20
	.byte	0x2e
	.byte	0x8
	.byte	0xff
	.byte	0x1a
	.byte	0x9f
	.4byte	0
	.4byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	$Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	$Ltext0
	.4byte	$Letext0-$Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
$Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
$LASF2:
	.ascii	"function.c\000"
$LASF3:
	.ascii	"/cal/homes/rreme/workspace/SE/SE201/PR1\000"
$LASF1:
	.ascii	"GNU C11 5.2.0 -meb -mips1 -mhard-float -mllsc -mplt -mno"
	.ascii	"-shared -mabi=32 -mabi=32 -g -O2\000"
$LASF0:
	.ascii	"char\000"
	.ident	"GCC: (Sourcery CodeBench Lite 2015.11-32) 5.2.0"

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
