∇ READONE / a→na / 0 ↕ ( ↑ C@ ↑ 0A ≠ ∥ 30 - ⌽ A × + ↕ 1+ ) ↓ 1+ ∇  / Read next decimal number /
∇ FUEL 3 ÷ 2 - ∇
∇ ALLFUEL / na→n / ( READONE -⌽ FUEL + ↕ ↑ C@ ∥) ↓ ∇ / Add fuel until next byte is zero /

0 H" input.txt" ↓ ⍐ 1000 H ⌽ ⍇ H + 0 ↕ ! / Read file and put zero byte at the end /
0 H ALLFUEL .
