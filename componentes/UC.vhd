library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UC is

    generic
    (
        dataWidth : natural := 9;
        addrWidth : natural := 4
    );

    port (
          Endereco : in std_logic_vector (addrWidth-1 DOWNTO 0);
			 NG : in std_logic;
			 Z : in std_logic;
          Dado : out std_logic_vector (dataWidth-1 DOWNTO 0);
			 Jump  : out std_logic
    );
end entity;

architecture initUC of UC is
SIGNAL jumpsig1 : std_logic;

type memory_t is array (2**addrWidth -1 downto 0) of std_logic_vector (dataWidth-1 downto 0);
signal content: memory_t;
attribute ram_init_file : string;
attribute ram_init_file of content:
signal is "componentes/uclala.mif";

begin
 
	muxjump : ENTITY work.mux4
        PORT MAP(
		  a0 => '1',
        a1 => ((not NG) and (not Z)),
		  a2=> NG,
		  a3=> Z,
        sel=> Endereco(1 downto 0),
        res=> jumpsig1
        );
		  
	Dado <= content(to_integer(unsigned(Endereco)));
	Jump <= jumpsig1 AND Endereco(3);
		  
end architecture;