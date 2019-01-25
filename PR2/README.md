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
mips-linux-gnu-objdump -d bin/insertion-sort.elf
```

we find this to load the address of input in `v0` :

```
10a8:       afc00018        sw      zero,24(s8)
10ac:       1000000f        b       10ec <main+0x54>
10b0:       00000000        nop
10b4:       3c020001        lui     v0,0x1
10b8:       8fc30018        lw      v1,24(s8)
10bc:       00031880        sll     v1,v1,0x2
[...]
10ec:       8fc20018        lw      v0,24(s8)
10f0:       28420008        slti    v0,v0,8
10f4:       1440ffef        bnez    v0,10b4 <main+0x1c>
10f8:       00000000        nop
```

| line |   instruction    |   v0   |   v1   | s8+[24]|   traduction                        |
|------|------------------|--------|--------|--------|-------------------------------------|
| 10a8 |  sw zero, 24(s8) | 0xxxxx | 0xxxxx | 0x0    |load 0x0 in s8                       |
| 10ac |  b 0x10ec        | 0xxxxx | 0xxxxx | 0x0    |branch 0x10ec                        |
| 10b0 |  nop             | 0xxxxx | 0xxxxx | 0x0    |nop                                  |
| 10ec |  lw v0, 24(s8)   | 0x0    | 0xxxxx | 0x0    |v0 = s8+[24]                         |
| 10f0 |  slti v0, v0, 8  | 0x1    | 0xxxxx | 0x0    |v0 = (v0<8)                          |
| 10f4 |  bnez v0, 0x10b4 | 0x1    | 0xxxxx | 0x0    |branch 0x10b4 if v0!=0 which is true |
| 10f8 |  nop             | 0x1    | 0xxxxx | 0x0    |nop                                  |
| 10b4 |  lui v0, 0x1     | 0x10000| 0xxxxx | 0x0    |v0 = 0x1 << 16                       |
| 10b8 |  lw v1, 24(s8)   | 0x10000| 0x0    | 0x0    |v1 = s8+[24]                         |
| 10bc |  sll v1, v1, 0x2 | 0x10000| 0x0    | 0x0    |v1 = v1 << 2                         |
| 10c0 |addiu v0, v0, 4624| 0x11210| 0x0    | 0x0    |v0 = v0 + 4624                       |

**At the end, `v0` contains `0x11210` witch is the address of `input`.**

___

## 3) Pipelining

> Can you tell from the pipeline diagram whether the simulated processor
> supports forwarding?

The instructions are the following :

```
addiu r29, r29, -32
sw    28(r29), r31
```

the `sw 28(r29), r31` instruction needs the value of `r29` beacause it stores `r31`
in the address `mem[r29 + 28]`. But `r29` is modified by `addiu r29, r29, -32`. Hence,
the result of `r29` is forwarded from the ALU directly.

> Can you identify a special case for the lw instruction?

For the `lw` instruction, there is a memory access that cannot be forwarded. As a
result, there is systematically a stalling after a `lw` if the loaded value is used.

Here is the screenshot :

![stall lw](../images/lw-stalling.png)

> When you look at the pipeline diagram, you will see quite a few instructions that do not
> complete their execution. When you look at the pipeline diagram, you will see quite
> a few instructions that do not complete their execution. Explain why the respective
> instruction did not finish its execution

We can see a flush there :

![flush](../images/flush.png)

**explaination :**

When `beqz` is in the EX stage, the branch is taken but two instructions are
already in the pipeline. The first instruction after the branch is always
executed (that's why it is a `nop`). The second instruction is flushed if the
branch is taken.

> Have a close look at the way branches and jumps are handled. Can you find
> a difference with regard to the way these instructions are handled
> in comparison to the lecture?

In the processor as in the course, the new program counter is loaded when the
jump (or branch) is in the EX stage. Nevertheless, in the course, the two
folowing instructions that are in IF and ID stages are flushed if the branch
is taken. In this processor, **only the second is flushed** and the first is
still executed. That's why we can find a `nop` after branches and jumps.

## 4) Branch Prediction

> Simulate both configurations (with the 1-bit and the 2-bit saturation
> counting branch predictors respectively). Which branch predictor is doing better?

We have theses statistics :


|                  | 1-bit saturation predictor | 2-bits saturation predictor |
|------------------|:--------------------------:|:---------------------------:|
|correct prediction| 88                         |   99                        |
|mispredicted      | 37                         |   26                        |
|misprediction rate| 29,6%                      |   20,8%                     |

The 2-bits branch predictor is better.


> Is the winning predictor from the
> previous question always better than the other?


We have theses statistics :

**For the 2-bits predictor :**

```
bpc: 0x00001078 [120] tgts: [0x00001024] a:44 t/nt: 36/8 mp/cp: 9/35 mp-ratio: 0,2
bpc: 0x00001050 [80] tgts: [0x00001060] a:36 t/nt: 31/5 mp/cp: 7/29 mp-ratio: 0,19
bpc: 0x000010f4 [116] tgts: [0x000010b4] a:9 t/nt: 8/1 mp/cp: 2/7 mp-ratio: 0,22
bpc: 0x000011ac [44] tgts: [0x00001108] a:9 t/nt: 8/1 mp/cp: 2/7 mp-ratio: 0,22
bpc: 0x0000101c [28] tgts: [0x0000106c] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
bpc: 0x00001090 [16] tgts: [0x00001130] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
bpc: 0x00001128 [40] tgts: [0x00001000] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
bpc: 0x000010ac [44] tgts: [0x000010ec] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
bpc: 0x00001100 [0] tgts: [0x000011a4] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
bpc: 0x000011e8 [104] tgts: [0x00001098] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
```

**for the 1-bit predictor :**

```
bpc: 0x00001078 [120] tgts: [0x00001024] a:44 t/nt: 36/8 mp/cp: 16/28 mp-ratio: 0,36
bpc: 0x00001050 [80] tgts: [0x00001060] a:36 t/nt: 31/5 mp/cp: 11/25 mp-ratio: 0,31
bpc: 0x000010f4 [116] tgts: [0x000010b4] a:9 t/nt: 8/1 mp/cp: 2/7 mp-ratio: 0,22
bpc: 0x000011ac [44] tgts: [0x00001108] a:9 t/nt: 8/1 mp/cp: 2/7 mp-ratio: 0,22
bpc: 0x0000101c [28] tgts: [0x0000106c] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
bpc: 0x00001090 [16] tgts: [0x00001130] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
bpc: 0x00001128 [40] tgts: [0x00001000] a:8 t/nt: 8/0 mp/cp: 1/7 mp-ratio: 0,12
bpc: 0x000010ac [44] tgts: [0x000010ec] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
bpc: 0x00001100 [0] tgts: [0x000011a4] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
bpc: 0x000011e8 [104] tgts: [0x00001098] a:1 t/nt: 1/0 mp/cp: 1/0 mp-ratio: 1
```

As we can see, the 2-bits predictor is better on the branch instructions at addresses
`0x1078` and `0x1050` for the other branches, there is no difference.

> Can you characterize the behavior of these two branches, i.e., what
> is the typical branch direction for both of them?

This is the code for the branch at `0x1078` :

```
    int i,minIdx = 0;
    for(i = 0; i < n; i++)
1060:       8fc20008        lw      v0,8(s8)
1064:       24420001        addiu   v0,v0,1
1068:       afc20008        sw      v0,8(s8)
106c:       8fc30008        lw      v1,8(s8)
1070:       8fc2001c        lw      v0,28(s8)
1074:       0062102a        slt     v0,v1,v0
1078:       1440ffea        bnez    v0,1024 <minIndex+0x24>
107c:       00000000        nop
```

This branch is a return to the top of a `for` instruction. So it is a branch
that is often taken (n == 8). Nevertheless, this is a for in a upper loop.
The difference in the two prediction rates for this branch comes from the fact
that the 1-bit predictor will predict untaken at the first time it gets back
in this loop (because it was untaken when it left it the last time). While 
the 2-bits predictor will predict taken even if the last time it was untaken
(because of the persistency).


```
    if (array[i] < array[minIdx])
1024:       8fc20008        lw      v0,8(s8)
1028:       00021080        sll     v0,v0,0x2
102c:       8fc30018        lw      v1,24(s8)
1030:       00621021        addu    v0,v1,v0
1034:       8c430000        lw      v1,0(v0)
1038:       8fc2000c        lw      v0,12(s8)
103c:       00021080        sll     v0,v0,0x2
1040:       8fc40018        lw      a0,24(s8)
1044:       00821021        addu    v0,a0,v0
1048:       8c420000        lw      v0,0(v0)
104c:       0062102a        slt     v0,v1,v0
1050:       10400003        beqz    v0,1060 <minIndex+0x60>
1054:       00000000        nop
```

This case is more complicated. When we look if the next element of the list is lower
than the minimum of the beginning of the list, there are more chance that it is
not true. That means there is a trend to taken branch and the 2-bits predictor is
better when there is a trend than the 1-bit predictor.

> Explain why the 2-bit branch predictor mispredicts the branch direction of the first
> branch 9 times and the 1-bit predictor 16 times?

The 1-bit predictor mispredicts 16 times the `0x1078` branch because it mispredicts
2 times each time the `minIndex` function is called (at the entrance and the exit).
Moreover `minIndex` is called 8 times in the program, so it makes 16 mispredictions.

As for the 2-bits predictor, it mispredicts the first time he goes in `minIndex` and
every time it exits the `minIndex` loop.

> Determine the penalties
> of taken/untaken branches when predicted correctly/mispredicted.

**taken branch :**

* **correctly predicted :** 0 cycle of penalty as we don't flush the next following
instruction
* **mispredicted :** 1 cycle of penalty as we flush only the second instruction after
the branch


**untaken branch :**

* **correctly predicted :** 0 cycle of penalty
* **mispredicted :** 1 cycle of penalty we only flush the predicted instruction

> Explain the difference
> to the way branch prediction was explained in the lecture.

Once again, the difference is that we do not flush the instruction following the
branch. However, even if we have 1 less penalty, we often execute a `nop` after 
a branch. There would be a real improvment if the compilator would optimize the
order of the instruction according to this instruciton always executed in 
order that it would not be always a `nop`.

## 5) Data Caches

> Activate the accurate simulation of memory access latencies by editing both
> configuration files. What changed with regard to the simulations before?

Now, a memory acces takes 5 cycles due to latency.
There are a lot of stallings.

> Simulate the configuration with the 1-bit branch predictor.
> summarize the behavior of the data cache, e.g.,
> give numbers related to the hit/miss rate,
> number of access, et cetera.

| cache type | hit number| miss number|  hit rate  |number of access|loaded words |
|------------|:---------:|:----------:|:----------:|:--------------:|:-----------:|
| I cache    |    3668   |    310     |    92,21%  |     3978       |  620        |
| D cache    |    220    |    279     |    44,09%  |     499        |  279        |


> What is the total size of the cache?


| cache type | total size|
|------------|:---------:|
| I cache    | 256 octets|
| D cache    | 16 octets |


> Rerun the simulation for increasing numbers of cache lines : 4, 8, 16, 32, and 64.
> How does the size of the cache develop and how does the cache hit/miss rate change?

For the D cache :

|total bloc number| total size | hit rate |
|-----------------|:----------:|:--------:|
|      4          | 16 octets  | 44,09%   |
|      8          | 32 octets  | 76,35%   |
|      16         | 64 octets  | 82,2%    |
|      32         | 128 octets | 98,4%    |
|      64         | 256 octets | 98,4%    |

The cache size is just `bloc number * bloc size`.

The hit rate grows with the number of bloc. However, we cannot go over 98,4% because
of the compulsory misses at the beginning.


> Which configuration performs best, with regard to the cache size.

Regarding to the results, the best configuration is 32 blocs.

> Rerun the simulation for increasing
> associativity 2, 4, and 8, using the replacement policies
> FIFO and LRU. Set the total number of cache blocks
> to 8. How does the hit/miss rate compare to the direct-mapped
> cache with the same total
> size from before?

|associativity|   FIFO   |   LRU    |
|:-----------:|:--------:|:--------:|
|     2       | 74,55%   | 77,35%   |
|     4       | 83,97%   | 83,58%   |
|     8       | 83,37%   | 87,58    |

Hit rate increase with the associativity.

> Rerun the simulation for increasing block size
> 4, 8, 16, and 32, using a 4-way set-associative cache with LRU
> replacement. Set the total number of cache blocks to 8. How does the hit/miss rate
> compare to the caches with the same total size from above?

|bloc size| hit rate |
|:-------:|:--------:|
|   4     | 85,97    |
|   8     | 96,8     |
|   16    | 99,6     |
|   32    | 99,6     |

We notice that there are no changes between bloc sizes 16 and 32 while the size of
input is 32 (so there should be only one compulsory miss with bloc size 32).
It is because the data is not aligned on a 32 bytes address (`0x11210`).

In both cases we need 2 blocs of data :
* 16 bytes : `0x11210 + 0x11220`
* 32 bytes : `0x11200 + 0x11220`

> Have a look at the C code of the program. How is data accessed by the program?

The data is accessed linearly from the first address.

> Is data reused frequently?

Yes data is reused frequently.

> Which kind of cache miss (compulsory, capacity, conflict) do you
> believe dominates the cache’s performance for this (small) program?

We never have conflict miss because we fill our cache linearly. If
the size of the cache is greater than the size of the data (32 bytes), then 
we only have compulsory misses. If the size of the data is greater than the size
of the cache, then we mostly have capacity misses.


> How much data is
> actually accessed by the program?

32 bytes for `input` and 32 bytes for `buf`.


