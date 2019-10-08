inicio:
lea $2(%zero), %t0
andi $1, %t0, %t1
wea  %t1, $11(%zero)
wea  $1, $5(%zero)
jmp inicio