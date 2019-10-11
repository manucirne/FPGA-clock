-- David Fogelman
-- Manoela Campos
-- Wesley Gabriel

library ieee;
use ieee.std_logic_1164.all;

entity display is 
    port(
        d7seg            : out std_logic_vector(6 downto 0);
        write_enable    : in  std_logic;
		  clock				: in std_logic;
        data_write      : in std_logic_vector(7 downto 0)
    );
end display;

architecture comportamento of display is
    signal data_mem : std_logic_vector(3 downto 0) := (others => '0');
	 signal display_data : std_logic_vector(6 downto 0);
begin
    process(clock)
    begin 
    -- se o clock está na borda de subida
	 if(rising_edge(clock)) then
        -- se estiver habilitada a escrita
        if(write_enable = '1') then
            -- escreve a memória para o display
            data_mem <= data_write(3 downto 0);
        end if;
		end if;
    end process;
	 
-- conversor hexadecimal
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

