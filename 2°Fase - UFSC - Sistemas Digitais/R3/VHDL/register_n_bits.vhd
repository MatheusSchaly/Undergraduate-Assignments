library ieee;
use ieee.std_logic_1164.all;

entity register_n_bits is
	generic (N: positive := 8);
	port(
		-- control inputs
		clock, reset,enable: in std_logic;
		-- data inputs
		inpt: in std_logic_vector(N-1 downto 0);
		-- data outputs
		outpt: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture archRegister of register_n_bits is
	subtype InternalState is std_logic_vector(N-1 downto 0);
	signal nextState, currentState: InternalState;
	begin
		
	-- next state logic (combinatorial)
	nextState <= inpt when enable = '1' else currentState;

	-- memory element (sequential)
	ME: process (clock, reset) is
	begin
		if reset='1' then
			currentState <= (others=>'0'); -- reset state
		elsif rising_edge(clock) then
			currentState <= nextState;
		end if;
	end process;
	
	-- output logic (combinatorial)
	outpt <= currentState;
	
end architecture;