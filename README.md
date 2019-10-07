# FPGA-clock

## Introdução

## Arquitetura

A arquitetura do processador é registrador restridador.

## Fluxo de dados

[Fluxo de dados][1]

## Instruction set

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

[1]: /design/fluxo.pdf "Fluxo de dados"
[2]: http://example.org/ "Title"
