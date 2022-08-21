-- SPDX-License-Identifier: MIT License
-- Copyright (c) 2021 Alberto Alvarez

-- Author:      Alberto Alvarez Gonzalez
-- Date:        8th January, 2021
-- File:        counter.vhd
-- Description: Counter for enabling writing

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	port(
		clk, reset: in std_logic;
		q: out std_logic_vector(31 downto 0));
end counter;

architecture arch_counter_enable of counter is
	constant LIMIT: integer := 16777216;
	signal r_reg: unsigned(31 downto 0);
	signal r_next: unsigned(31 downto 0);

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
	r_next <= (others => '0') when r_reg = (LIMIT) else
		r_reg + 1;
	
	--output logic 
	q <= std_logic_vector(r_reg);
end arch_counter_enable;
