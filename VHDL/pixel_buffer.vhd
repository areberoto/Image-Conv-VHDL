-- Author:      Alberto Alvarez Gonzalez
-- Date:        6th January, 2021
-- File:        pixel_buffer.vhd
-- Description: Pixel buffer for convolution. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pixel_buffer is
	port(
		clk, reset: in std_logic;
		address: in std_logic_vector(12 downto 0);
		d_buffer: in std_logic_vector(7 downto 0);
		q_buffer: out std_logic_vector(7 downto 0));
end pixel_buffer;

architecture arch_shift_register of pixel_buffer is
	signal r_reg_0: std_logic_vector(2556 downto 0);
	signal r_next_0: std_logic_vector(2556 downto 0);
	
	signal r_reg_1: std_logic_vector(2556 downto 0);
	signal r_next_1: std_logic_vector(2556 downto 0);
	
	signal r_reg_2: std_logic_vector(2556 downto 0);
	signal r_next_2: std_logic_vector(2556 downto 0);

	signal r_reg_3: std_logic_vector(2556 downto 0);
	signal r_next_3: std_logic_vector(2556 downto 0);

	signal r_reg_4: std_logic_vector(2556 downto 0);
	signal r_next_4: std_logic_vector(2556 downto 0);

	signal r_reg_5: std_logic_vector(2556 downto 0);
	signal r_next_5: std_logic_vector(2556 downto 0);

	signal r_reg_6: std_logic_vector(2556 downto 0);
	signal r_next_6: std_logic_vector(2556 downto 0);

	signal r_reg_7: std_logic_vector(2556 downto 0);
	signal r_next_7: std_logic_vector(2556 downto 0);

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
	r_next_0 <= d_buffer(0) & r_reg_0(2556 downto 1);
	r_next_1 <= d_buffer(1) & r_reg_1(2556 downto 1);
	r_next_2 <= d_buffer(2) & r_reg_2(2556 downto 1);
	r_next_3 <= d_buffer(3) & r_reg_3(2556 downto 1);
	r_next_4 <= d_buffer(4) & r_reg_4(2556 downto 1);
	r_next_5 <= d_buffer(5) & r_reg_5(2556 downto 1);
	r_next_6 <= d_buffer(6) & r_reg_6(2556 downto 1);
	r_next_7 <= d_buffer(7) & r_reg_7(2556 downto 1);

	--Output logic
	q_buffer(0) <= r_reg_0(2556 - to_integer(unsigned(address)));
	q_buffer(1) <= r_reg_1(2556 - to_integer(unsigned(address)));
	q_buffer(2) <= r_reg_2(2556 - to_integer(unsigned(address)));
	q_buffer(3) <= r_reg_3(2556 - to_integer(unsigned(address)));
	q_buffer(4) <= r_reg_4(2556 - to_integer(unsigned(address)));
	q_buffer(5) <= r_reg_5(2556 - to_integer(unsigned(address)));
	q_buffer(6) <= r_reg_6(2556 - to_integer(unsigned(address)));
	q_buffer(7) <= r_reg_7(2556 - to_integer(unsigned(address)));

end arch_shift_register;
