library ieee;
use ieee.std_logic_1164.all;

entity adap_traffic is
	port(
		CLOCK_50: in std_logic;
		KEY: in std_logic_vector(0 downto 0);
		LEDR: out std_logic_vector(7 downto 0)
	);
end entity;

architecture inst of adap_traffic is
	component nios2_soc is
        port (
            clk_clk                            : in  std_logic                    := 'X'; -- clk
            reset_reset_n                      : in  std_logic                    := 'X'; -- reset_n
            led_pio_external_connection_export : out std_logic_vector(7 downto 0)         -- export
        );
    end component nios2_soc;
begin 
    u0 : component nios2_soc
        port map (
            clk_clk                            => CLOCK_50,                            --                         clk.clk
            reset_reset_n                      => not KEY(0),                      --                       reset.reset_n
            led_pio_external_connection_export => LEDR(7 downto 0)  -- led_pio_external_connection.export
        );
end architecture;
