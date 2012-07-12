----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Memo
-- 
-- Create Date:    18:41:35 07/05/2012 
-- Design Name: 
-- Module Name:    SensorController - Behavioral 
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

entity SensorController is
port(
	mclock : in std_logic;
	reset : in std_logic;
	output : out std_logic_vector(4 downto 0);
	ready : out std_logic;
	input : in std_logic_vector(5 downto 0)
);
end SensorController;

architecture Behavioral of SensorController is

begin
	
	read_sensor : process(mclock, reset)
		variable previous_status : std_logic := '0';
	begin
		if reset = '1' then
			ready <= '0';
		elsif rising_edge(mclock) then
			ready <= '0';
			if input(5) = '1' and previous_status = '0' then
				output <= input(4 downto 0);
				ready <= '1';
			end if;
			previous_status := input(5);
		end if;
	end process;

end Behavioral;

