library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;

entity BO is
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
end entity;

architecture archBO of BO is

component adder_n_bits
	generic(N: positive := 8);
	port(
		inpt0, inpt1: in std_logic_vector(N-1 downto 0);
		outpt: out std_logic_vector(N-1 downto 0)
	);
end component;

component register_n_bits
	generic (N: positive := 8);
	port(
		clock, reset, enable: in std_logic;
		inpt: in std_logic_vector(N-1 downto 0);
		outpt: out std_logic_vector(N-1 downto 0)
	);
end component;

component compareIfEqual_n_bits
	generic(N: integer := 8);
	port( 
		inpt0, inpt1: in std_logic_vector(N-1 downto 0);
		outpt: out std_logic
	);
end component;

component mux2x1_n_bits is
	generic(N: positive := 2);
	port(
		inpt0, inpt1: in std_logic_vector(n-1 downto 0);
		sel: in std_logic;
		outpt: out std_logic_vector(n-1 downto 0)
	);
end component;

component mux4x1_n_bits is
	generic(n: positive := 3); 
	port(
		inpt0, inpt1, inpt2, inpt3: in std_logic_vector(n-1 downto 0);
		sel: in std_logic_vector(1 downto 0);
		outpt: out std_logic_vector(n-1 downto 0)
	);
end component;


--signal declaration

signal saicktimer, saisomacktimer: std_logic_vector (25 DOWNTO 0);
signal saitime, saisomatime: std_logic_vector (7 DOWNTO 0);
signal saimuxNS, saimuxEW: std_logic_vector (2 DOWNTO 0);
signal saimuxP: std_logic_vector (1 DOWNTO 0);

begin
	
	Rcktimer : register_n_bits GENERIC MAP (26) PORT MAP(clock, rstcktimer, ecktimer, saisomacktimer, saicktimer);
	Acktimer : adder_n_bits GENERIC MAP (26) PORT MAP(saicktimer, "00000000000000000000000001", saisomacktimer);
	--Cs1 : compareIfEqual_n_bits GENERIC MAP (26) PORT MAP(saicktimer, "00000000000000000111110100", s1);--500
	Cs1 : compareIfEqual_n_bits GENERIC MAP (26) PORT MAP(saicktimer, "00010011000100101101000000", s1);--5000000
	--Cs1 : compareIfEqual_n_bits GENERIC MAP (26) PORT MAP(saicktimer, "10111110101111000010000000", s1);--50000000000

	Rtime : register_n_bits PORT MAP(clock, rsttime, etime, saisomatime, saitime);
	Atime : adder_n_bits PORT MAP(saitime, "00000001", saisomatime);
	Cs45 : compareIfEqual_n_bits PORT MAP(saitime, "00101101", s45);
	Cs50 : compareIfEqual_n_bits PORT MAP(saitime, "00110010", s50);
	Cs55 : compareIfEqual_n_bits PORT MAP(saitime, "00110111", s55);
	Cs100 : compareIfEqual_n_bits PORT MAP(saitime, "01100100", s100);
	Cs105 : compareIfEqual_n_bits PORT MAP(saitime, "01101001", s105);
	Cs110 : compareIfEqual_n_bits PORT MAP(saitime, "01101110", s110);
	Cs135 : compareIfEqual_n_bits PORT MAP(saitime, "10000111", s135);
	Cs140 : compareIfEqual_n_bits PORT MAP(saitime, "10001100", s140);
	
	MNS: mux4x1_n_bits GENERIC MAP (3) PORT MAP("100", "010", "001", "000", cMuxNS, saiMuxNS);
	RNS : register_n_bits GENERIC MAP (3) PORT MAP(clock, reset, eNS, saimuxNS, NS);
	
	MP: mux2x1_n_bits GENERIC MAP (2) PORT MAP("10", "01", cMuxP, saiMuxP);
	RP : register_n_bits GENERIC MAP (2) PORT MAP(clock, reset, eP, saiMuxP, P);
	
	MEW: mux4x1_n_bits GENERIC MAP (3) PORT MAP("100", "010", "001", "000",  cMuxEW, saiMuxEW);
	REW : register_n_bits GENERIC MAP (3) PORT MAP(clock, reset, eEW, saiMuxEW, EW);
	
	
end architecture;