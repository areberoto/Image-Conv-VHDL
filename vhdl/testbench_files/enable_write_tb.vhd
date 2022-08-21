-- SPDX-License-Identifier: MIT License
-- Copyright (c) 2021 Alberto Alvarez

-- Author:      Alberto Alvarez Gonzalez
-- Date:        8th January, 2021
-- File:        enable_write_tb.vhd
-- Description: Test bench of enable_write

library ieee;
use ieee.std_logic_1164.all;

entity enable_write_tb is
end enable_write_tb;

architecture arch_enable_tb of enable_write_tb is
	component enable_write
		port(
			data_ready: in std_logic;
			reset: in std_logic;
			image_width: in std_logic_vector(12 downto 0);
			image_height: in std_logic_vector(12 downto 0);
			enable: out std_logic);
	end component;

	signal reset_test: std_logic;
	signal image_width, image_height: std_logic_vector(12 downto 0);
	signal enable: std_logic;
	signal clock: std_ulogic := '1';

	begin
		unit: enable_write
		port map(data_ready => clock, reset => reset_test, image_width => image_width, image_height => image_height, enable => enable);
	
	process(clock)
		begin
		clock <= not clock after 10 ns;
	end process;

	process
	begin
		--Reset counter
		reset_test <= '1';
		image_width <= "0000000010011";
		image_height <= "0000000001111";
		wait for 10 ns;

		for i in 300 downto 0 loop
			reset_test <= '0';
			wait for 20 ns;
		end loop;

	end process;
end arch_enable_tb;
