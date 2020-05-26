library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compareIfEqual_n_bits is
	generic(N: integer := 8);
	port( 
		inpt0, inpt1: in std_logic_vector(N-1 downto 0);
		outpt: out std_logic
	);
end entity;

architecture archCompareIfEqual of compareIfEqual_n_bits is
	begin
		outpt <= '1' when inpt0 = inpt1 else '0';
end architecture;
