-- SPDX-License-Identifier: MIT License
-- Copyright (c) 2021 Alberto Alvarez

-- Author:      Alberto Alvarez Gonzalez
-- Date:        6th January, 2021
-- File:        shift_register_tb.vhd
-- Description: Test bench of shift register
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_textio.all;
library STD;
use STD.textio.all;

entity shift_register_tb is
end shift_register_tb;

architecture arch_shift of shift_register_tb is
	component shift_register
		port(
			clk, reset: in std_logic;
			d: in std_logic_vector(7 downto 0);
			q: out std_logic_vector(7 downto 0);
			pixel_1, pixel_2, pixel_3: out std_logic_vector(7 downto 0));	
	end component;
	
	signal clk: std_ulogic := '1';
	signal reset: std_logic;
	signal d, q: std_logic_vector(7 downto 0);
	signal pixel_1, pixel_2, pixel_3: std_logic_vector(7 downto 0);

	begin
		unit: shift_register
			port map(clk => clk, reset => reset, d => d, q => q, pixel_1 => pixel_1, pixel_2 => pixel_2, pixel_3 => pixel_3);
	
	process(clk)
		begin
		clk <= not clk after 10 ns;
	end process;
	
	process
		variable rd_line: line;
		variable tmp: std_logic_vector(7 downto 0);

	file vector_file: text open read_mode is "img.txt";

	begin
		while not endfile(vector_file) loop
			readline(vector_file, rd_line);
			read(rd_line, tmp);
			d <= tmp;
			wait for 20 ns;
		end loop;
	wait;
	end process;
end arch_shift;
