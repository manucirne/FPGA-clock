library ieee;
use ieee.std_logic_1164.all;

entity seconds_counter is
	generic
	(
		FAST_CLK_FREQ 	  : natural := 50e6;
		ALTERNATIVE_FREQ : natural := 5e6
	);


	port
	(
		-- Input ports
		clk		: in std_logic;
		clear		: in std_logic;
		fast_foward: in std_logic;

		-- Inout ports
		q	: out std_logic := '0'
	);
end seconds_counter;

architecture conta of seconds_counter is

 signal ticks : natural;
 
 begin 
	
	process(clk) is
		begin
			if rising_edge(clk) then 
				if clear='1' then
					ticks	<= 0;
					q <= '0';
				else 
					ticks <= ticks + 1;
					if fast_foward = '1' then 
						if ticks >= ALTERNATIVE_FREQ then
							ticks <= 0;
							q <= '1';
						end if;
					else
						if ticks >= FAST_CLK_FREQ - 1 then
							ticks <= 0;
							q <= '1';
						end if;
					end if;
				end if;
			end if;
	end process;
	
end conta;
	