library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity compareIfEqual_n_bits is
	generic(width: integer := 8);
	port( 
		inpt0, inpt1: in std_logic_vector(width-1 downto 0);
		outpt: out std_logic
	);
end entity;

architecture archCompareIfEqual of compareIfEqual_n_bits is
begin
	outpt <= '1' when inpt0 = inpt1 else '0';
end architecture;
