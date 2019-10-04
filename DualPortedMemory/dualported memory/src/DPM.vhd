-------------------------------------------------------------------------------
--
-- Title       : DPM
-- Design      : dualported memory
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : DPM.vhd
-- Generated   : Thu May 24 11:35:39 2018
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
--{entity {DPM} architecture {DPM}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity DPM is  
	generic (
	dw,aw: positive := 8
	);
	
	port(
	clk,cs1,we1,cs2,we2 : in std_logic;
	ad1,ad2 : in std_logic_vector(aw-1 downto 0);
	d1,d2 : inout std_logic_vector(dw-1 downto 0)
	);
end DPM;

--}} End of automatically maintained section

architecture DPM of DPM is 
type dupm is array (2**aw -1 downto 0) of std_logic_vector(dw-1 downto 0);
shared variable mem : dupm ;
signal t1, t2 : std_logic_vector(dw-1 downto 0);
begin
   	
d1 <= t1 when (cs1 = '1' and we1 = '0') else (others => 'Z');
	d2 <= t2 when (cs2 = '1' and we2 = '0') else (others => 'Z');
			
	process(clk)
	begin	
		if (clk'event and clk = '1') then
			if (cs1 = '1') then
				if (we1 = '1') then
					   mem(to_integer(unsigned(ad1))) := d1;
				end if;
			end if;	   
			t1 <= mem(to_integer(unsigned(ad1)));
		end if;
	end process;
	
	
	process(clk)
	begin
	if (clk'event and clk = '1') then
			if (cs2 = '1') then
				if (we2 = '1') then
					   mem(to_integer(unsigned(ad2))) := d2;
				end if;
			end if;
			t2 <= mem(to_integer(unsigned(ad2)));
	end if;	
	end process;
	
	
	

end DPM;
