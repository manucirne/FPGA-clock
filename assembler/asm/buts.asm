inicio:
lea $4(%zero), %t0
andi $0, %t0, %t1
wea  %t0, $11(%zero)
jmp inicio