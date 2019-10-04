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
    signal data_mem : std_logic_vector(3 downto 0);
	 signal display_data : std_logic_vector(6 downto 0);
begin
    
    process(write_enable)
    begin 
        if(write_enable = '1') then
            data_mem <= data_write(3 downto 0);
        end if;
    end process;
	 

conversor : ENTITY work.conversorHex7Seg
	  PORT MAP(
	  dadoHex => data_mem,
	  apaga  => '0',
	  negativo => '0',
	  overFlow => '0',
	  saida7seg => display_data
  );

    d7seg <= display_data;

end architecture;