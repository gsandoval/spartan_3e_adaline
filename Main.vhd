----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Dzul
-- 
-- Create Date:    18:39:25 07/05/2012 
-- Design Name: 
-- Module Name:    Main - Behavioral 
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

entity Main is
port(
	mclock : in std_logic;
	reset : in std_logic;
	
	leds : out std_logic_vector(4 downto 0);
	
	j1 : in std_logic_vector(3 downto 0);
	j2 : in std_logic_vector(1 downto 0);
	
	vga_hsync : out std_logic;
	vga_vsync : out std_logic;
	vga_rgb : out std_logic_vector(2 downto 0);
	
	lcd_strataflash_disable : out std_logic;
	lcd_enabled : out std_logic;
	lcd_rs : out std_logic;
	lcd_rw : out std_logic;
	lcd_db : out std_logic_vector(3 downto 0)
);
end Main;

architecture Behavioral of Main is
	
	signal sensor_data : std_logic_vector(4 downto 0);
	signal sensor_ready : std_logic;
	signal sensor_input : std_logic_vector(5 downto 0);
	
begin
	
	sensorController : entity work.SensorController
	port map(
		mclock => mclock,
		reset => reset,
		input => sensor_input,
		output => sensor_data,
		ready => sensor_ready
	);
	
	adaline : entity work.Adaline
	port map(
		mclock => mclock,
		reset => reset
	);
	
	statusDisplayer : entity work.StatusDisplayer
	port map(
		mclock => mclock,
		reset => reset,
		strataflash_disable => lcd_strataflash_disable,
		enabled => lcd_enabled,
		rs => lcd_rs,
		rw => lcd_rw,
		db => lcd_db
	);
	
	resultsDisplayer : entity work.ResultsDisplayer
	port map(
		mclock => mclock,
		reset => reset,
		rgb => vga_rgb,
		hsync => vga_hsync,
		vsync => vga_vsync
	);
	
	sensor_input <= j2(1 downto 0) & j1; -- Setup sensor input
	
	sensor_visual_acknowledge : process(mclock, reset) -- Turns on and off leds according to the sensor input
	begin
		if reset = '1' then
		elsif rising_edge(mclock) then
			if sensor_ready = '1' then
				leds(4 downto 0) <= sensor_data;
			end if;
		end if;
	end process;

end Behavioral;

