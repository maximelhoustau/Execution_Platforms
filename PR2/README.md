# Project 2
___

## 2) Warm Up

### 2.1 MIPS Tools

**Bonus Question :**

> Can you find the instructions that load the address of input (into a
> register? Probably it will be loaded into register v0 within
> the first for-loop of main.)

The instruction

```
mips-linux-gnu-objdump -t -j.data -j.text bin/insertion-sort.elf
```

shows that the address of `input` is `0x11210` :

```
00011210 g     O .data  00000190 input
```

Moreover, When we examine the assembly with the insruction :

```
mips-linux-gnu-objdump -t -j.data -j.text bin/insertion-sort.elf
```

we find this to load the address of input in v0 :

```
10a8:       afc00018        sw      zero,24(s8)
10ac:       1000000f        b       10ec <main+0x54>
10ec:       8fc20018        lw      v0,24(s8)
10f0:       28420008        slti    v0,v0,8
10f4:       1440ffef        bnez    v0,10b4 <main+0x1c>
10b4:       3c020001        lui     v0,0x1
10b8:       8fc30018        lw      v1,24(s8)
10bc:       00031880        sll     v1,v1,0x2
10c0:       24421210        addiu   v0,v0,4624
10c4:       00621021        addu    v0,v1,v0
10c8:       8c430000        lw      v1,0(v0)
10cc:       8fc20018        lw      v0,24(s8)
10d0:       00021080        sll     v0,v0,0x2
10d4:       27c40018        addiu   a0,s8,24
10d8:       00821021        addu    v0,a0,v0
10dc:       ac43000c        sw      v1,12(v0)
```

| line |   instruction   |   v0   |   v1   |   a0   |   s8   |   traduction   |
|------|-----------------|--------|--------|--------|--------|----------------|
| 10a8 |  sw zero, 24(s8)|0x1xxxx | 0xxxxx | 0xxxxx | 0x0    |load 0x0 in s8 |
| 10ac |  b 0x10ec       |0x1xxxx | 0xxxxx | 0xxxxx | 0x0    |load 0x0 in s8 |
| 10b4 |  lui v0, 0x1    |0x1xxxx | 0xxxxx | 0xxxxx |load 0x1 in the first half of v0|
| 10b8 |  lw v1, 24(s8)  |0x1xxxx | 0xxxxx | 0xxxxx |load 0x1 in the first half of v0|


