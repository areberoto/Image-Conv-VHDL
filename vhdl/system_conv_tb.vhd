-- Author:      Alberto Alvarez Gonzalez
-- Date:        7th January, 2021
-- File:        system_conv_tb.vhd
-- Description: Test bench of the system

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_textio.all;
library STD;
use STD.textio.all;

entity system_conv_tb is
end system_conv_tb;

architecture arch_system_conv_tb of system_conv_tb is
	component system_conv
		port(
			filter_sel: in std_logic_vector(1 downto 0);
			reset, global_clock: in std_logic;
			data_read: in std_logic_vector(7 downto 0);
			image_width: in std_logic_vector(12 downto 0);
			image_height: in std_logic_vector(12 downto 0);
			data_write: out std_logic_vector(7 downto 0);
			enable: out std_logic;
			data_ready: out std_logic;

			--Test signals
			clk_test_div: out std_logic;
			pixel_1, pixel_2, pixel_3, pixel_4, pixel_5,
			pixel_6, pixel_7, pixel_8, pixel_9: out std_logic_vector(7 downto 0));
	end component;
	
	signal clk: std_ulogic := '1';
	signal reset: std_logic;
	signal filter_sel: std_logic_vector(1 downto 0);
	signal image_width, image_height: std_logic_vector(12 downto 0);
	signal data_write: std_logic_vector(7 downto 0);
	signal enable, data_ready: std_logic;
	signal data_read: std_logic_vector(7 downto 0);

	--test signals
	signal clk_test_div: std_logic;
	signal pixel_1, pixel_2, pixel_3, pixel_4, pixel_5,
		pixel_6, pixel_7, pixel_8, pixel_9: std_logic_vector(7 downto 0);

	begin
		unit: system_conv
			port map(global_clock => clk, reset => reset, filter_sel => filter_sel, image_width => image_width, image_height => image_height,
				data_read => data_read, data_write => data_write, enable => enable, data_ready => data_ready, clk_test_div => clk_test_div,
				pixel_1 => pixel_1, pixel_2 => pixel_2, pixel_3 => pixel_3, pixel_4 => pixel_4, pixel_5 => pixel_5,
				pixel_6 => pixel_6, pixel_7 => pixel_7, pixel_8 => pixel_8, pixel_9 => pixel_9);
	
	process(clk)
		begin
		clk <= not clk after 7 ns;
	end process;

	process(data_ready, enable)
		variable wr_line: line;
		file out_file: text open write_mode is "result_cat_3.txt";

		begin
		if(enable = '1' and rising_edge(data_ready)) then
			write(wr_line, data_write);
			writeline(out_file, wr_line);
		end if;
	end process;

	process
		variable rd_line: line;
		variable tmp: std_logic_vector(7 downto 0);
		file vector_file: text open read_mode is "img_3.txt";
	
		begin
		image_width <= "0001000000000";
		image_height <= "0000110011010";

		filter_sel <= "11";
	
		reset <= '1';
		wait for 17 ns;
		reset <= '0';

		while not endfile(vector_file) loop
			readline(vector_file, rd_line);
			read(rd_line, tmp);
			data_read <= tmp;
			wait for 140 ns;	
		end loop;		
		wait;
	end process;

end arch_system_conv_tb;
