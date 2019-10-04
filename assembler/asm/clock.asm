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

# rl0 -> Horas dezena
# rl1 -> Horas unidade

# rl2 -> Minutos dezena
# rl3 -> Minutos unidade

# rl4 -> Segundos dezena
# rl5 -> Segundos unidade

# rl6 -> AM / PM 

addi $0, %zero, %rl0
addi $0, %zero, %rl1
addi $0, %zero, %rl2
addi $0, %zero, %rl3
addi $0, %zero, %rl4
addi $0, %zero, %rl5
addi $0, %zero, %rl6

loop:

segundo:
lea $0(%zero), %t0 # Base de tempo
xori $0, %t0, %t1 # Xor com a base de tempo
je %t1, prox # Se a base de tempo != realiza jump
wea $1, $0(%zero) # Faz a leitura da base de tempo
addi $1, %rl5, %rl5

prox:
addi $1, %rl5, %rl5
jmp loop