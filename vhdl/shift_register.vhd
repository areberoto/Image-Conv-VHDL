-- SPDX-License-Identifier: MIT License
-- Copyright (c) 2021 Alberto Alvarez

-- Author:      Alberto Alvarez Gonzalez
-- Date:        6th January, 2021
-- File:        shift_register.vhd
-- Description: 3-bit free-running shift register in block of 8. Basic component of buffer module

library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
	port(
		clk, reset: in std_logic;
		d: in std_logic_vector(7 downto 0);
		q: out std_logic_vector(7 downto 0);
		pixel_1, pixel_2, pixel_3: out std_logic_vector(7 downto 0));	
end shift_register;

architecture arch_shift_register of shift_register is
	signal r_reg_0: std_logic_vector(2 downto 0);
	signal r_next_0: std_logic_vector(2 downto 0);
	
	signal r_reg_1: std_logic_vector(2 downto 0);
	signal r_next_1: std_logic_vector(2 downto 0);
	
	signal r_reg_2: std_logic_vector(2 downto 0);
	signal r_next_2: std_logic_vector(2 downto 0);

	signal r_reg_3: std_logic_vector(2 downto 0);
	signal r_next_3: std_logic_vector(2 downto 0);

	signal r_reg_4: std_logic_vector(2 downto 0);
	signal r_next_4: std_logic_vector(2 downto 0);

	signal r_reg_5: std_logic_vector(2 downto 0);
	signal r_next_5: std_logic_vector(2 downto 0);

	signal r_reg_6: std_logic_vector(2 downto 0);
	signal r_next_6: std_logic_vector(2 downto 0);

	signal r_reg_7: std_logic_vector(2 downto 0);
	signal r_next_7: std_logic_vector(2 downto 0);

	begin
	--Register
	process(clk, reset)
		begin
		if(reset = '1') then
			r_reg_0 <= (others => '0');
			r_reg_1 <= (others => '0');
			r_reg_2 <= (others => '0');
			r_reg_3 <= (others => '0');
			r_reg_4 <= (others => '0');
			r_reg_5 <= (others => '0');
			r_reg_6 <= (others => '0');
			r_reg_7 <= (others => '0');
		elsif(rising_edge(clk)) then
			r_reg_0 <= r_next_0;
			r_reg_1 <= r_next_1;
			r_reg_2 <= r_next_2;
			r_reg_3 <= r_next_3;
			r_reg_4 <= r_next_4;
			r_reg_5 <= r_next_5;
			r_reg_6 <= r_next_6;
			r_reg_7 <= r_next_7;
		end if;
	end process;
	
	--Next state logic
	r_next_0 <= d(0) & r_reg_0(2 downto 1);
	r_next_1 <= d(1) & r_reg_1(2 downto 1);
	r_next_2 <= d(2) & r_reg_2(2 downto 1);
	r_next_3 <= d(3) & r_reg_3(2 downto 1);
	r_next_4 <= d(4) & r_reg_4(2 downto 1);
	r_next_5 <= d(5) & r_reg_5(2 downto 1);
	r_next_6 <= d(6) & r_reg_6(2 downto 1);
	r_next_7 <= d(7) & r_reg_7(2 downto 1);

	--Output logic
	q(0) <= r_reg_0(0);
	q(1) <= r_reg_1(0);
	q(2) <= r_reg_2(0);
	q(3) <= r_reg_3(0);
	q(4) <= r_reg_4(0);
	q(5) <= r_reg_5(0);
	q(6) <= r_reg_6(0);
	q(7) <= r_reg_7(0);

	pixel_1 <= r_reg_7(2) & r_reg_6(2) & r_reg_5(2) & r_reg_4(2) & r_reg_3(2) & r_reg_2(2) & r_reg_1(2) & r_reg_0(2);
	pixel_2 <= r_reg_7(1) & r_reg_6(1) & r_reg_5(1) & r_reg_4(1) & r_reg_3(1) & r_reg_2(1) & r_reg_1(1) & r_reg_0(1);
	pixel_3 <= r_reg_7(0) & r_reg_6(0) & r_reg_5(0) & r_reg_4(0) & r_reg_3(0) & r_reg_2(0) & r_reg_1(0) & r_reg_0(0);

end arch_shift_register;
