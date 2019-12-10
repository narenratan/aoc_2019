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

/ Plan: Use     μ as memory /
/               ι as instruction table (vector of execution tokens) /
/               m register as program counter /

2A6 V μ
0 μ H" input.txt" READV
VAR IN 1 IN !

/ Set up instruction table ι /
/ Use top byte of function pointer to store number of arguments /

∇ ARGS 40⌽ ∨ ∇
5 V ι
⊂ QUIT ⊃                    0 ι !
⊂ + ↕ μ ! ⊃     3 ARGS      1 ι !
⊂ × ↕ μ ! ⊃     3 ARGS      2 ι !
⊂ IN @ ↕ μ ! ⊃  1 ARGS      3 ι !
⊂ . CR ⊃        1 ARGS      4 ι !

/ Little machine /
∇ DECODE' m μ @ 2710 + DEC ∇ / Set all third arguments to immediate /
∇ FIX ↑ FF ∧ 3 = { 010000 + } ∇ / Set opcode 3 argument to immediate /
∇ DECODE DECODE' FIX ∇
∇ FETCH FF ∧ 9 MOD ι @ ∇
∇ SPLIT / n→nn / FFFFFFFF ~ 2↑ ∧ -⌽ ~ ∧ ∇

∇ ARG' / nn→n / m + μ @ ↕ 0 = { μ @ } ∇
∇ MODE / n→n / H 1+ + C@ ∇
∇ ARG / n→n / ↑ MODE ↕ ARG' ∇
∇ GETARGS / n→? / (( n ARG )) ∇

∇ RUNONE SPLIT >R 40⌽ ↑ GETARGS R> ⍎ ∇
∇ INCR / n→ / m + 1+ m! ∇

∇ CYCLE DECODE ↑ H ! FETCH RUNONE INCR ∇
∇ RUN ( CYCLE 1∥) ∇

RUN

