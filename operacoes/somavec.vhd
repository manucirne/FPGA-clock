-- referencia: http://kdientu.duytan.edu.vn/media/50147/design-an-adder-using-vhdl.pdf
 
 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_unsigned.all;
 
 entity somavec is
 generic (size: natural:=4);
 port (
 
 -- entradas
 a: in std_logic_vector((size-1) downto 0);
 b: in std_logic_vector((size-1) downto 0);
 cin: in std_logic;
 
 --saidas
 cout: out std_logic;
 sum: out std_logic_vector((size - 1) downto 0)

 );
 end entity;
 
 architecture rtl of somavec is
 
 signal i_sum: std_logic_vector(size downto 0);
 
 -- tamanho do vetor e de size + 1
 
 constant i_cin_ext: std_logic_vector(size downto 1) := (others => '0');
 
 begin
 -- concatena 0 na frente do vetor
 i_sum <= ('0' & a) + ('0' & b) + (i_cin_ext & cin);
 
 sum <= i_sum((size-1) downto 0);
 
 -- seleciona o bit mais significativo como carry
 cout <= i_sum(size);
 
 end rtl;