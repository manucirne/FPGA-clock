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
			 muxim : out std_logic;
			 muxAC : out std_logic;
			 muxULAMem : out std_logic;
			 operacao : out std_logic_vector(3 DOWNTO 0);
			 BRWR : out std_logic;
			 IOWR: out std_logic;
			 IORD: out std_logic;
			 Jump  : out std_logic
    );
end entity;

architecture initUC of UC is
SIGNAL jumpsig1 : std_logic;
SIGNAL DADO : std_logic_vector (dataWidth-1 DOWNTO 0);

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
		  
	DADO <= content(to_integer(unsigned(Endereco)));
	
	Jump <= (jumpsig1 AND Endereco(3) AND (not Endereco(2)));
	muxim <= DADO(9);
	muxAC <= DADO(8);
	muxULAMem <= DADO(7);
	operacao <= DADO(3 DOWNTO 0);
	BRWR <= DADO(4);
	IOWR <= DADO(6);
	IORD <= DADO(5);
	
		  
end architecture;