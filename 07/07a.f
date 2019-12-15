/ Decimal numbers /
∇ SIGN / a→na / ↑ C@ 2D = { 1+ 1 ¯ | 1 } ↕ ∇
∇ UNUM / a→na / 0 ↕ ( ↑ C@ ↑ 2C > ∥ 30 - ⌽ A × + ↕ 1+ ) ↓ 1+ ∇ / Read next decimal number /
∇ NUM / a→na / SIGN UNUM -⌽ × ↕ ∇
∇ DEC' / n→n / 0 ↕ ( A ÷MOD -⌽ ↕ 8 << ∨ ↕ ↑ ∥) ↓ ∇
∇ DEC / n→n / DEC' ↑ CLZ 7 ~ ∧ << 40⌽ ∇ / 4D2 DEC → 01020304 /

/ Vectors /
∇ V ◁ CELLS ALLOT ▷ ↕ CELLS + ∇
∇ SETONE / aa→aa / NUM -⌽ ⊤ ! 8+ ↕ ∇
∇ SETV / aa→ / ( SETONE ↑ C@ ∥) 2↓ ∇
∇ READF / an→a / ↓ 0 ↕ ⍐ 8000 H ⌽ ⍇ H + 0 ↕ ! H ∇ / Read file and put zero byte at the end /
∇ READV READF SETV ∇

2A6 V μ
∇ μ0 0 μ S" input.txt" READV ∇

VAR IN
20 CELLS ALLOT
H ↑ IN ! 10 CELLS ALLOT
∇ PUSH IN @ ! IN @ 8- IN ! ∇
∇ POP IN @ 8+ IN ! IN @ @ ∇
∇ ISWAP POP POP >R PUSH R> PUSH ∇

∇ RESET μ0 m0 ∇
RESET

/ Set up instruction table ι /
/ Use top byte of function pointer to store number of arguments /

∇ INCR / n→ / m + 1+ m! ∇
∇ ARGS 40⌽ ∨ ∇

VAR MAX 0 MAX !
∇ NEWMAX MAX @ ⌈⌊ MAX ! ↓ ∇

9 V ι
⊂ 42 EMIT QUIT ⊃                        0 ARGS      0 ι !
⊂ + ↕ μ ! INCR ⊃                        3 ARGS      1 ι !
⊂ × ↕ μ ! INCR ⊃                        3 ARGS      2 ι !
⊂ POP ↕ μ ! INCR ⊃                      1 ARGS      3 ι !
⊂ ↑ . CR ↑ NEWMAX PUSH ISWAP ↓ ABORT ⊃  1 ARGS      4 ι !
⊂ { m! | ↓ INCR } ⊃                     2 ARGS      5 ι !
⊂ { ↓ INCR | m! } ⊃                     2 ARGS      6 ι !
⊂ > ↕ μ ! INCR ⊃                        3 ARGS      7 ι !
⊂ = ↕ μ ! INCR ⊃                        3 ARGS      8 ι !

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
∇ NRUN ( RUN RESET 1- ↑ ∥) ↓ ∇

∇ TRY 5 (( PUSH )) 0 PUSH ISWAP 5 NRUN POP 2↓ ∇

/ Permutations /
5 V v
0 0 v !  1 1 v !  2 2 v !  3 3 v !  4 4 v !  

∇ CHECK ↑ 0 v < { QUIT } ∇
∇ f / an→an / ( ↕ 8- CHECK ↑ @ ⌽ ⊤ < ∥) ∇
∇ g / ann→ann / ( ↓ ↕ 8- ↑ @ ⌽ ↕ 2↑ > ∥) 2↓ ∇
∇ V↕ / aa→ / 2↑ @ >R @ ↕ ! R> ↕ ! ∇
∇ V⌽ / aa→ / ( 2↑ V↕ 8- ↕ 8+ ↕ 2↑ ≤ ∥) 2↓ ∇
∇ F 4 v ↑ @ f ∇
∇ G 4 v 8+ ↕ 0 g ∇
∇ PERM F G ⊤ V↕ 8+ 4 v V⌽ ∇

∇ VPUSH 0 v @ 1 v @ 2 v @ 3 v @ 4 v @ ∇
∇ PTRY ( VPUSH TRY PERM 1- ↑ ∥) ∇

PTRY 77 PTRY
CR CR MAX ?
