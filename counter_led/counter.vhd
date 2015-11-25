----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:35:43 11/13/2015 
-- Design Name: 
-- Module Name:    counter8 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
	generic (
		WIDTH : integer := 8;
		PRESCALE : integer := 1 --scale the clock frequency
	);port( 
		rst : in std_logic;
		clk : in std_logic;
		count : out  STD_LOGIC_VECTOR (WIDTH-1 downto 0)
	 );
end counter;

architecture Behavioral of counter is
	signal count_in : unsigned(WIDTH -1 downto 0) := (others => '0');
	signal prescale_count : unsigned(PRESCALE -1 downto 0) := (others => '0');
begin
	process(clk,rst) is
	begin
		if rst = '1' then
			prescale_count <= (others => '0');
			count_in <= (others => '0');
		elsif rising_edge(clk) then
			prescale_count <= prescale_count + 1;
			
			if prescale_count = 0 then
				count_in <= count_in + 1;
			end if;
		end if;
	end process;
	
	count <= std_logic_vector(count_in);


end Behavioral;
