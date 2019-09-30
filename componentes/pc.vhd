library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
 
ENTITY pc IS
    GENERIC (
        size : INTEGER := 16
    );

    PORT (
		  --in
        imediato : IN std_logic_vector((size - 1) DOWNTO 0);
        --instrucoes
        jump : IN std_logic;
        clk : IN std_logic;
		  --out
        instr : OUT std_logic_vector((size - 1) DOWNTO 0) := (others => '0')

    );

END ENTITY;

ARCHITECTURE rtl OF pc IS
    SIGNAL inc, output_pc, output_mux: std_logic_vector((size - 1) DOWNTO 0) := (others => '0');

BEGIN

    MUX : ENTITY work.mux2
			
		  GENERIC MAP(
			size => size
			)
        PORT MAP(
        a0 =>	inc,
        a1 => 	imediato,
        sel => jump,
        res =>  output_mux
    );
	 
	 inc <= output_pc +  '1';
	 
	 
	 PROCESS (clk)
    BEGIN
	 if rising_edge(clk) then 
		output_pc <= output_mux;
		
		end if;
    END PROCESS;
	 
	 instr <= output_pc;
	 
END ARCHITECTURE;