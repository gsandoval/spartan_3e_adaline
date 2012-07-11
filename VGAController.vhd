----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Guillermo Alberto Sandoval Sanchez
-- 
-- Create Date:    10:12:28 05/26/2012 
-- Design Name: 
-- Module Name:    VGADriver - Behavioral 
-- Project Name: 
-- Target Devices: Spartan 3E Starter Board
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

-- Información del timing de la señal VGA con distintas resoluciones y relojes
-- http://www.epanorama.net/documents/pc/vga_timing.html

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGAController is
port(
	reset : in std_logic;
	clock : in std_logic;
	hsync : out std_logic;
	vsync : out std_logic;
	hpos : out integer;
	vpos : out integer;
	blank : out std_logic
);
end VGAController;

architecture Behavioral of VGAController is

	constant HMAX : integer := 1040;
	constant HDISP : integer := 800;
	constant HFP : integer := 856;
	constant HS : integer := 976;
	constant VMAX : integer := 666;
	constant VDISP : integer := 600;
	constant VFP : integer := 637;
	constant VS : integer := 643;
	constant SYNC_SIGNAL : std_logic := '0';

	signal hcounter : integer range 0 to HMAX := 0;
	signal vcounter : integer range 0 to VMAX := 0;

begin

   hpos <= hcounter;
   vpos <= vcounter;
	
	blank_signal : process(clock, hcounter, vcounter)
	begin
		if (rising_edge(clock)) then
			if (hcounter < HDISP and vcounter < VDISP) then
				blank <= '0';
			else
				blank <= '1';
			end if;
		end if;
	end process;

   horizontal_count : process(clock, reset)
   begin
      if (rising_edge(clock)) then
         if (reset = '1') then
            hcounter <= 0;
         else
				if (hcounter = HMAX) then
					hcounter <= 0;
				else
					hcounter <= hcounter + 1;
				end if;
         end if;
      end if;
   end process;

   vertical_count : process(clock, reset, hcounter)
   begin
      if (rising_edge(clock)) then
         if (reset = '1') then
            vcounter <= 0;
         elsif (hcounter = HMAX) then
            if(vcounter = VMAX) then
               vcounter <= 0;
            else
               vcounter <= vcounter + 1;
            end if;
         end if;
      end if;
   end process;

   horizontal_sync : process(clock, hcounter)
   begin
      if (rising_edge(clock)) then
         if (hcounter >= HFP and hcounter < HS) then
            hsync <= SYNC_SIGNAL;
         else
            hsync <= not SYNC_SIGNAL;
         end if;
      end if;
   end process;

   vertical_sync : process(clock, vcounter)
   begin
      if (rising_edge(clock)) then
         if (vcounter >= VFP and vcounter < VS) then
            vsync <= SYNC_SIGNAL;
         else
            vsync <= not SYNC_SIGNAL;
         end if;
      end if;
   end process;

end Behavioral;