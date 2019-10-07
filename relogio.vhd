LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY relogio IS
    GENERIC (
        sizeio : INTEGER := 8;
		  sizepc : INTEGER := 16;
		  sizeinstruction : INTEGER := 28;
		  sizeopcode : INTEGER := 4
		  

    );

    PORT (
	 
		
			--IN
			CLOCK_50 : IN std_logic;
			 SW : in STD_LOGIC_VECTOR(17 downto 0);
			 KEY : IN STD_LOGIC_VECTOR(3 downto 0);
		  --OUT
		  HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 downto 0);
		  LEDG : OUT std_logic_vector(7 downto 0)
    );

END ENTITY;

ARCHITECTURE rtl OF relogio IS 
	 SIGNAL wrrdiosignal, rdiosignal : std_logic;
	 SIGNAL pcsigaddr: std_logic_vector(15 downto 0);
	 SIGNAL dataRDsigio, dataWRsigio, addrsigio : std_logic_vector(7 downto 0);
	 SIGNAL instsigrom : std_logic_vector(27 downto 0);
	 

BEGIN

	 LEDG <= pcsigaddr(7 downto 0);




		  

    CPURELOGIO : ENTITY work.cpu
        PORT MAP(
		  clk => CLOCK_50,
        instruction => instsigrom,
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
			  display0out => HEX2, 
			  display1out => HEX3, 
			  display2out => HEX4, 
			  display3out => HEX5, 
			  display4out => HEX6, 
			  display5out => HEX7,
			  data_write  =>dataWRsigio,
			  addr  => addrsigio,
			  write_enable => wrrdiosignal,
			  read_enable => rdiosignal,
			  clk => CLOCK_50,
			  SWitchesin => SW,
			  KEYbutz => KEY
				  );
			  
	
END ARCHITECTURE;