-- A library clause declares a name as a library.  It 
-- does not create the library; it simply forward declares 
-- it. 
library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;

entity soma is

	port
	(
		-- Input ports
		a	: in std_logic;
		b	: in std_logic;

		-- Inout ports
		cin	: in std_logic;
		cout	: out std_logic;

		-- Output ports
		y	: out std_logic;
		z  : out std_logic
	);
end soma;


-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture somaab of soma is

	-- Declarations (optional)
	SIGNAL abxor : std_logic;

begin
	
	abxor <= a xor b;
	y <= abxor xor cin;
	cout <= (abxor and cin) or (a and b);
	
	zero: z <= 
	'1' when (abxor xor cin) = '1' else
	'0';

	


end somaab;

