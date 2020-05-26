library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity interface is
port(
	clock: in std_logic;
	resetn: in std_logic;
	readdata: out std_logic_vector(7 downto 0)
);
end entity;

architecture archInterface of interface is

component traffic_light_top is
port(
	clock: in std_logic;
	reset: in std_logic;
	output: out std_logic_vector(7 downto 0)
);
end component;

begin

	top: traffic_light_top PORT MAP(clock, resetn, readdata);
	
end architecture;