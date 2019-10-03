library ieee;
use ieee.std_logic_1164.all;

entity switches is
	generic(
		start : natural := 7;
		ending: natural := 0
	);
	port(
		read_enable	 : in  std_logic;
		data_read 	 : out std_logic_vector(7 downto 0);
		SW 			 : in  std_logic_vector(17 downto 0)
	);

end switches;

architecture comportamento of switches is

	signal signal_3state : std_logic_vector(7 downto 0) := (others => '0');

begin 
	
	signal_3state <= SW(start downto ending);
	
	data_read <=  signal_3state when(read_enable = '1') else (others => 'Z');
	

end architecture;

	