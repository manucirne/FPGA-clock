-- David Fogelman
-- Manoela Campos
-- Wesley Gabriel

library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
    generic (
        -- Total de bits das entradas e saidas
        size    : natural  :=   8
    );
    port (
        a0    : in  std_logic_vector(size-1 downto 0);
        a1    : in  std_logic_vector(size-1 downto 0);
        sel   : in  std_logic;
        res   : out std_logic_vector(size-1 downto 0)
    );
end entity;

architecture rtl of mux2 is
begin
  -- Para sintetizar lógica combinacional usando um processo,
  --  todas as entradas do modulo devem aparecer na lista de sensibilidade.
    process(a0, a1, sel) is
    begin
     -- If é uma instrução sequencial que não pode ser usada
     --  na seção de instruções concorrentes da arquitetura.
        if(sel='0') then
            res <= a0;
        else
            res <= a1;
        end if;
    end process;
end architecture;