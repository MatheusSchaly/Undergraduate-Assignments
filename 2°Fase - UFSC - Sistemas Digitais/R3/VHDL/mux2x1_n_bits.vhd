library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux2x1_n_bits is
	generic(N : positive := 2);
	port(
		inpt0, inpt1: in std_logic_vector(N-1 downto 0);
		sel: in std_logic;
		outpt: out std_logic_vector(N-1 downto 0)
	);
end mux2x1_n_bits;

architecture archMux of mux2x1_n_bits is
	begin
		outpt <= inpt0 when sel= '0' else inpt1;

end architecture;
