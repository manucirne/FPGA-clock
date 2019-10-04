library ieee;
use ieee.std_logic_1164.all;

entity display is 
    port(
        d7seg            : out std_logic_vector(6 downto 0);
        write_enable    : in  std_logic;
        data_write      : in std_logic_vector(7 downto 0)
    );
end display;

architecture comportamento of display is
    signal display_data : std_logic_vector(6 downto 0);
begin
    
    process(write_enable)
    begin 
        if(write_enable = '1') then
            display_data <= data_write(6 downto 0);
        end if;
    end process;

    d7seg <= display_data;

end architecture;