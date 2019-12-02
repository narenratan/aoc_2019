/ Vectors /
∇ V ◁ ↑ , CELLS ALLOT ▷ 8+ ∇                / Defining word /
∇ ' H ! ↑ 8- @ (( ↑ @ H @ ⍎ ⊤ ! 8+ )) ↓ ∇   / Each /
∇ ⌿ H ! ↑ 8- @ (( ↑ @ ⌽ H @ ⍎ ↕ 8+ )) ↓ ∇   / Over /

∇ READONE / a→na / 0 ↕ ( ↑ C@ ↑ 0A ≠ ∥ 30 - ⌽ A × + ↕ 1+ ) ↓ 1+ ∇ / Read next decimal number /
∇ SETONE / aa→aa / READONE -⌽ ⊤ ! 8+ ↕ ∇
∇ SETV / aa→ / ( SETONE ↑ C@ ∥) 2↓ ∇
∇ READF / an→a / ↓ 0 ↕ ⍐ 1000 H ⌽ ⍇ H + 0 ↕ ! H ∇ / Read file and put zero byte at the end /
∇ READV READF SETV ∇

64 V μ
μ H" input.txt" READV

μ ⊂ 3 ÷ 2 - ⊃ ' 0 μ ⊂ + ⊃ ⌿ . CR

∇ FUEL 3 ÷ 2 - ∇
∇ +FUEL / nn → nn / FUEL ↑ ⌽ + ↕ ∇
∇ FUELTOT / n → n / FUEL ↑ ( ↑ 0> ∥ +FUEL ) - ∇

μ H" input.txt" READV

μ ⊂ FUELTOT ⊃ ' 0 μ ⊂ + ⊃ ⌿ . CR
