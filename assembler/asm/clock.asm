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
# O padrão de horário é 12:59

# rl0 -> Horas dezena
# rl1 -> Horas unidade

# rl2 -> Minutos dezena
# rl3 -> Minutos unidade

# rl4 -> Segundos dezena
# rl5 -> Segundos unidade

# mod -> Modifica hora e minuto

# am -> AM / PM (Se am==0 => Modo 12 hras)

addi $0, %zero, %rl0
addi $0, %zero, %rl1
addi $0, %zero, %rl2
addi $0, %zero, %rl3
addi $0, %zero, %rl4
addi $0, %zero, %rl5

addi $0, %zero, %am

loop:

lea $3(%zero), %t0 # Switch de am/pm
andi $2, %t0, %t0
xori $2, t0, %am # Xor com a máscara

lea $3(%zero), %t1 # Switch de modificação
andi $1, %t1, %t1
xori $1, t1, %mod # Xor com a máscara
je %mod, modifica

base:
lea $0(%zero), %t0 # Base de tempo
je %t0, display # Se a base de tempo != realiza jump
addi $1, %t1, %t1
wea %t1, $1(%zero) # Faz a leitura da base de tempo
addi $1, %rl5, %rl5 # Adiciona 1 segundo

# Se não estourar os segundos acaba os ajustes
# Se chegar no limite, zera a unidade dos segundos
# Adiciona 1 na dezena de segundos
ajuste:
subi $10, %rl5, %t0
jg %t0, display
andi $0, %rl5, %rl5
addi $1, %rl4, %rl4

# Verifica se estourou a dezena de segundos
subi $6, %rl4, %t0
jg %t0, display
andi $0, %rl4, %rl4

# Incrementa um minuto
addi $1, %rl3, %rl3


ajusteMinuto:
subi $10, %rl3, %t0
jg %t0, display
andi $0, %rl3, %rl3

# Incrementa a dezena de minuto
addi $1, %rl2, %rl2 

# Verifica se estourou a dezena de minutos
subi $6, %rl2, %t0
jg %t0, display
andi $0, %rl2, %rl2

# Adiciona uma hora
addi $1, %rl1, %rl1 

# Verifica se a unidade de horas passou de 9
subi $10, %rl1, %t0
jg %t0, ajuste12
andi $0, %rl1, %rl1
addi $1, %rl0, %rl0

# Verifica se a hora chegou em 12
ajuste12:
xori $1, %rl0, %t0
xori $2, %rl1, %t1
add %t0, %t1, %t0
jg %t0, display

# Zera as horas
andi $0, %rl1, %rl1
andi $0, %rl0, %rl0

# Colocar tudo no display
display:
jg %am, ajuste24 # Se am != 0 vai para o modo 24 hras
wea %rl0, $11(%zero)
wea %rl1, $10(%zero)
wea %rl2, $9(%zero)
wea %rl3, $8(%zero)
wea %rl4, $7(%zero)
wea %rl5, $6(%zero)
jmp loop

ajuste24:
# Adiciona 2 horas na unidade
addi $2, %rl1, %t1
# Se passou de 10, a dezena é 2, e a unidade é o resto
subi $10, %t1, %t2
jg %t2, display24
addi $1, %rl0, %t0
addi $0, %t2, %t1
# Adiciona 1 na hora
display24:
addi $1, %rl0, %t0
wea %t0, $11(%zero)
wea %t1, $10(%zero)
wea %rl2, $9(%zero)
wea %rl3, $8(%zero)
wea %rl4, $7(%zero)
wea %rl5, $6(%zero)
jmp loop


modifica:
lea $4(%zero), %t0 # Botão soma
andi $1, %t0, %t0
xori $1, %t0, %t0 # Xor com a base de tempo
addi $1, %zero, %t1
wea %t1, $5(%zero) # Clear do botão

jg %t0, loop
addi $1, %rl3, %rl3
jmp ajusteMinuto

# iniciaCronometro:
# addi $0, %zero, %cr0
# addi $0, %zero, %cr1
# addi $0, %zero, %cr2
# addi $0, %zero, %cr3
# addi $0, %zero, %cr4
# addi $0, %zero, %cr5
# cronometro:
# jmp cronometro