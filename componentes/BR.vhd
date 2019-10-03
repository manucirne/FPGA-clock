library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Baseado no apendice C (Register Files) do COD (Patterson & Hennessy).
entity BR is
    generic
    (
        larguraDados        : natural := 8;
        larguraEndBancoRegs : natural := 8
    );
-- Leitura de 2 registradores e escrita em 1 registrador simultaneamente.
    port
    (
        clk        : in std_logic;
--
        enderecoA       : in std_logic_vector((larguraEndBancoRegs-1) downto 0);
        enderecoB       : in std_logic_vector((larguraEndBancoRegs-1) downto 0);
        enderecoC   		: in std_logic_vector((larguraEndBancoRegs-1) downto 0);
--
        dadoEscritaA    : in std_logic_vector((larguraDados-1) downto 0);
--
        escreveA      	: in std_logic;
--
        saidaC          : out std_logic_vector((larguraDados -1) downto 0);
        saidaB          : out std_logic_vector((larguraDados -1) downto 0)
    );
end entity;

architecture rtl of BR is
	-- Build a 2-D array type for the regs
	subtype word_t is std_logic_vector((larguraDados-1) downto 0);
	type memory_t is array((2**larguraEndBancoRegs)-1 downto 0) of word_t;

	-- Declare the regs signal.	
	signal regs : memory_t;

	-- Register to hold the address 
	-- signal enderecoCreg : std_logic_vector((larguraEndBancoRegs -1) downto 0) := enderecoC;
	-- signal enderecoAreg : std_logic_vector((larguraEndBancoRegs -1) downto 0) := enderecoA;
	-- signal enderecoBreg : std_logic_vector((larguraEndBancoRegs -1) downto 0) := enderecoB;
	
begin

	-- Update the register output on the clock's rising edge
	process (clk)
	begin
		if (rising_edge(clk)) then
			if escreveA = '1' then
				regs(to_integer(unsigned(enderecoA))) <= dadoEscritaA;
			end if;
		end if;
	end process;
	
	SaidaC <= regs(to_integer(unsigned(enderecoC)));
	SaidaB <= regs(to_integer(unsigned(enderecoB)));
	

end rtl;
