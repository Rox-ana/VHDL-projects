-------------------------------------------------------------------------------
--
-- Title       : ir
-- Design      : coDesignCPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : ir.vhd
-- Generated   : Sat Jun 16 23:29:58 2018
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
--{entity {ir} architecture {ir}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity ir is
	port(
	irin : in std_logic_vector(5 downto 0);
	irout : out std_logic_vector(5 downto 0); 
	clk,ld : in std_logic
	);
end ir;

--}} End of automatically maintained section

architecture ir of ir is 
signal irreg : std_logic_vector(5 downto 0);
begin

	process(clk)
	begin
	if(rising_edge(clk))then
	if (ld = '1') then
		irreg <= irin;
	end if;					  
	end if;
	end process;
	irout <= irreg;
	

end ir;
