library ieee;
use ieee.std_logic_1164.all;

entity BC is
	port(
		-- control inputs
		clock, reset: in std_logic;
		s1, s45, s50, s55, s100, s105, s110, s135, s140: in std_logic;

		-- control outputs
		ecktimer, rstcktimer, rsttime, etime, eNS, eP, eEW: out std_logic;
		
		cMuxNS, cMuxEW: out std_logic_vector(1 downto 0);
		cMuxP: out std_logic
	);
end entity;

architecture archBC of BC  is
	type InternalState is (init, S0, S2, S3, S4, S5, S6, S7, S8);
	signal nextState, currentState: InternalState;
	begin
	NSL: process(s1, s45, s50, s55, s100, s105, s110, s135, s140) is
	
	-- next-state logic (combinatorial)
	begin
		nextState <= currentState;
		case currentState is
			when init =>
				nextState <= S0;
			when S0 =>
				if(s1='1') then
					nextState <= S2;
				else
					nextState <= S0;
				end if;
			when S2 =>
			  if not(s45='1' and s50='1' and s55='1' and s100='1' and s105='1' and s110='1' and s135='1' and s140='1') then
				 nextState <= S0;
			  end if;
			  if s45='1' and not(s50='1' or s55='1' or s100='1' or s105='1' or s110='1' or s135='1' or s140='1') then
				 nextState <= S3;
			  end if;
			  if ((s50='1') or (s105='1') or (s135='1')) and not(s45='1' or s55='1' or s100='1' or s110='1' or s140='1') then
				 nextState <= S4;
			  end if;
			  if s55='1' and not(s45='1' or s50='1' or s100='1' or s105='1' or s110='1' or s135='1' or s140='1') then
				 nextState <= S5;
			  end if;
			  if s100='1' and not(s45='1' or s50='1' or s55='1' or s105='1' or s110='1' or s135='1' or s140='1') then
				 nextState <= S6;
			  end if;
			  if s110='1' and not(s45='1' or s50='1' or s55='1' or s100='1' or s105='1' or s135='1' or s140='1') then
				 nextState <= S7;
			  end if;
			  if s140='1' and not(s45='1' or s50='1' or s55='1' or s100='1' or s105='1' or s110='1' or s135='1') then
				 nextState <= S8;
			  end if;
			when S3 =>
				nextState <= S0;
			when S4 =>
				nextState <= S0;
			when S5 =>
				nextState <= S0;
			when S6 =>
				nextState <= S0;
			when S7 =>
				nextState <= S0;
			when S8 =>
				nextState <= S0;
		end case;
	end process;

	-- memory element (sequential)
	
	process(clock, reset) is
	begin
		if reset='1' then
			currentState <= init; -- reset state
		elsif rising_edge(clock) then
			currentState <= nextState;
		end if;
	end process;

	-- output-logic
	
	ecktimer <= '1' when (currentState = S0) else '0';
	
	rstcktimer <= '1' when (currentState = init 
								or currentState = S2
								or currentState = S8) else '0';
	
	rsttime <= '1' when (currentState = init
							or currentState = S8) else '0';
	
	etime <= '1' when (currentState = S2) else '0';
	
	eNS <= '1' when (currentState = init
						or currentState = S3
						or currentState = S4
						or currentState = S8) else '0';
	
	cMuxNS <= "00" when (currentState = init
							or currentState = S0
							or currentState = S2
							or currentState = S8) else
				"01" when (currentState = S3) else
				"10" when (currentState = S4
							or currentState = S5
							or currentState = S6
							or currentState = S7);
				 
	cMuxP <= '0' when (currentState = S0
							or currentState = S2
							or currentState = S7) else '1';
	
	eP <= '1' when (currentState = init
						or currentState = S4
						or currentState = S7) else '0';
	
	cMuxEW <= "00" when (currentState = S0
							or currentState = S2
							or currentState = S5) else
							"01" when (currentState = S6) else
							"10" when (currentState = init
							or currentState = S3
							or currentState = S4
							or currentState = S7
							or currentState = S8);      
				 
	eEW <= '1' when (currentState = init
						or currentState = S4
						or currentState = S5
						or currentState = S6) else '0';

end architecture;
