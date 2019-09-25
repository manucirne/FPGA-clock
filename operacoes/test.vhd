 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_unsigned.all;
 entity add is
 generic (width: integer:=4);
 port (
 x: in std_logic_vector((width-1) downto 0);
 y: in std_logic_vector((width-1) downto 0);
 cin: in std_logic;
 sum: out std_logic_vector((width - 1) downto 0);
 cout: out std_logic
 );
 end add;
 architecture rtl of add is
 signal i_sum: std_logic_vector(width downto 0);
 constant i_cin_ext: std_logic_vector(width downto 1) := (others => '0');
 begin
 i_sum <= ('0' & x) + ('0' & y) + (i_cin_ext & cin);
 sum <= i_sum((width-1) downto 0);
 cout <= i_sum(width);
 end rtl;