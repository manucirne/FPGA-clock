inicio:
addi $15, %zero, %t0
addi $1 , %zero, %t1
tcheka:
wea %t0, $6(%zero)
lea $0(%zero), %t2
je %t2, tcheka
sub %t0, %t1, %t0
wea %t1, $1(%zero) 
jmp tcheka