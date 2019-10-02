library ieee;
use ieee.std_logic_1164.all;

entity mux4 is

    port (
        a0    : in  std_logic;
        a1    : in  std_logic;
		  a2    : in  std_logic;
		  a3    : in  std_logic;
        sel   : in  std_logic_vector(1 downto 0);
        res   : out std_logic
    );
end entity;

architecture rtl of mux4 is
begin
  -- Para sintetizar lógica combinacional usando um processo,
  --  todas as entradas do modulo devem aparecer na lista de sensibilidade.
    process(a0, a1, a2, a3, sel) is
    begin
     -- If é uma instrução sequencial que não pode ser usada
     --  na seção de instruções concorrentes da arquitetura.
        if(sel="00") then
            res <= a0;
        elsif(sel="01") then
            res <= a1;
			elsif(sel="10") then
            res <= a2;
			elsif(sel="11") then
            res <= a3;
				
        end if;
    end process;
end architecture;