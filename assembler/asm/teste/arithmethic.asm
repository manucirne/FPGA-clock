#====================================================================
# Nome: David & Manoela & Wesley
#
# Função do programa: Clock com cronometro
#
#====================================================================

#====================================================================
#       Inicialização dos dados de alocação estática
#====================================================================


#====================================================================
#       Programa
#====================================================================

inicio:
addi $1, %t0, %t0
wea  %t0, $11(%zero)
addi $1, %t0, %t0
wea  %t0, $10(%zero)
addi $1, %t0, %t0
wea  %t0, $9(%zero)
addi $1, %t0, %t0
wea  %t0, $8(%zero)
addi $1, %t0, %t0
wea  %t0, $7(%zero)
addi $1, %t0, %t0
wea  %t0, $6(%zero)
jmp inicio