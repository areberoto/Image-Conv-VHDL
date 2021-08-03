-- Author:      Alberto Alvarez Gonzalez
-- Date:        4th January, 2021
-- File:        conv_tb.vhd
-- Description: Test bench of convolution module

library ieee;
use ieee.std_logic_1164.all;

entity conv_tb is
end conv_tb;

architecture arch_conv_tb of conv_tb is
	component convolutionModule
		port(
			pixel_1: in std_logic_vector(7 downto 0);
			pixel_2: in std_logic_vector(7 downto 0); 
			pixel_3: in std_logic_vector(7 downto 0);
			pixel_4: in std_logic_vector(7 downto 0);
			pixel_5: in std_logic_vector(7 downto 0);
			pixel_6: in std_logic_vector(7 downto 0);
			pixel_7: in std_logic_vector(7 downto 0);
			pixel_8: in std_logic_vector(7 downto 0);
			pixel_9: in std_logic_vector(7 downto 0);

			kernel_1: in std_logic_vector(8 downto 0); 
			kernel_2: in std_logic_vector(8 downto 0); 
			kernel_3: in std_logic_vector(8 downto 0);
			kernel_4: in std_logic_vector(8 downto 0);
			kernel_5: in std_logic_vector(8 downto 0);
			kernel_6: in std_logic_vector(8 downto 0);
			kernel_7: in std_logic_vector(8 downto 0);
			kernel_8: in std_logic_vector(8 downto 0);
			kernel_9: in std_logic_vector(8 downto 0);
		
			shift: in std_logic_vector(3 downto 0);
			reset: in std_logic;
			clk: in std_logic;
			data_out: out std_logic_vector(7 downto 0);
			data_ready: out std_logic);
	end component;

	signal p_1, p_2, p_3, p_4, p_5, p_6, p_7, p_8, p_9: std_logic_vector(7 downto 0);
	signal k_1, k_2, k_3, k_4, k_5, k_6, k_7, k_8, k_9: std_logic_vector(8 downto 0);
	signal reset_test: std_logic;	
	signal data_test: std_logic_vector(7 downto 0);
	signal clock_test: std_ulogic := '1';
	signal shift_test: std_logic_vector(3 downto 0);
	signal data_ready_t: std_logic;

	begin
		unit: convolutionModule
		port map(pixel_1 => p_1, pixel_2 => p_2, pixel_3 => p_3, pixel_4 => p_4, pixel_5 => p_5, pixel_6 => p_6, pixel_7 => p_7, pixel_8 => p_8, pixel_9 => p_9,
			kernel_1 => k_1, kernel_2 => k_2, kernel_3 => k_3, kernel_4 => k_4, kernel_5 => k_5, kernel_6 => k_6, kernel_7 => k_7, kernel_8 => k_8, kernel_9 => k_9,
			clk => clock_test, reset => reset_test, data_out => data_test, shift => shift_test, data_ready => data_ready_t);
	
	process(clock_test)
		begin
		clock_test <= not clock_test after 10 ns;
	end process;

	process
	begin
		--Reset counter
		reset_test <= '1';
		p_1 <= "01010111";
		p_2 <= "01011110";
		p_3 <= "00000000";
		p_4 <= "01000101";
		p_5 <= "01110000";
		p_6 <= "00100011";
		p_7 <= "01001110";
		p_8 <= "10000100";
		p_9 <= "01001001";

		k_1 <= "000000000";
		k_2 <= "111111111";
		k_3 <= "000000000";
		k_4 <= "111111111";
		k_5 <= "000000101";
		k_6 <= "111111111";
		k_7 <= "000000000";
		k_8 <= "111111111";
		k_9 <= "000000000";

		shift_test <= "0000";
		
		wait for 10 ns;
	
		for i in 50 downto 0 loop
			reset_test <= '0';
			wait for 10 ns;
		end loop;
	
	end process;
end arch_conv_tb;
