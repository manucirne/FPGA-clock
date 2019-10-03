library ieee;
use ieee.std_logic_1164.all;

entity buttons is 
	port(
		write_enable : in  std_logic;
		read_enable	 : in  std_logic;
		data_read 	 : out std_logic_vector(7 downto 0);
		data_write 	 : in  std_logic_vector(7 downto 0);
		keys : IN STD_LOGIC_VECTOR(3 downto 0)
	);
	
end buttons;

architecture comportamento of buttons is
	signal signal_clear : std_logic_vector(3 downto 0);
	signal signal_3state : std_logic_vector(3 downto 0);
	signal signal_3state_8 : std_logic_vector(7 downto 0) := (others => '0');
	
	
begin

	
	
	-- Clear dos botões
	signal_clear(0) <= data_write(0) AND write_enable;
	signal_clear(1) <= data_write(1) AND write_enable;
	signal_clear(2) <= data_write(2) AND write_enable;
	signal_clear(3) <= data_write(3) AND write_enable;
	
	reg0 : entity work.flipflop port map(
			enable => '1',
			clear => signal_clear(0),
			clock => keys(0),
			q => signal_3state(0)
	);

	reg1 : entity work.flipflop port map(
			enable => '1',
			clear => signal_clear(1),
			clock => keys(1),
			q => signal_3state(1)
	);

	reg2 : entity work.flipflop port map(
			enable => '1',
			clear => signal_clear(2),
			clock => keys(2),
			q => signal_3state(2)
	);

	reg3 : entity work.flipflop port map(
			enable => '1',
			clear => signal_clear(3),
			clock => keys(3),
			q => signal_3state(3)
	);
	
	signal_3state_8(3 downto 0) <= signal_3state; 
	-- Data read
	data_read <= signal_3state_8 when(read_enable = '1') else (others => 'Z');
	
end architecture;