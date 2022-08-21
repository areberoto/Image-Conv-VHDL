-- SPDX-License-Identifier: MIT License
-- Copyright (c) 2021 Alberto Alvarez

-- Author:      Alberto Alvarez Gonzalez
-- Date:        11th January, 2021
-- File:        counter_write.vhd
-- Description: Counter for enabling writing not circular convolution

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_write is
	port(
		clk, enable, reset: in std_logic;
		image_width: std_logic_vector(12 downto 0);
		q: out std_logic_vector(31 downto 0));
end counter_write;

architecture arch_counter_write of counter_write is
	signal r_reg: unsigned(31 downto 0);
	signal r_next: unsigned(31 downto 0);

begin
	--Register
	process(clk, reset, enable)
	begin
		if(falling_edge(reset)) then
			r_reg <= (others => '0');
		elsif(rising_edge(clk)) then
			r_reg <= r_next;
		end if;
	end process;

	--Next-state logic
	r_next <= (others => '0') when r_reg = (unsigned(image_width) - 1) else
		r_reg + 1 when enable = '1' else
		r_reg;
	
	--output logic 
	q <= std_logic_vector(r_reg);
end arch_counter_write;
