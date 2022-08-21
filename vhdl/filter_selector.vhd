-- Author:      Alberto Alvarez Gonzalez
-- Date:        6th January, 2021
-- File:        filter_selector.vhd
-- Description: Filter selector module. Kernels are stored here.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filter_selector is
	port(
		filter_sel: in std_logic_vector(1 downto 0);
		shift: out std_logic_vector(3 downto 0);
		kc_1, kc_2, kc_3, kc_4, kc_5, kc_6, kc_7, kc_8, kc_9: out std_logic_vector(8 downto 0));	
end filter_selector;

architecture arch_filter_sel of filter_selector is
	begin
		kc_1 <= "000000001" when (filter_sel = "11") else
			"000000000";
		kc_2 <= "111111111" when (filter_sel = "01" or filter_sel = "10") else
			"000000010" when (filter_sel = "11") else
			"000000000";
		kc_3 <= "000000001" when (filter_sel = "11") else
			"000000000";
		kc_4 <= "111111111" when (filter_sel = "01" or filter_sel = "10") else
			"000000010" when (filter_sel = "11") else
			"000000000";
		kc_5 <= "000000100" when (filter_sel = "01" or filter_sel = "11") else
			"000000101" when (filter_sel = "10") else
			"000000001";
		kc_6 <= "111111111" when (filter_sel = "01" or filter_sel = "10") else
			"000000010" when (filter_sel = "11") else
			"000000000";
		kc_7 <= "000000001" when (filter_sel = "11") else
			"000000000";
		kc_8 <= "111111111" when (filter_sel = "01" or filter_sel = "10") else
			"000000010" when (filter_sel = "11") else
			"000000000";
		kc_9 <= "000000001" when (filter_sel = "11") else
			"000000000";
	
		shift <= "0100" when (filter_sel = "11") else
			"0000";
end arch_filter_sel;