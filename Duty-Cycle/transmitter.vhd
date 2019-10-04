-------------------------------------------------------------------------------
--
-- Title       : transmitter
-- Design      : dutyCycle
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : transmitter.vhd
-- Generated   : Wed May 16 10:31:28 2018
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
--{entity {transmitter} architecture {transmitter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
 use ieee.numeric_std.all;
entity transmitter is
	port(
	clk : in std_logic;
	 txin : in unsigned(7 downto 0);
	 txout : out std_logic
	     );
end transmitter;

--}} End of automatically maintained section

architecture transmitter of transmitter is
signal Duty : unsigned (7 downto 0) := x"00"; 
 --signal l : unsigned (3 downto 0) := x"0";
signal o : unsigned (7 downto 0) := x"00" ;
begin 
	-- enter your statements here -- 
	-- as it is apparent the amount that is going to enter the interface circuit is controlled to meet the standards of the input of the interface circuit. 
	
	
	duty <= '0' & txin(7 downto 1) + x"0A";
		
	 process(clk)
	 begin	
		 if (rising_edge(clk))then 
			 o <= o+1;
			 if (o >= x"63") then
				 o <= x"00";
			 end if;
		end if;	
end process;
	  txout <= '1' when ((o < duty)) else '0';
			
	
end transmitter;
