library ieee;
use ieee.std_logic_1164.all;

entity flipflop is 
    port(
        enable       : in std_logic; 
        clear   : in std_logic;
        clock   : in std_logic;

        q       : out std_logic
    );
end flipflop;

architecture comportamento of flipflop is 
begin
    process(clock, clear)
    begin
        if(clear = '1') then
            q <= '0';
        elsif(rising_edge(clock)) then 
            if(enable = '1') then
                q <= '1';
            end if;
        end if;
    end process;
end comportamento;
    