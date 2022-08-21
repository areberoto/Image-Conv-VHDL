-- Author:      Alberto Alvarez Gonzalez
-- Date:        5th January, 2021
-- File:        clock_divider.vhd
-- Description: Clock divider by 10


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity clock_divider is
	port(
		clk, reset: in std_logic;
		clock_out: out std_logic);
end clock_divider;

architecture arch_clock_divider of clock_divider is
	signal count: integer :=1;
	signal tmp: std_logic := '1';

	begin
		process(clk, reset)
		begin
			if(reset = '1') then
				count <= 1;
				tmp <= '1';
			elsif(rising_edge(clk)) then
				count <= count + 1;
			if(count = 5) then
				tmp <= NOT tmp;
				count <= 1;
			end if;
			end if;
	end process;
	clock_out <= tmp;
end arch_clock_divider;
