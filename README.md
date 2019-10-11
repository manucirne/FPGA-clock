# FPGA-clock

David Fogelman

Manoela Campos

Wesley Gabriel

## Funcionamento

![fluxo](./design/func.svg)

## Arquitetura

A arquitetura do processador é registrador registrador.

## Fluxo de dados

[Fluxo de dados][fluxo-pdf]

![fluxo](./design/fluxo.svg)
O endereço de saída do PC entra na ROM para que a instrução correta seja enviada para o barramento. A unidade de controle pega os bits de 27 a 24 (OPCODE). Esses bits são um endereço, já que a UC trabalha como uma ROM, com um arquivo .mif que guarda os bits que devem ser devolvidos para cada ponto de controle. A UC também recebe as flags z e ng, vindas da ula, que verificam se a operação feita é zero ou menor que zero.
A ULA recebe da UC qual operação deve realizar em 4 bits. O resultado da operação vai para o mux que decide se o que entra no banco de registradores é a saída de dados do IO (dataRD) ou saída da ULA e para o endereçamento do IO. A unidade de controle também diz se a escrita do banco de registradores está habilitada com o WR e define se o IO deve ser lido ou escrito (ou nenhum dos dois) com os controles RD_IO e WD_IO. Assim, esse endereço que entra no io será ou não utilizado, de acordo com as respostas da UC. O banco de registradores recebe 3 endereços, para os registradores A, B e C, que são respectivamente de escrita, leitura e leitura. O C, sai do BR e entra no mux que escolhe se a entrada da ula é o C ou o imediato, vindo da instrução da ROM. O B entra diretamente na ULA. O endereço de escrita do BR vem da instrução para um mux que escolhe se será o endereço do resgistrador A ou C. Isso nos permite escrever em dois registradores diferentes o que facilita o assembly, aumentando a gama de instruções possíveis. A data de leitura do IO dataWR é a saída C do BR. Dentro do IO existe um decodificador que usa o endereço de entrada, vinco da saída da ULA para definir qual periférico deve ser lido ou escrito. Essa separação pode ser verificada no endereçamento do IO, abaixo. Os periféricos se conectam ao IO pelo top level do relógio.

## IO

![fluxo](./design/io.svg)

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

![fluxo](./design/instrucoes.svg)

## Pontos de controle

![fluxo](./design/PontosDeControleTable.png)

## RTL

[Geral](https://github.com/manucirne/FPGA-clock/blob/master/design/rtl/geral.pdf)

[Banco de registradores](https://github.com/manucirne/FPGA-clock/blob/master/design/rtl/banco-registradores.pdf)

[Botões](https://github.com/manucirne/FPGA-clock/blob/master/design/rtl/buttons.pdf)

[Cpu](https://github.com/manucirne/FPGA-clock/blob/master/design/rtl/cpu.pdf)

[IO](https://github.com/manucirne/FPGA-clock/blob/master/design/rtl/io.pdf)

[Switch](https://github.com/manucirne/FPGA-clock/blob/master/design/rtl/switch.pdf)

[Base de tempo](https://github.com/manucirne/FPGA-clock/blob/master/design/rtl/time-base.pdf)

[UC](https://github.com/manucirne/FPGA-clock/blob/master/design/rtl/uc.pdf)

[ULA](https://github.com/manucirne/FPGA-clock/blob/master/design/rtl/ula.pdf)

[fluxo-pdf]: https://github.com/manucirne/FPGA-clock/blob/master/design/fluxo.pdf "Fluxo de dados"
[assembly]: https://raw.githubusercontent.com/manucirne/FPGA-clock/master/design/assembly.txt "Title"
