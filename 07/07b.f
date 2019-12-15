/ Decimal numbers /
∇ SIGN / a→na / ↑ C@ 2D = { 1+ 1 ¯ | 1 } ↕ ∇
∇ UNUM / a→na / 0 ↕ ( ↑ C@ ↑ 2C > ∥ 30 - ⌽ A × + ↕ 1+ ) ↓ 1+ ∇ / Read next decimal number /
∇ NUM / a→na / SIGN UNUM -⌽ × ↕ ∇
∇ DEC' / n→n / 0 ↕ ( A ÷MOD -⌽ ↕ 8 << ∨ ↕ ↑ ∥) ↓ ∇
∇ DEC / n→n / DEC' ↑ CLZ 7 ~ ∧ << 40⌽ ∇ / 4D2 DEC → 01020304 /

/ Vectors /
/ Define vectors VV which depend on a global 'mode' K labelling which amplifier is being run /
/ Vector still accessed as 'i v' but will access the ith element *of the Kth amplifier's memory* /
/ So no code for the little machine needs changing /
5 CONST N
VAR K 0 K !
∇ V ◁ CELLS ALLOT ▷ ↕ CELLS + ∇
∇ VV ◁ ↑ , N × CELLS ALLOT ▷ ↑ @ ⌽ ↕ K @ × + CELLS + 8+ ∇
∇ SETONE / aa→aa / NUM -⌽ ⊤ ! 8+ ↕ ∇
∇ SETV / aa→ / ( SETONE ↑ C@ ∥) 2↓ ∇
∇ READF / an→a / ↓ 0 ↕ ⍐ 8000 H ⌽ ⍇ H + 0 ↕ ! H ∇ / Read file and put zero byte at the end /
∇ READV READF SETV ∇

2A6 VV μ
∇ μ0 0 μ S" input.txt" READV ∇

VAR IN  / Use a stack for amplifiers' communication /
4000 CELLS ALLOT             / Bug later - amplifiers overflow the input stack /
H ↑ IN ! 4000 CELLS ALLOT    / Temporarily just allocate lots of memory /   
∇ PUSH IN @ ! IN @ 8- IN ! ∇
∇ POP IN @ 8+ IN ! IN @ @ ∇
∇ ISWAP POP POP >R PUSH R> PUSH ∇

/ Set up instruction table ι /
/ Use top byte of function pointer to store number of arguments /

∇ INCR / n→ / m + 1+ m! ∇
∇ ARGS 40⌽ ∨ ∇

VAR MAX 0 MAX !
∇ NEWMAX MAX @ ⌈⌊ MAX ! ↓ ∇

9 V ι
⊂ QUIT ⊃                                    0 ARGS      0 ι !
⊂ + ↕ μ ! INCR ⊃                            3 ARGS      1 ι !
⊂ × ↕ μ ! INCR ⊃                            3 ARGS      2 ι !
⊂ POP ↑ 8 SPACES . CR ↕ μ ! INCR ⊃          1 ARGS      3 ι !
⊂ ↑ . CR ↑ NEWMAX PUSH INCR ISWAP ↓ ABORT ⊃ 1 ARGS      4 ι !
⊂ { m! | ↓ INCR } ⊃                         2 ARGS      5 ι !
⊂ { ↓ INCR | m! } ⊃                         2 ARGS      6 ι !
⊂ > ↕ μ ! INCR ⊃                            3 ARGS      7 ι !
⊂ = ↕ μ ! INCR ⊃                            3 ARGS      8 ι !

/ Little machine /
∇ DECODE' m μ @ 2710 + DEC ∇ / Set all third arguments to immediate /
∇ FIX ↑ FF ∧ 3 = 10 << + ∇ / Set opcode 3 argument to immediate /
∇ DECODE DECODE' FIX ∇
∇ FETCH FF ∧ 9 MOD ι @ ∇
∇ SPLIT / n→nn / FFFFFFFF ~ 2↑ ∧ -⌽ ~ ∧ ∇

∇ ARG' / nn→n / m + μ @ ↕ 0 = { μ @ } ∇
∇ MODE / n→n / H 1+ + C@ ∇
∇ ARG / n→n / ↑ MODE ↕ ARG' ∇
∇ GETARGS / n→? / (( n ARG )) ∇

∇ RUNONE SPLIT >R 40⌽ ↑ GETARGS R> ⍎ ∇

∇ CYCLE DECODE ↑ H ! FETCH RUNONE ∇
∇ RUN' ( CYCLE 1∥) ∇
∇ RUN ['] RUN' CATCH ↓ ∇

5 V M / Store program counter of each amplifier /
∇ mSAVE m K @ M ! ∇
∇ mLOAD K @ M @ m! ∇

∇ LOOP1 / First loop - read phase and input /
0 K ! mLOAD RUN mSAVE
1 K ! mLOAD RUN mSAVE
2 K ! mLOAD RUN mSAVE
3 K ! mLOAD RUN mSAVE
4 K ! mLOAD RUN mSAVE
∇

∇ LOOP2 / Subsequent loops - just read input /
0 K ! mLOAD RUN mSAVE POP ↓
1 K ! mLOAD RUN mSAVE POP ↓
2 K ! mLOAD RUN mSAVE POP ↓
3 K ! mLOAD RUN mSAVE POP ↓
4 K ! mLOAD RUN mSAVE POP ↓
∇

∇ LOOPS LOOP1 POP 2↓ ( LOOP2 1∥) ∇
∇ INIT PUSH PUSH PUSH PUSH PUSH 0 PUSH ISWAP ∇
∇ TRY INIT LOOPS ∇

/ Permutations /
5 V v
5 0 v !  6 1 v !  7 2 v !  8 3 v !  9 4 v !

∇ CHECK ↑ 0 v < { QUIT } ∇
∇ f / an→an / ( ↕ 8- CHECK ↑ @ ⌽ ⊤ < ∥) ∇
∇ g / ann→ann / ( ↓ ↕ 8- ↑ @ ⌽ ↕ 2↑ > ∥) 2↓ ∇
∇ V↕ / aa→ / 2↑ @ >R @ ↕ ! R> ↕ ! ∇
∇ V⌽ / aa→ / ( 2↑ V↕ 8- ↕ 8+ ↕ 2↑ ≤ ∥) 2↓ ∇
∇ F 4 v ↑ @ f ∇
∇ G 4 v 8+ ↕ 0 g ∇
∇ PERM F G ⊤ V↕ 8+ 4 v V⌽ ∇

∇ RESET
    0 K ! μ0 1 K ! μ0 2 K ! μ0 3 K ! μ0 4 K ! μ0 / Reset amplifier memory /
    0 0 M ! 0 1 M ! 0 2 M ! 0 3 M ! 0 4 M ! ∇    / Reset program counter store /

∇ VPUSH 0 v @ 1 v @ 2 v @ 3 v @ 4 v @ ∇

/ Little machine currently QUITs when done  /
/ This would break out of a loop to try all permutations after the first try /
/ For now just try 120 times in the interpreter /
/ Should rewrite to use exceptions and a loop /
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM
RESET VPUSH TRY PERM

CR CR MAX ?
