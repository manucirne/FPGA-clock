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

addi $1, %zero, %rl0
addi $2, %zero, %rl1
addi $0, %zero, %rl2
addi $0, %zero, %rl3
addi $0, %zero, %rl4
addi $0, %zero, %rl5
addi $0, %zero, %rl6
addi $0, %zero, %rl7

addi $0, %zero, %am
addi $0, %zero, %pm

loop:

lea $2(%zero), %t1 # Switch de modificação
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
addi $1, %rl7, %rl7

ajustaHora:
# Verifica se a unidade de horas passou de 9 no reg de 12
subi $10, %rl1, %t0
jg %t0, ajuste924
andi $0, %rl1, %rl1
addi $1, %rl0, %rl0

# Verifica se a unidade de horas passou de 9 no reg de 24
ajuste924:
subi $10, %rl7, %t1
jg %t1, ajuste12
andi $0, %rl7, %rl7
addi $1, %rl6, %rl6

# Verifica se a hora chegou em 12
ajuste12:
xori $1, %rl0, %t0
xori $3, %rl1, %t1
add %t0, %t1, %t0
jg %t0, ajuste24

# Zera as horas
andi $0, %rl0, %rl0
addi $1, %zero, %rl1
xori $1, %pm, %pm 

# Verifica se a hora chegou em 24
ajuste24:
xori $2, %rl6, %t0
xori $4, %rl7, %t1
add %t0, %t1, %t0
jg %t0, display

# Zera as horas
andi $0, %rl6, %rl6
andi $0, %rl7, %rl7

addi $1, %pm, %pm
xori $2, %pm, %t0
jg %pm, display
add %zero, %zero, %pm

# Colocar tudo no display 12
display:
lea $2(%zero), %t0 # Switch de am/pm
andi $2, %t0, %t0
xori $2, t0, %am # Xor com a máscara
jg %am, display24 # Se am != 0 vai para o modo 24 hras

jg %pm, botaPM
addi $10, %zero, %40
jmp display12
botaPM:
addi $11, %zero, %40

display12:
wea %40, $12(%zero) 
wea %rl0, $11(%zero)
wea %rl1, $10(%zero)
wea %rl2, $9(%zero)
wea %rl3, $8(%zero)
wea %rl4, $7(%zero)
wea %rl5, $6(%zero)
jmp loop

# Colocar tudo no display 24
display24:
addi $12, %zero, %40
wea %40,  $12(zero)
wea %rl6, $11(%zero)
wea %rl7, $10(%zero)
wea %rl2, $9(%zero)
wea %rl3, $8(%zero)
wea %rl4, $7(%zero)
wea %rl5, $6(%zero)
jmp loop

# sjuste de hora 
modifica:
lea $4(%zero), %t0 # Botão soma
andi $1, %t0, %t0
xori $1, %t0, %t0 # Xor com a base de tempo
addi $1, %zero, %t1
wea %t1, $5(%zero) # Clear do botão

jg %t0, buthora
addi $1, %rl3, %rl3
jmp ajusteMinuto

buthora:
lea $4(%zero), %t2 # Botão soma
andi $2, %t2, %t2
xori $2, %t2, %t2 # Xor com a base de tempo
addi $2, %zero, %t3
wea %t3, $5(%zero) # Clear do botão

jg %t2, display # Se o botão não for ativado, jump para p display
addi $1, %rl1, %rl1 # Adiciona 1 no registrador de 12h
addi $1, %rl7, %rl7 # Adiciona 1 no registrador de 24h
jmp ajustaHora

