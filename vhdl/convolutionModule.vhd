-- Author:      Alberto Alvarez Gonzalez
-- Date:        4th January, 2021
-- File:        convolutionModule.vhd
-- Description: Main convolution module of the system


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity convolutionModule is
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
end convolutionModule;

architecture arch_conv_module of convolutionModule is
	component sel_counter
		port(
			clk, reset: in std_logic;
			q: out std_logic_vector(3 downto 0));
	end component;
	
	signal pixel_value: signed(8 downto 0);
	signal kernel_value: signed(8 downto 0);
	signal sel: std_logic_vector(3 downto 0);

	signal r_reg: signed(17 downto 0);
	signal tmp: unsigned(17 downto 0);
	signal tmp_shift: signed(17 downto 0);
	signal r_next: signed(17 downto 0);

	begin
		unit: sel_counter
		port map(clk => clk, reset => reset, q => sel);
		
		with sel select
			pixel_value <=  signed('0' & pixel_1) when "0001",
					signed('0' & pixel_2) when "0010",
					signed('0' & pixel_3) when "0011",
					signed('0' & pixel_4) when "0100",
					signed('0' & pixel_5) when "0101",
					signed('0' & pixel_6) when "0110",
					signed('0' & pixel_7) when "0111",
					signed('0' & pixel_8) when "1000",
					signed('0' & pixel_9) when others;
		
		with sel select
			kernel_value <= signed(kernel_1) when "0001",
					signed(kernel_2) when "0010",
					signed(kernel_3) when "0011",
					signed(kernel_4) when "0100",
					signed(kernel_5) when "0101",
					signed(kernel_6) when "0110",
					signed(kernel_7) when "0111",
					signed(kernel_8) when "1000",
					signed(kernel_9) when others;
		
		
		--Sum process
		--Register
		process(clk, reset)
		begin
			if(reset = '1') then
				r_reg <= (others => '0');
			elsif(rising_edge(clk)) then
				r_reg <= r_next;
			end if;
		end process;

		--Next-state logic
		r_next <= (others => '0') when reset = '1' else
			(pixel_value * kernel_value) when sel = "0001" else
			r_reg when sel = "1010" else
			r_reg + (pixel_value * kernel_value);		
	
		--Saturation
		tmp <=  "000000000011111111" when (tmp_shift > to_signed(255, 18)) else
			"000000000000000000" when (tmp_shift < to_signed(0, 18)) else
			unsigned(tmp_shift);
		
		--output logic with truncation
		tmp_shift <= signed(shift_right(r_reg, to_integer(unsigned(shift))));
		data_out <= std_logic_vector(resize(tmp, 8));
		data_ready <= '1' when sel = "1010" else '0';
	
end arch_conv_module;