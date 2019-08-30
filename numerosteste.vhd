

library IEEE;
use ieee.std_logic_1164.all;

entity numerosteste is
  port (
    HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0);
	 SW : in STD_LOGIC_VECTOR(17 downto 0);
	 KEY : IN STD_LOGIC_VECTOR(3 downto 0)
	 );
end entity;


architecture comportamento of numerosteste is

signal sinalTeste : std_logic_vector(3 downto 0);
signal sinalTesteH : std_logic_vector(3 downto 0);
signal BOTH : STD_LOGIC;
begin

  display7 : entity work.conversorHex7seg Port map (
  saida7seg => HEX7,
  dadoHex => sinalTesteH,
  apaga => '0', 
  overFlow => '0', 
  negativo => '0'
  );
  
	BOTH <= KEY(3);
	process(BOTH)
	begin
	
	if(falling_edge(BOTH)) then
	
	sinalTesteH<= sinalTeste;
	
	end if;
	
	
	end process;
	sinalTeste <= SW(3 downto 0);

end architecture;
