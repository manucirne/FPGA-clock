library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
 
ENTITY pc IS
    GENERIC (
        -- quantidade de instruções
        size : INTEGER := 16
    );

    PORT (
		--IN
        imediato : IN std_logic_vector((size - 1) DOWNTO 0);
        clk : IN std_logic;
        jump : IN std_logic;
		--OUT
        instr : OUT std_logic_vector((size - 1) DOWNTO 0) := (others => '0')

    );

END ENTITY;

ARCHITECTURE rtl OF pc IS
    SIGNAL inc, output_pc, output_mux: std_logic_vector((size - 1) DOWNTO 0) := (others => '0');

BEGIN
    -- utiliza o mux para selecionar o endereço
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
	 
     -- Incrementa 1 no endereço
	 inc <= output_pc +  '1';
	 
	 
	PROCESS (clk)
    BEGIN
	 if rising_edge(clk) then 
		output_pc <= output_mux;
		end if;
    END PROCESS;
	 
	 instr <= output_pc;
	 
END ARCHITECTURE;