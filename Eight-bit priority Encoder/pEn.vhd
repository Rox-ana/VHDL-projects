-------------------------------------------------------------------------------
--
-- Title       : pen
-- Design      : priEncoder
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : pEn.vhd
-- Generated   : Tue May 15 08:37:16 2018
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
--{entity {pen} architecture {beh}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity pen is
	generic(
	n : positive:=3
	);				
	port(
	inp : in std_logic_vector(2**n -1 downto 0);
	outp : out std_logic_vector(n-1 downto 0)
	);
end pen;

--}} End of automatically maintained section

architecture beh of pen is
begin

	 -- enter your statements here --
	 
	 process(inp)
	 begin
		 for i in 2**n -1 downto 0 loop
			 if(inp(i) = '1') then
				 outp <= std_logic_vector(to_unsigned(i,n));
				 exit;
			 else 
				outp <= (others =>'0');
				 	end if;
			 end loop;
		 end process;
end beh;
