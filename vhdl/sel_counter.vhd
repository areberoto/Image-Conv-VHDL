-- Author:      Alberto Alvarez Gonzalez
-- Date:        4th January, 2021
-- File:        sel_counter.vhd
-- Description: Counter that controls the multiplexers in the convolution module (1 to 9)


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sel_counter is
	port(
		clk, reset: in std_logic;
		q: out std_logic_vector(3 downto 0));
end sel_counter;

architecture arch_counter of sel_counter is
	constant NINE: integer := 9;
	signal r_reg: unsigned(3 downto 0);
	signal r_next: unsigned(3 downto 0);

begin
	--Register
	process(clk, reset)
	begin
		if(falling_edge(reset)) then
			r_reg <= (others => '0');
		elsif(rising_edge(clk)) then
			r_reg <= r_next;
		end if;
	end process;

	--Next-state logic
	r_next <= (others => '0') when r_reg = (NINE) else
		r_reg + 1;
	
	--output logic 
	q <= std_logic_vector(r_reg + 1);
end arch_counter;