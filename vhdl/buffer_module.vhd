-- SPDX-License-Identifier: MIT License
-- Copyright (c) 2021 Alberto Alvarez

-- Author:      Alberto Alvarez Gonzalez
-- Date:        6th January, 2021
-- File:        buffer_module.vhd
-- Description: This buffer provides the image pixels efficiently

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity buffer_module is
	port(
		clk, reset: in std_logic;
		data_in: in std_logic_vector(7 downto 0);
		image_width: in std_logic_vector(12 downto 0);
		--image_height: in std_logic_vector(10 downto 0);
		pixel_1, pixel_2, pixel_3, pixel_4, pixel_5,
		pixel_6, pixel_7, pixel_8, pixel_9: out std_logic_vector(7 downto 0));
end buffer_module;

architecture arch_buffer_module of buffer_module is
	component shift_register
		port(
			clk, reset: in std_logic;
			d: in std_logic_vector(7 downto 0);
			q: out std_logic_vector(7 downto 0);
			pixel_1, pixel_2, pixel_3: out std_logic_vector(7 downto 0));
	end component;

	component pixel_buffer
		port(
			clk, reset: in std_logic;
			address: in std_logic_vector(12 downto 0);
			d_buffer: in std_logic_vector(7 downto 0);
			q_buffer: out std_logic_vector(7 downto 0));
	end component;
	
	signal first_pixel_in, second_pixel_in, final_pixel: std_logic_vector(7 downto 0);
	signal first_pixel_out, second_pixel_out: std_logic_vector(7 downto 0);
	signal image_width_add: std_logic_vector(12 downto 0);
		
	begin

		image_width_add <= std_logic_vector(unsigned(image_width) - 4); --image width - 1 - kernel size

		bottom_shift: shift_register
		port map( clk => clk, reset => reset, d => data_in, pixel_1 => pixel_9, pixel_2 => pixel_8, pixel_3 => pixel_7, q => first_pixel_in);
		
		first_buffer: pixel_buffer
		port map( clk => clk, reset => reset, address => image_width_add, d_buffer => first_pixel_in, q_buffer => first_pixel_out);

		middle_shift: shift_register
		port map( clk => clk, reset => reset, d => first_pixel_out, q => second_pixel_in, pixel_1 => pixel_6, pixel_2 => pixel_5, pixel_3 => pixel_4);
	
		second_buffer: pixel_buffer
		port map( clk => clk, reset => reset, address => image_width_add, d_buffer => second_pixel_in, q_buffer => second_pixel_out);
	
		top_shift: shift_register
		port map( clk => clk, reset => reset, d => second_pixel_out, q => final_pixel, pixel_1 => pixel_3, pixel_2 => pixel_2, pixel_3 => pixel_1);

end arch_buffer_module;
