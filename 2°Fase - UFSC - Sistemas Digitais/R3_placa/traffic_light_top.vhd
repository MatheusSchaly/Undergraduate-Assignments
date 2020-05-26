library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light_top is
port(
	CLOCK_50: in std_logic;
	KEY: in std_logic_vector(0 downto 0);
	LEDR: out std_logic_vector(17 downto 0)
);
end entity;
--
architecture archTop of traffic_light_top is
	
	component BC is
	port(
		-- control inputs
		clock, reset: in std_logic;
		s1, s45, s50, s55, s100, s105, s110, s135, s140: in std_logic;

		-- control outputs
		ecktimer, rstcktimer, rsttime, etime, eNS, eP, eEW: out std_logic;
		
		cMuxNS, cMuxEW: out std_logic_vector(1 downto 0);
		cMuxP: out std_logic
	);
	end component;

	component BO is
	port(
		-- operative inputs
		clock, reset: in std_logic;
		ecktimer, rstcktimer, rsttime, etime, eNS, eP, eEW: in std_logic;
		cMuxNS, cMuxEW: in std_logic_vector(1 downto 0);
		cMuxP : in std_logic;

		-- operative outputs
		s1, s45, s50, s55, s100, s105, s110, s135, s140: out std_logic;
		
		-- data outputs
		NS, EW: out std_logic_vector(2 downto 0);
		P: out std_logic_vector(1 downto 0)
	);
	end component;
	
	
	-- signal declaration
	signal sig_s1, sig_s45, sig_s50, sig_s55, sig_s100, sig_s105, sig_s110, sig_s135, sig_s140: std_logic;
	signal sig_ecktimer, sig_rstcktimer, sig_rsttime, sig_etime, sig_eNS, sig_eP, sig_eEW: std_logic;
	signal sig_cMuxNS, sig_cMuxEW: std_logic_vector(1 downto 0);
	signal sigcMuxP: std_logic;
	
	begin
		
	bc_map : BC PORT MAP(CLOCK_50, not KEY(0),
							sig_s1, sig_s45, sig_s50, sig_s55, sig_s100, sig_s105, sig_s110, sig_s135, sig_s140,
							sig_ecktimer, sig_rstcktimer, sig_rsttime, sig_etime, sig_eNS, sig_eP, sig_eEW,
							sig_cMuxNS, sig_cMuxEW, sigcMuxP);
						
	bo_map : BO PORT MAP(CLOCK_50, not KEY(0),
							sig_ecktimer, sig_rstcktimer, sig_rsttime, sig_etime, sig_eNS, sig_eP, sig_eEW,
							sig_cMuxNS, sig_cMuxEW, sigcMuxP,
							sig_s1, sig_s45, sig_s50, sig_s55, sig_s100, sig_s105, sig_s110, sig_s135, sig_s140,
							LEDR(7 downto 5), LEDR(4 downto 2),
							LEDR(1 downto 0));

end architecture;
