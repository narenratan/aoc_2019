step:"UDRL"!(0 1;0 -1;1 0;-1 0)
steps:{(("J"$1_x),2)#step[first x]}'
paths:(((+\)(,/)steps@)')","vs/:(0:)`input.txt
ints:(inter/)paths
(&/)(+/)flip abs ints
min(+/)ints {1+first where x~/:y}\:/: paths
