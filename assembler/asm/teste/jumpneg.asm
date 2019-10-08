inicio:
wea  $1, $5(%zero)
lea $4(%zero), %t0
andi $1, %t0, %t1
sub %zero, %t1, %t5
addi $5, %zero, %t6
wea  %t6, $6(%zero)
wea  %t5, $11(%zero)
jn %t5, inicio
jump2:
lea $2(%zero), %t2
andi $1, %t2, %t3
addi $2, %zero, %t7
sub %zero, %t3, %t4
wea  %t7, $6(%zero)
wea  %t4, $10(%zero)
jn %t4, jump2
jmp inicio