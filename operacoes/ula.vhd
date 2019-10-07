LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY ula IS
    GENERIC (
        size : INTEGER := 4
    );

    PORT (
        a : IN std_logic_vector((size - 1) DOWNTO 0);
        b : IN std_logic_vector((size - 1) DOWNTO 0);
        --instrucoes
        sel : IN std_logic_vector((3) DOWNTO 0);
        --out
        z : OUT std_logic;
        ng : OUT std_logic;
        output : OUT std_logic_vector((size - 1) DOWNTO 0)

    );

END ENTITY;

ARCHITECTURE rtl OF ula IS
    SIGNAL output_sig, soma_sig, sub_sig : std_logic_vector((size - 1) DOWNTO 0);
	 SIGNAL ng_sig : std_logic := '0';

BEGIN

    soma : ENTITY work.somavec
		GENERIC MAP(
			size => size
		)
        PORT MAP(
            a => a,
            b => b,
            cin => '0',
            cout => OPEN,
            sum => soma_sig
        );
		  
		sub : ENTITY work.sub
			GENERIC MAP(
			size => size
				)
			  PORT MAP(
					a => a,
					b => b,
					cout => ng_sig,
					sum => sub_sig
			  );
	 
	 PROCESS (sel, soma_sig, sub_sig, a, b)
    BEGIN
	 
		  ng <= output(size-1);
		  
        CASE sel IS
            WHEN "0000" =>
                output_sig <= soma_sig;
					 
				WHEN "0001" =>
                output_sig <= sub_sig;
					 ng <= ng_sig;
					 
				WHEN "0010" =>
                output_sig <= a xor b;
					 
				WHEN "0011" => 
					 output_sig <= a;
					 
				WHEN "0100" => 
					 output_sig <= b;
					 
				WHEN "0101" =>
                output_sig <= a and b;


            WHEN OTHERS =>
                output_sig <= (OTHERS => '0');

        END CASE;
    END PROCESS;
    output <= output_sig;
	 
	 -- https://stackoverflow.com/questions/20296276/and-all-elements-of-an-n-bit-array-in-vhdl
    z <= '1' when output_sig = "00000000" else '0';

END ARCHITECTURE;