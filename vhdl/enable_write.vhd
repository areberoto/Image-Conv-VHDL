-- Author:      Alberto Alvarez Gonzalez
-- Date:        8th January, 2021
-- File:        enable_write.vhd
-- Description: Indicates when to write output to file


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity enable_write is
	port(
		data_ready: in std_logic;
		reset: in std_logic;
		image_width: in std_logic_vector(12 downto 0);
		image_height: in std_logic_vector(12 downto 0);
		enable: out std_logic);
end enable_write;

architecture arch_enable_write of enable_write is
	component counter
		port(
			clk, reset: in std_logic;
			q: out std_logic_vector(31 downto 0));
	end component;

	component counter_write
		port(
			clk, enable, reset: in std_logic;
			image_width: std_logic_vector(12 downto 0);
			q: out std_logic_vector(31 downto 0));
	end component;
	
	signal filling: std_logic;
	signal emptying, enable_tmp: std_logic;
	signal cmp_tmp, not_circular: std_logic_vector(31 downto 0);

	signal fase, tmp: unsigned(25 downto 0);
	
	begin
		unit: counter
		port map(clk => data_ready, reset => reset, q => cmp_tmp);
		
		unit_2: counter_write
		port map(clk => data_ready, reset => reset, enable => enable_tmp, image_width => image_width, q => not_circular);

	fase <= (unsigned(image_width) * 2 + 4);
	tmp <= unsigned(image_width) * (unsigned(image_height));

	filling <= '1' when (unsigned(cmp_tmp) < fase) else '0';
	emptying <= '1' when (unsigned(cmp_tmp) < tmp + 2) else '0';
	
	enable_tmp <= '1' when (filling = '0' and emptying = '1') else '0';
	enable <= '1' when (enable_tmp = '1' and unsigned(not_circular) < (unsigned(image_width) - 2)) else '0';
	--enable <= '1' when (filling = '0' and emptying = '1') else '0';		
	
end arch_enable_write;
