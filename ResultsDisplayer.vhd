----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Tavo
-- 
-- Create Date:    18:48:49 07/05/2012 
-- Design Name: 
-- Module Name:    ResultsDisplayer - Behavioral 
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

entity ResultsDisplayer is
port(
	mclock : in std_logic;
	reset : in std_logic;
	hsync : out std_logic;
	vsync : out std_logic;
	rgb : out std_logic_vector(2 downto 0)
);
end ResultsDisplayer;

architecture Behavioral of ResultsDisplayer is
	
	signal hpos, vpos : integer;
	signal blank : std_logic;
	
begin
	
	vgaController : entity work.VGAController
	port map(
		reset => reset,
		clock => mclock,
		hpos => hpos,
		vpos => vpos,
		hsync => hsync,
		vsync => vsync,
		blank => blank
	);
	
	paint : process(mclock, reset)
	begin
		if reset = '1' then
			rgb <= "000";
		elsif rising_edge(mclock) then
			if blank = '0' then
				rgb <= "010";
			else
				rgb <= "000";
			end if;
		end if;
	end process;
	
end Behavioral;

