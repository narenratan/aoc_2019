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
3CD V μ
1000 CELLS ALLOT
∇ μ0 0 μ S" input.txt" READV ∇
μ0

/ Set up instruction table ι /
/ Use top byte of function pointer to store number of arguments /

∇ INCR / n→ / m + 1+ m! ∇
∇ ARGS 40⌽ ∨ ∇

VAR IN 2 IN !
VAR RB 0 RB !

A V ι
⊂ QUIT ⊃                                0 ARGS      0 ι !
⊂ + ↕ μ ! INCR ⊃                        3 ARGS      1 ι !
⊂ × ↕ μ ! INCR ⊃                        3 ARGS      2 ι !
⊂ IN @ ↕ μ ! INCR ⊃                     1 ARGS      3 ι !
⊂ . CR INCR ⊃                           1 ARGS      4 ι !
⊂ { m! ↓ | ↓ INCR } ⊃                   2 ARGS      5 ι !
⊂ { ↓ INCR | m! ↓ } ⊃                   2 ARGS      6 ι !
⊂ > ↕ μ ! INCR ⊃                        3 ARGS      7 ι !
⊂ = ↕ μ ! INCR ⊃                        3 ARGS      8 ι !
⊂ RB @ + RB ! INCR ⊃                    1 ARGS      9 ι !

/ Little machine /
∇ DECODE' m μ @ 2710 + DEC ∇ / Set all third arguments to immediate /
∇ FIX ↑ FF ∧ 3 = 10 << + ∇ / Set opcode 3 argument to immediate /
∇ DECODE DECODE' FIX ∇
∇ FETCH FFFF ∧ 0909 MOD ι @ ∇
∇ SPLIT / n→nn / FFFFFFFF ~ 2↑ ∧ -⌽ ~ ∧ ∇

/ Parameter mode vector /
4 V κ
⊂ μ @ ⊃         0 κ !
⊂ ⊃             1 κ !
⊂ RB @ + μ @ ⊃  2 κ !
⊂ RB @ + ⊃      3 κ !

∇ ARG' / nn→n / m + μ @ ↕ κ @ ⍎ ∇
∇ MODE / n→n / H 1+ + C@ ∇
∇ ARG / n→n / ↑ MODE ↕ ARG' ∇
∇ GETARGS / n→? / (( n ARG )) ∇

∇ RUNONE SPLIT >R 40⌽ ↑ GETARGS R> ⍎ ∇
∇ CYCLE DECODE ↑ H ! FETCH RUNONE ∇
∇ RUN ( CYCLE 1∥) ∇

RUN
