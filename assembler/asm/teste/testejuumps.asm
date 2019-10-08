inicio:
wea  $1, $5(%zero)
lea $4(%zero), %t0
andi $1, %t0, %t1
addi $5, %zero, %t6
wea  %t6, $6(%zero)
wea  %t1, $11(%zero)
jg %t1, inicio
jump2:
lea $2(%zero), %t2
andi $1, %t2, %t3
addi $2, %zero, %t7
wea  %t7, $6(%zero)
wea  %t3, $10(%zero)
jg %t3, jump2
jmp inicio