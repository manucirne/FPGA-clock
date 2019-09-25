LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
    GENERIC (
        width : INTEGER := 4
    );

    PORT (
        a : IN std_logic_vector((width - 1) DOWNTO 0);
        b : IN std_logic_vector((width - 1) DOWNTO 0);
        --instrucoes
        sel : IN std_logic_vector((2) DOWNTO 0);
        --out
        z : OUT std_logic;
        ng : OUT std_logic;
        output : OUT std_logic_vector((width - 1) DOWNTO 0)

    );

END ENTITY;

ARCHITECTURE rtl OF ula IS
    SIGNAL output_sig, soma_sig, sub_sig : std_logic_vector((width - 1) DOWNTO 0);

BEGIN

    soma : ENTITY work.somavec
        PORT MAP(
            a => a,
            b => b,
            cin => '0',
            cout => OPEN,
            sum => soma_sig
        );
		  
		sub : ENTITY work.sub
			  PORT MAP(
					a => a,
					b => b,
					cout => OPEN,
					sum => sub_sig
			  );
			 PROCESS (sel)
    BEGIN
        CASE sel IS
            WHEN "000" =>
                output_sig <= soma_sig;
					 
				WHEN "001" =>
                output_sig <= sub_sig;
					 
				WHEN "010" =>
                output_sig <= a xor b;

            WHEN OTHERS =>
                output_sig <= (OTHERS => '0');

        END CASE;
    END PROCESS;
    output <= output_sig;
    z <= '0'; -- unsigned(output_sig) = 0 
END ARCHITECTURE;