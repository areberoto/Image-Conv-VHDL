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

entity pixel_buffer_tb is
end pixel_buffer_tb;

architecture arch_pixel_buffer of pixel_buffer_tb is
	component pixel_buffer
		port(
			clk, reset: in std_logic;
			address: in std_logic_vector(12 downto 0);
			d_buffer: in std_logic_vector(7 downto 0);
			q_buffer: out std_logic_vector(7 downto 0));
	end component;
	
	signal clk: std_ulogic := '1';
	signal reset: std_logic;
	signal address: std_logic_vector(12 downto 0);
	signal d, q: std_logic_vector(7 downto 0);

	begin
		unit: pixel_buffer
			port map(clk => clk, reset => reset, d_buffer => d, q_buffer => q, address => address);
	
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
	address <= "0000000000111";

end arch_pixel_buffer;
