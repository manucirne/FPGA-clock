-- David Fogelman
-- Manoela Campos
-- Wesley Gabriel

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY cpu IS
    GENERIC (
        sizeio : INTEGER := 8;
		  sizepc : INTEGER := 16;
		  sizeinstruction : INTEGER := 28
    );

    PORT (
			--IN
			clk : IN std_logic;
        instruction : IN std_logic_vector((sizeinstruction - 1) DOWNTO 0);
        dataioin : IN std_logic_vector((sizeio - 1) DOWNTO 0);
		  --OUT
        dataioout : OUT std_logic_vector((sizeio - 1) DOWNTO 0);
        instructionaddr : OUT std_logic_vector((sizepc - 1) DOWNTO 0);
        WRRDio : OUT std_logic;
		  RDio : OUT std_logic;
        ioaddr : OUT std_logic_vector((sizeio - 1) DOWNTO 0)

    );

END ENTITY;

ARCHITECTURE rtl OF cpu IS 
	 SIGNAL jumpsignal, muxULAMemsignal, muximsignal, muxACsignal, zsig, ngsig, WRBRsignal, WRRDiosignal, RDiosignal : std_logic;
	 SIGNAL ACsignal, ULAMemsignal, ulaoutsignal, Cregsignal, Bregsignal, ulainsignal : std_logic_vector(7 downto 0);
	 SIGNAL instructionaddrsig : std_logic_vector(15 downto 0);
	 SIGNAL operacaosignal : std_logic_vector(3 downto 0);

BEGIN

    PCcpu : ENTITY work.pc
		GENERIC MAP(
			size => sizepc
		)
        PORT MAP(
            imediato => instruction(15 downto 0),
            jump => jumpsignal,
            clk => clk,
            instr => instructionaddrsig
        );
		  
		muxAC : ENTITY work.mux2
			GENERIC MAP(
			size => 8
				)
			  PORT MAP(
					a0 => instruction(7 downto 0),
					a1 => instruction(23 downto 16),
					sel => muxACsignal,
					res => ACsignal
			  );
			  
		muxULAMem : ENTITY work.mux2
			GENERIC MAP(
			size => 8
				)
			  PORT MAP(
					a0 => dataioin,
					a1 => ulaoutsignal,
					sel => muxULAMemsignal,
					res => ULAMemsignal
			  );
			  
		muxULAim : ENTITY work.mux2
			GENERIC MAP(
			size => 8
				)
			  PORT MAP(
					a0 => Cregsignal,
					a1 => instruction(7 downto 0),
					sel => muximsignal,
					res => ulainsignal
			  );
			  
		ULAcpu : ENTITY work.ula
			GENERIC MAP(
			size => 8
				)
			  PORT MAP(
					a => ulainsignal,
					b => Bregsignal,
					sel => operacaosignal,
					z => zsig,
					ng => ngsig,
					output => ulaoutsignal
			  );
			  
		Bancoreg : ENTITY work.BR
			GENERIC MAP(
			larguraDados => 8,
			larguraEndBancoRegs => 8
				)
			  PORT MAP(
			  clk => clk,
			  enderecoA => ACsignal,
			  enderecoB => instruction(15 downto 8),
			  enderecoC=> instruction(23 downto 16),
			  dadoEscritaA => ULAMemsignal,
			  escreveA => WRBRsignal,
			  saidaC => Cregsignal,
			  saidaB => Bregsignal
			  );
			  
		UCcpu : ENTITY work.UC
			GENERIC MAP(
			dataWidth => 10,
			addrWidth => 4
				)
			  PORT MAP(
			  Endereco => instruction(27 downto 24),
			  NG => ngsig,
			  Z => zsig,
			  muxim => muximsignal,
			  muxAC => muxACsignal,
			  operacao => operacaosignal,
			  muxULAMem => muxULAMemsignal,
			  BRWR => WRBRsignal,
			  IOWR => WRRDiosignal,
			  IORD => RDiosignal,
			  Jump => jumpsignal
			  );
			  
	 dataioout <= Cregsignal;
	 WRRDio <= WRRDiosignal;
	 RDio <= RDiosignal;
	 ioaddr <= ulaoutsignal;
	 instructionaddr <= instructionaddrsig;
END ARCHITECTURE;