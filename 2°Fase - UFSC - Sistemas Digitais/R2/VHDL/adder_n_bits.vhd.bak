library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_n_bits is
generic(N: positive := 8);
port(
	inpt0, inpt1: in std_logic_vector(N-1 downto 0);
	outpt: out std_logic_vector(N-1 downto 0)
);
end entity;

architecture archAdder of adder_n_bits is
	begin
		outpt <= std_logic_vector(signed(inpt0) + signed(inpt1));
end architecture;