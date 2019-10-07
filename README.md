# FPGA-clock

## Introdução

## Arquitetura

A arquitetura do processador é registrador registrador.

## Fluxo de dados

[Fluxo de dados][fluxo-pdf]

![fluxo](/design/fluxo.svg)

## Instruction set

[Explicação das instruções][assembly]

```
ADDI $Imm, %B, %C
ADD  %C, %B, %A

ANDI $Imm, %B, %C,
AND  %C, %B, %A

XOR  %C, %B, %A
XORI $Imm, %B, %C

SUB  %C, %B, %A
SUBI $Imm, %B, %C

LEA $Imm(%B), (%C)
WEA (%C), $Imm(%B)

JMP %Imm (16bit)
JG   (%C), label
JN   (%C), label
JE   (%C), label
```

## Formato de instruções

![fluxo](/design/instrucoes.svg)

## Pontos de controle

![fluxo](/design/PontosDeControleTable.png)

## RTL

[Geral](/design/rtl/geral.pdf)

[Banco de registradores](/design/rtl/banco-registradores.pdf)

[Botões](/design/rtl/buttons.pdf)

[Cpu](/design/rtl/cpu.pdf)

[IO](/design/rtl/io.pdf)

[Switch](/design/rtl/switch.pdf)

[Base de tempo](/design/rtl/time-base.pdf)

[UC](/design/rtl/uc.pdf)

[ULA](/design/rtl/ula.pdf)

[fluxo-pdf]: /design/fluxo.pdf "Fluxo de dados"
[controle]: /design/PontosDeControleTable.pdf "Title"
[assembly]: /design/assembly.txt "Title"
