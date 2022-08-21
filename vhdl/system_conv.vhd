-- Author:      Alberto Alvarez Gonzalez
-- Date:        6th January, 2021
-- File:        system_conov.vhd
-- Description: System for convolution filtering

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity system_conv is
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
		
end system_conv;

architecture arch_system_conv of system_conv is
	component clock_divider
		port(
			clk, reset: in std_logic;
			clock_out: out std_logic);
	end component;
	
	component filter_selector
		port(
			filter_sel: in std_logic_vector(1 downto 0);
			shift: out std_logic_vector(3 downto 0);
			kc_1, kc_2, kc_3, kc_4, kc_5, kc_6, kc_7, kc_8, kc_9: out std_logic_vector(8 downto 0));
	end component;

	component buffer_module
		port(
			clk, reset: in std_logic;
			data_in: in std_logic_vector(7 downto 0);
			image_width: in std_logic_vector(12 downto 0);
			--image_height: in std_logic_vector(10 downto 0);
			pixel_1, pixel_2, pixel_3, pixel_4, pixel_5,
			pixel_6, pixel_7, pixel_8, pixel_9: out std_logic_vector(7 downto 0));
	end component;

	component convolutionModule
		port(
			pixel_1, pixel_2, pixel_3, pixel_4, pixel_5, pixel_6, 
			pixel_7, pixel_8, pixel_9: in std_logic_vector(7 downto 0);

			kernel_1, kernel_2, kernel_3, kernel_4, kernel_5, kernel_6,
			kernel_7, kernel_8, kernel_9: in std_logic_vector(8 downto 0); 
		
			shift: in std_logic_vector(3 downto 0);
			reset: in std_logic;
			clk: in std_logic;
			data_out: out std_logic_vector(7 downto 0);
			data_ready: out std_logic);
	end component;

	component enable_write
		port(
			data_ready: in std_logic;
			reset: in std_logic;
			image_width: in std_logic_vector(12 downto 0);
			image_height: in std_logic_vector(12 downto 0);
			enable: out std_logic);
	end component;

	signal clock_signal, clock_enable: std_logic;
	signal shift_signal: std_logic_vector(3 downto 0);
	signal p_1, p_2, p_3, p_4, p_5, p_6, p_7, p_8, p_9: std_logic_vector(7 downto 0);
	signal k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8, k_9: std_logic_vector(8 downto 0);
	
	begin
		unit_1: clock_divider
		port map(clk => global_clock, reset => reset, clock_out => clock_signal);

		unit_2: buffer_module
		port map(clk => clock_signal, reset => reset, data_in => data_read, image_width => image_width,
			pixel_1 => p_1, pixel_2 => p_2, pixel_3 => p_3, pixel_4 => p_4, pixel_5 => p_5, pixel_6 => p_6,
			pixel_7 => p_7, pixel_8 => p_8, pixel_9 => p_9);

		unit_3: filter_selector
		port map(filter_sel => filter_sel, shift => shift_signal, kc_1 => k_1, kc_2 => k_2, kc_3 => k_3, kc_4 => k_4,
			kc_5 => k_5, kc_6 => k_6, kc_7 => k_7, kc_8 => k_8, kc_9 => k_9);

		unit_4: convolutionModule
		port map(pixel_1 => p_1, pixel_2 => p_2, pixel_3 => p_3, pixel_4 => p_4, pixel_5 => p_5, pixel_6 => p_6, pixel_7 => p_7,
			pixel_8 => p_8, pixel_9 => p_9, kernel_1 => k_1, kernel_2 => k_2, kernel_3 => k_3, kernel_4 => k_4, kernel_5 => k_5,
			kernel_6 => k_6, kernel_7 => k_7, kernel_8 => k_8, kernel_9 => k_9, shift => shift_signal, reset => reset, clk => global_clock,
			data_out => data_write, data_ready => clock_enable);
	
		unit_5: enable_write
		port map(data_ready => clock_enable, reset => reset, image_width => image_width, image_height => image_height, enable => enable);

	--Test signals
	clk_test_div <= clock_signal;
	data_ready <= clock_enable; --test
	pixel_1 <= p_1;
	pixel_2 <= p_2;
	pixel_3 <= p_3;
	pixel_4 <= p_4;
	pixel_5 <= p_5;
	pixel_6 <= p_6;
	pixel_7 <= p_7;
	pixel_8 <= p_8;
	pixel_9 <= p_9;

end arch_system_conv;	
