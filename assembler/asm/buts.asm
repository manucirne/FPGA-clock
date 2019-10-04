inicio:
lea $4(%zero), %t0
andi $1, %t0, %t1
wea  %t0, $11(%zero)
jmp inicio