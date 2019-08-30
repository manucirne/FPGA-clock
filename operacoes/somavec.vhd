-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;

entity somavec is
	generic
	(
		DATA_WIDTH : natural := 4
	);


	port
	(
		-- Input ports
		a	: in std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
		b	: in std_logic_vector(DATA_WIDTH-1 DOWNTO 0);

		-- Inout ports
		cin	: in std_logic;
		cout  : out std_logic;

		y	: out std_logic_vector(DATA_WIDTH-1 DOWNTO 0);
		z  : out std_logic
	);
end somavec;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture somas of somavec is

	-- Declarations (optional)
	signal c01, c12, c23, z0, z1, z2, z3 : std_logic;

begin
	Soma0: entity work.soma
    port map
    (
        a => a(0),
        b => b(0),
        cin => cin,
		  cout => c01,
		  y => y(0),
		  z => z0
    );
	 
	 Soma1: entity work.soma
    port map
    (
        a => a(1),
        b => b(1),
        cin => c01,
		  cout => c12,
		  y => y(1),
		  z => z1
    );
	 
	 Soma2: entity work.soma
    port map
    (
        a => a(2),
        b => b(2),
        cin => c12,
		  cout => c23,
		  y => y(2),
		  z => z2
    );
	 
	 Soma3: entity work.soma
    port map
    (
        a => a(3),
        b => b(3),
        cin => c23,
		  cout => cout,
		  y => y(3),
		  z => z3
    );
	 
	z <= z0 or z1 or z2 or z3;
	
end somas;

