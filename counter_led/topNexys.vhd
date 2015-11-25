----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:10:37 11/13/2015 
-- Design Name: 
-- Module Name:    topA - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topA is
port(
	CLK : in  STD_LOGIC;
	RST   : IN    std_logic;
	LED : out  STD_LOGIC_VECTOR (7 downto 0)
	);

end topA;

architecture Behavioral of topA is

	component counter is
		generic (
			WIDTH : integer := 8;
			PRESCALE : integer := 1 --scale the clock frequency
		);
		 Port ( 
		 rst : in std_logic;
		 clk : in std_logic;
		 count : out  STD_LOGIC_VECTOR (7 downto 0)
		 );
	end component;


	
	

begin



	--the counter displayed on leds
	count_led : counter
	generic map(
		PRESCALE => 22
	)port map(
		rst => not(rst),
		clk => clk,
		count => LED);
	

end Behavioral;
