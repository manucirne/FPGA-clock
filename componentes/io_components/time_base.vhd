library ieee;
use ieee.std_logic_1164.all;

entity time_base is
	port(
		write_enable : in  std_logic;
		read_enable	 : in  std_logic;
		data_read 	 : out std_logic_vector(7 downto 0);
		data_write 	 : in  std_logic_vector(7 downto 0);
		switch	 : in  std_logic_vector(17 downto 0);
		clock 		 : in  std_logic
	);

end time_base;

architecture comportamento of time_base is
	signal signal_clear : std_logic;
	signal signal3state : std_logic;
	signal signalExtSW  : std_logic;
	
begin 

	time_counter : entity work.seconds_counter 
	generic map(
		FAST_CLK_FREQ => 50e6,
		ALTERNATIVE_FREQ => 10e6
	)
	port map(
		clk => clock,
		clear => signal_clear,
		fast_foward => signalExtSW,
		q => signal3state
	);

	signalExtSW <= switch(17);
	signal_clear <= data_write(0) AND write_enable;

	data_read <= (0 => signal3state, others => '0') when(read_enable = '1') else (others => 'Z');

end architecture;