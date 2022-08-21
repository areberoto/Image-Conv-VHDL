-- SPDX-License-Identifier: MIT License
-- Copyright (c) 2021 Alberto Alvarez

-- Author:      Alberto Alvarez Gonzalez
-- Date:        7th January, 2021
-- File:        buffer_module_tb.vhd
-- Description: Test bench of buffer module

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_textio.all;
library STD;
use STD.textio.all;

entity buffer_module_tb is
end buffer_module_tb;

architecture arch_buffer_module_tb of buffer_module_tb is
	component buffer_module
		port(
			clk, reset: in std_logic;
			data_in: in std_logic_vector(7 downto 0);
			image_width: in std_logic_vector(12 downto 0);
			--image_height: in std_logic_vector(10 downto 0);
			pixel_1, pixel_2, pixel_3, pixel_4, pixel_5,
			pixel_6, pixel_7, pixel_8, pixel_9: out std_logic_vector(7 downto 0));
	end component;
	
	signal clk: std_ulogic := '1';
	signal reset: std_logic;
	signal address: std_logic_vector(12 downto 0);
	signal d, q: std_logic_vector(7 downto 0);
	signal pixel_1, pixel_2, pixel_3, pixel_4, pixel_5,
	       pixel_6, pixel_7, pixel_8, pixel_9: std_logic_vector(7 downto 0);

	begin
		unit: buffer_module
			port map(clk => clk, reset => reset, data_in => d, image_width => address, pixel_1 => pixel_1, pixel_2 => pixel_2,
				pixel_3 => pixel_3, pixel_4 => pixel_4, pixel_5 => pixel_5, pixel_6 => pixel_6, pixel_7 => pixel_7,
				pixel_8 => pixel_8, pixel_9 => pixel_9);
	
	process(clk)
		begin
		clk <= not clk after 10 ns;
	end process;
	
	process
		variable rd_line: line;
		variable tmp: std_logic_vector(7 downto 0);

	file vector_file: text open read_mode is "test.txt";

	begin
		while not endfile(vector_file) loop
			readline(vector_file, rd_line);
			read(rd_line, tmp);
			d <= tmp;
			wait for 20 ns;
		end loop;
	wait;
	end process;
	address <= "0000000001000";
	

end arch_buffer_module_tb;
