-------------------------------------------------------------------------------
--
-- Title       : PEncoder
-- Design      : PEncoder
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : PEncoder.vhd
-- Generated   : Sat Apr  7 23:35:23 2018
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
--{entity {PEncoder} architecture {PEncoder}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PEncoder is
	port(
	input : in std_logic_vector(7 downto 0);
	output : out std_logic_vector(2 downto 0)
	);
end PEncoder;

--}} End of automatically maintained section

architecture PEncoder of PEncoder is
begin

	 -- enter your statements here --
 
	 output <= "111" when (input(7) = '1')
else "110" when (input(6) = '1') 
else  "101" when (input(5) = '1')
else  "100" when (input(4) = '1') 
else  "011" when (input(3) = '1') 
else "010" when (input(2) = '1') 
else  "001" when (input(1) = '1')
else  "000" when (input(0) = '1') 
else "ZZZ" ; 
	
  
end PEncoder;
