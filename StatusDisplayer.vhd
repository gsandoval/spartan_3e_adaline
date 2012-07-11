----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Isai
-- 
-- Create Date:    18:48:14 07/05/2012 
-- Design Name: 
-- Module Name:    StatusDisplayer - Behavioral 
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

entity StatusDisplayer is
port(
	mclock : in std_logic;
	reset : in std_logic;
	strataflash_disable : out std_logic;
	enabled : out std_logic;
	rs : out std_logic; -- 1 data register; 0 command/instruction
	rw : out std_logic;
	db : out std_logic_vector(3 downto 0)
);
end StatusDisplayer;

architecture Behavioral of StatusDisplayer is
	
	signal data, goto : std_logic_vector(7 downto 0);
	signal data_request, clear, goto_request, request_served, display_ready : std_logic;
	
begin
	
	lcdController : entity work.HitachiLcdController
	port map(
		mclock => mclock,
		reset => reset,
		enabled => enabled,
		rs => rs,
		rw => rw,
		db => db,
		data => data,
		data_request => data_request,
		clear => clear,
		goto => goto,
		goto_request => goto_request,
		request_served => request_served,
		display_ready => display_ready
	);
	
	test : process(reset, mclock, request_served)
		variable counter : integer range 0 to 50000000 := 1;
		constant line1 : string(1 to 11) := "Hola mundo.";
		constant line2 : string(1 to 7) := "World 4";
		variable letter_index : integer := 0;
	begin
		if reset = '1' then
			counter := 1;
		elsif rising_edge(mclock) then
--					if counter = 1 then
--						goto <= "10000011";
--						goto_request <= '1';
--					elsif request_served = '1' then
--						goto_request <= '0';
--						fsm <= send1;
--						counter := 0;
--					end if;
--				
--					if counter = 1 then
--						letter_index := letter_index + 1;
--						data <= conv_std_logic_vector(character'pos(line1(letter_index)), 8);
--						data_request <= '1';
--					elsif request_served = '1' then
--						data_request <= '0';
--						counter := 0;
--						if letter_index = line1'length then
--							fsm <= move2;
--						end if;
--					end if;
		end if;
	end process;
	
end Behavioral;

