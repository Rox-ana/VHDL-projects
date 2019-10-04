-------------------------------------------------------------------------------
--
-- Title       : clocking
-- Design      : OV7670
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : clocking.vhd
-- Generated   : Wed Mar  6 23:05:43 2019
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
--{entity {clocking} architecture {clocking}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clocking is 
	port (
	clk : in std_logic;
	clk_25 : out std_logic
		 );	
end clocking;

--}} End of automatically maintained section

architecture clocking of clocking is
signal clk_25reg : std_logic := '0';
begin
	clk_25 <= clk_25reg;
	process( clk )
		
	begin  
		if rising_edge(clk) then
			clk_25reg <= not clk_25reg;
		end if;
	end process;	 

end clocking;
