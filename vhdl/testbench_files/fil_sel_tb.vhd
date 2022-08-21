-- SPDX-License-Identifier: MIT License
-- Copyright (c) 2021 Alberto Alvarez

-- Author:      Alberto Alvarez Gonzalez
-- Date:        6th January, 2021
-- File:        fil_sel_tb.vhd
-- Description: Test bench of filter selector

library ieee;
use ieee.std_logic_1164.all;

entity fil_sel_tb is
end fil_sel_tb;

architecture arch_filter_tb of fil_sel_tb is
	component filter_selector
		port(
			filter_sel: in std_logic_vector(1 downto 0);
			shift: out std_logic_vector(3 downto 0);
			kc_1, kc_2, kc_3, kc_4, kc_5, kc_6, kc_7, kc_8, kc_9: out std_logic_vector(8 downto 0));	
	end component;

	signal filter_sel: std_logic_vector(1 downto 0);
	signal shift: std_logic_vector(3 downto 0);
	signal kc_1, kc_2, kc_3, kc_4, kc_5, kc_6, kc_7, kc_8, kc_9: std_logic_vector(8 downto 0);

	begin
		unit: filter_selector
		port map(filter_sel => filter_sel, shift => shift, kc_1 => kc_1,
			 kc_2 => kc_2, kc_3 => kc_3, kc_4 => kc_4, kc_5 => kc_5,
			kc_6 => kc_6, kc_7 => kc_7, kc_8 => kc_8, kc_9 => kc_9);

	process
	begin
		filter_sel <= "00";
		wait for 15 ns;
		filter_sel <= "01";
		wait for 15 ns;
		filter_sel <= "10";
		wait for 15 ns;
		filter_sel <= "11";
		wait for 15 ns;

	end process;
end arch_filter_tb;
