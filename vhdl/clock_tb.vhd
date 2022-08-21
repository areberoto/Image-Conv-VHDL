-- Author:      Alberto Alvarez Gonzalez
-- Date:        20th June, 2020
-- File:        clock_tb.vhd
-- Description: Test bench of clock divider

library ieee;
use ieee.std_logic_1164.all;

entity clock_tb is
end clock_tb;

architecture arch_clock_tb of clock_tb is
	component clock_divider
		port(
			clk, reset: in std_logic;
			clock_out: out std_logic);
	end component;

	signal clk: std_logic := '1';
	signal reset: std_logic := '0';
	signal clock_out: std_logic;
	constant clk_period: time := 14.992 ns;

	begin
		unit: clock_divider
		port map(clk => clk, reset => reset, clock_out => clock_out);
	
	process
		begin
		clk <= '1';
		wait for clk_period / 2;
		clk <= '0';
		wait for clk_period / 2;
	end process;

	process
	begin
		--Reset counter
		wait for 1000 ns;
		reset <= '1';
		wait for 10 ns;
		reset <= '0';
		wait;
	end process;

end arch_clock_tb;
