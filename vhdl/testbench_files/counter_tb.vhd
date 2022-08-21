-- SPDX-License-Identifier: MIT License
-- Copyright (c) 2021 Alberto Alvarez

-- Author:      Alberto Alvarez Gonzalez
-- Date:        20th June, 2020
-- File:        counter_8b_tb.vhd
-- Description: Test bench of free running 8-bits binary counter

library ieee;
use ieee.std_logic_1164.all;

entity counter_tb is
end counter_tb;

architecture arch_mod_m_counter_tb of counter_tb is
	component sel_counter
		port(
			clk, reset: in std_logic;
			q: out std_logic_vector(3 downto 0));
	end component;

	signal reset_test: std_logic;
	signal q_test: std_logic_vector(3 downto 0);
	signal clock: std_ulogic := '1';

	begin
		unit: sel_counter
		port map(clk => clock, reset => reset_test, q => q_test);
	
	process(clock)
		begin
		clock <= not clock after 10 ns;
	end process;

	process
	begin
		--Reset counter
		reset_test <= '1';
		wait for 10 ns;

		for i in 50 downto 0 loop
			reset_test <= '0';
			wait for 10 ns;
		end loop;

	end process;
end arch_mod_m_counter_tb;
