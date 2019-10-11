-- David Fogelman
-- Manoela Campos
-- Wesley Gabriel

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- top level do projeto
ENTITY relogio IS
    GENERIC (
          sizeio : INTEGER := 8;
		  sizepc : INTEGER := 16;
		  
		  sizeinstruction : INTEGER := 28; -- tamanho das instruções
		  sizeopcode : INTEGER := 4 -- tamanho do opcode
    );

    PORT (
	 
		
		--IN
			CLOCK_50 : IN std_logic; -- clock utilizado no processador
			SW : in STD_LOGIC_VECTOR(17 downto 0); -- chaves da placa
			KEY : IN STD_LOGIC_VECTOR(3 downto 0); -- botôes da placa
		--OUT
			HEX0 ,HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0); --displays de 7 segmentos
			LEDG : OUT std_logic_vector(7 downto 0) -- leds (verdes)
    );

END ENTITY;

ARCHITECTURE rtl OF relogio IS 
	 SIGNAL wrrdiosignal, rdiosignal : std_logic;
	 SIGNAL pcsigaddr: std_logic_vector(15 downto 0); --signal da saida do pc
	 SIGNAL dataRDsigio, dataWRsigio, addrsigio : std_logic_vector(7 downto 0); 
	 SIGNAL instsigrom : std_logic_vector(27 downto 0); --signal da instrução
	 

BEGIN
	-- DEBUG : o endereço da instrução é colocado nos leds
	LEDG <= pcsigaddr(7 downto 0);
	-- declaração da entidade cpu
    CPURELOGIO : ENTITY work.cpu
        PORT MAP(
		--IN
			clk => CLOCK_50, -- clock de 50 mhz
			instruction => instsigrom, -- instrução da rom
			dataioin => dataRDsigio,
		--OUT
			dataioout =>dataWRsigio,
			instructionaddr => pcsigaddr,
			WRRDio => wrrdiosignal,
			RDio => rdiosignal,
			ioaddr => addrsigio
		);
				  
		ROMRELOGIO : ENTITY work.rom
			  PORT MAP(
			  Endereco => pcsigaddr,
          Dado => instsigrom
			  );
			  
		IORELOGIO : ENTITY work.IO
			  PORT MAP(
			  data_read => dataRDsigio,
			  display0out => HEX0,
			  display2out => HEX2, 
			  display3out => HEX3, 
			  display4out => HEX4, 
			  display5out => HEX5, 
			  display6out => HEX6, 
			  display7out => HEX7,
			  data_write  =>dataWRsigio,
			  addr  => addrsigio,
			  write_enable => wrrdiosignal,
			  read_enable => rdiosignal,
			  clk => CLOCK_50,
			  SWitchesin => SW,
			  KEYbutz => KEY
				  );
			  
	
END ARCHITECTURE;