/ Vectors /
∇ V ◁ CELLS ALLOT ▷ ↕ CELLS + ∇

∇ READONE / a→na / 0 ↕ ( ↑ C@ ↑ 2C > ∥ 30 - ⌽ A × + ↕ 1+ ) ↓ 1+ ∇ / Read next decimal number /
∇ SETONE / aa→aa / READONE -⌽ ⊤ ! 8+ ↕ ∇
∇ SETV / aa→ / ( SETONE ↑ C@ ∥) 2↓ ∇
∇ READF / an→a / ↓ 0 ↕ ⍐ 1000 H ⌽ ⍇ H + 0 ↕ ! H ∇ / Read file and put zero byte at the end /
∇ READV READF SETV ∇

/ Plan: Use     μ as memory /
/               ι as instruction table (vector of execution tokens) /
/               n register as program counter /

75 V μ
0 μ H" input.txt" READV
C 1 μ ! 2 2 μ ! 

/ Set up instruction table ι /
3 V ι
⊂ 0 μ @ . QUIT ⊃ 0 ι !
⊂ + ⊃ 1 ι !
⊂ × ⊃ 2 ι !

/ Little machine /
∇ FETCH 3 MOD ι @ ∇ / 99 3 MOD is 0 → can use 3 MOD to index instruction table /
∇ GET μ @ μ @ ∇
∇ RUNONE n 1+ GET n 2 + GET n μ @ FETCH ⍎ ∇
∇ UPDATE n 3 + μ @ μ ! ∇
∇ INCR 4 n + n! ∇
∇ CYCLE RUNONE UPDATE INCR ∇
∇ RUN ( CYCLE 1∥) ∇

RUN
