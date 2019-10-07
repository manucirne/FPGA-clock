library ieee;
use ieee.std_logic_1164.all;

entity IO is
    port(
        data_read   : out std_logic_vector(7 downto 0);
        display0out, display1out, display2out, display3out, display4out, display5out, display6out: OUT STD_LOGIC_VECTOR(6 downto 0);
        data_write  : in  std_logic_vector(7 downto 0);
        addr        : in  std_logic_vector(7 downto 0);
		  read_enable : in  std_logic;
        write_enable: in  std_logic;
        clk         : in std_logic;
        SWitchesin  : in  std_logic_vector(17 downto 0);
        KEYbutz     : in std_logic_vector(3 downto 0)
        
    );
end IO;

architecture conections of IO is
    signal en7seg0,en7seg1,en7seg2,en7seg3,en7seg4,en7seg5, en7seg6 : std_logic;
    signal enable_bot,enable_bot_read, enable_bot_write : std_logic;
    signal enable_sw_read,enable_sw1_read, enable_sw2_read : std_logic;
    signal enable_time,enable_time_read, enable_time_write : std_logic;
    signal upper_ORed : std_logic;
    signal data_read_bus, data_write_bus : std_logic_vector(7 downto 0);
    signal ext_sw : std_logic_vector(17 downto 0);
    signal ext_keys : std_logic_vector(3 downto 0);
    signal d0,d1,d2,d3,d4,d5, d6 : std_logic_vector(6 downto 0);
begin
    --Upper 4 bits of the address
    upper_ORed <= addr(7) or addr(6) or addr(5) or addr(4);

    -- time base control points
    enable_time <= (NOT upper_ORed) AND (NOT (addr(3) OR addr(2) OR addr(1)));
    enable_time_read <= read_enable AND enable_time AND (NOT addr(0));
    enable_time_write <= enable_time AND addr(0) and write_enable;

    --switch control points
    enable_sw_read <= (NOT upper_ORed) AND (NOT addr(3)) AND (NOT addr(2)) AND addr(1);
    enable_sw1_read <= read_enable AND enable_sw_read AND (NOT addr(0));
    enable_sw2_read <= enable_sw_read AND addr(0);

    --buttons control points
    enable_bot <= (NOT upper_ORed) AND (NOT addr(1)) AND (NOT addr(3)) AND addr(2);
    enable_bot_read <= read_enable AND enable_bot AND (NOT addr(0));
    enable_bot_write <= enable_bot AND addr(0) AND write_enable;

    --Displays control points
    en7seg0 <= write_enable when (addr = "00000110") else '0';
    en7seg1 <= write_enable when (addr = "00000111") else '0'; 
    en7seg2 <= write_enable when (addr = "00001000") else '0'; 
    en7seg3 <= write_enable when (addr = "00001001") else '0'; 
    en7seg4 <= write_enable when (addr = "00001010") else '0'; 
    en7seg5 <= write_enable when (addr = "00001011") else '0';
	 en7seg6 <= write_enable when (addr = "00001100") else '0';

    ext_sw <= SWitchesin;
    
    time_b : entity work.time_base
    port map(
        write_enable => enable_time_write,
        read_enable => enable_time_read,
        data_read => data_read_bus,
        data_write => data_write_bus,
        switch => ext_sw,
        clock => clk
    );

    sw_0 : entity work.switches
    generic map(
        start => 7,
        ending => 0
    )
    port map(
        read_enable => enable_sw1_read,
        data_read => data_read_bus,
        in_sw => ext_sw
    );

    sw_1 : entity work.switches
    generic map(
        start => 15,
        ending => 8
    )
    port map(
        read_enable => enable_sw2_read,
        data_read => data_read_bus,
        in_sw => ext_sw
    );

    ext_keys <= KEYbutz;

    bot : entity work.buttons
    port map(
        write_enable => enable_bot_write,
        read_enable  => enable_bot_read,
        data_read    => data_read_bus,
        data_write   => data_write_bus,
        keys         => ext_keys
    );

    display0out <= d0;

    disp0 : entity work.display
    port map(
        d7seg => d0,
		  clock => clk,
        write_enable => en7seg0,
        data_write => data_write_bus
    );

    display1out <= d1;

    disp1 : entity work.display
    port map(
        d7seg => d1,
		  clock => clk,
        write_enable => en7seg1,
        data_write => data_write_bus
    );

    display2out <= d2;

    disp2 : entity work.display
    port map(
        d7seg => d2,
		  clock => clk,
        write_enable => en7seg2,
        data_write => data_write_bus
    );

    display3out <= d3;

    disp3 : entity work.display
    port map(
        d7seg => d3,
		  clock => clk,
        write_enable => en7seg3,
        data_write => data_write_bus
    );

    display4out <= d4;

    disp4 : entity work.display
    port map(
        d7seg => d4,
		  clock => clk,
        write_enable => en7seg4,
        data_write => data_write_bus
    );


    display5out <= d5;

    disp5 : entity work.display
    port map(
        d7seg => d5,
		  clock => clk,
        write_enable => en7seg5,
        data_write => data_write_bus
    );
	 
	 display6out <= d6;

    disp6 : entity work.display
    port map(
        d7seg => d6,
		  clock => clk,
        write_enable => en7seg6,
        data_write => data_write_bus
    );
	 
	
	 
    data_read <= data_read_bus;

    data_write_bus <= data_write;

end architecture;