-------------------------------------------------------------------------------
--
-- Title       : vga
-- Design      : OV7670
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : vga.vhd
-- Generated   : Wed Mar  6 23:04:58 2019
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {vga} architecture {vga}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity vga is
	port(
	nclk, rst: in std_logic;
	VS, HS : out std_logic;
	red,blue,GREEN : out std_logic_vector(3 downto 0);-- 
	cin : in std_logic_vector(11 downto 0); -- the color that we gets in 
	--activeArea : out std_logic;
	rez0 : in std_logic;
	sy : out unsigned(9 downto 0)
	);
end vga;

--}} End of automatically maintained section

architecture vga of vga is
 
constant total_width_main : unsigned(9 downto 0) := to_unsigned(800,10);
constant total_height_main : unsigned(9 downto 0) := to_unsigned(525,10);


--constant total_width_ : unsigned(8 downto 0) := to_unsigned(480,9);
--constant total_height : unsigned(8 downto 0) := to_unsigned(285,9);

constant visible_width_0 : unsigned(9 downto 0) := to_unsigned(320,10);
constant visible_height_0 : unsigned(9 downto 0) := to_unsigned(240,10);
constant visible_width_1 : unsigned(9 downto 0) := to_unsigned(160,10);
constant visible_height_1 : unsigned(9 downto 0) := to_unsigned(120,10);

constant right_border : unsigned(9 downto 0) := to_unsigned(16,10);
--constant left_border : unsigned(8 downto 0) := to_unsigned(48,9);
constant width_retrace : unsigned(9 downto 0) := to_unsigned(96,10);

--constant top_border : unsigned(8 downto 0) := to_unsigned(33,9);
constant bottom_border : unsigned(9 downto 0) := to_unsigned(10,10);
constant height_retrace : unsigned(9 downto 0) := to_unsigned(2,10);
-- def sig
--signal nclk : std_logic := '0';	
signal xcpos, ycpos : unsigned(9 downto 0) := (others => '0'); 
signal blank, hblank, wblank : std_logic := '0';

begin

	-- generate_new_clock:process( clk )
	
---begin  
	--if ( rising_edge (clk) ) then
		--nclk <= not nclk;
	--end if;	  
--end process generate_new_clock ;	 


--*************************************	

position: process( nclk,rst )
	
begin  
	if ( rising_Edge(nclk) ) then
		if (rst = '0') then
			xcpos <= (others => '0'); 
			ycpos <= (others => '0');
		else   
			if xcpos < total_width_main-1 then
				xcpos <= xcpos + 1;
			else
				if (ycpos < total_height_main-1)then 
					ycpos <= ycpos + 1;
				else
					ycpos <= (others => '0');
				end if;
				xcpos <= (others => '0');
			end if;
		end if;
	end if;
	
end process position; 
--**************************************
--**************************************
HS <= '0' when  xcpos < width_retrace else '1';
VS <= '0' when ycpos < Height_retrace else '1';		
--**************************************
blank <= '1' when hblank = '1' or wblank = '1' else '0';
wblank <= '0' when ((xcpos >= right_border + width_retrace) and (xcpos < visible_width_0 + right_border + width_retrace) and rez0 = '0') or ((xcpos >= right_border + width_retrace) and (xcpos < visible_width_1 + right_border + width_retrace) and rez0 = '1') else '1';
hblank <= '0' when ((ycpos >= bottom_border + height_retrace) and (ycpos < visible_height_0 + bottom_border + height_retrace ) and rez0 = '0') or ((ycpos >= bottom_border + height_retrace) and (ycpos < visible_height_1 + bottom_border + height_retrace ) and rez0 = '1') else '1';
--**************************************
--sx <= xcpos - right_border - width_retrace when blank = '0' else (others => '0');
sy <= ycpos - bottom_border - height_retrace when blank = '0' else (others => '0');
--************************************** 
 	 RED	<= CIN(11 downto 8) when Blank = '0' else "0000";	  
	  
     GREEN	<= CIN(7 downto 4) when Blank = '0' else "0000";				
	  
     BLUE	<= CIN(3 downto 0) when Blank = '0' else "0000";
end vga;
