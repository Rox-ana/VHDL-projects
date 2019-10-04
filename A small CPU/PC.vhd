-------------------------------------------------------------------------------
--
-- Title       : PC
-- Design      : coDesignCPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : PC.vhd
-- Generated   : Wed Jun 13 23:55:49 2018
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
--{entity {PC} architecture {PC}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity PC is 
	port(
	pc_in	: in std_logic_vector(5 downto 0);
	pc_out : out std_logic_vector(5 downto 0);
	clk,clr,inc,ld : in std_logic 
	);
end PC;

--}} End of automatically maintained section

architecture PC of PC is
signal reg : unsigned(5 downto 0) := (others => '0');
begin 
 pc_out <= std_logic_vector(reg);
	process(clk,clr)
	
	begin
		if ( clr = '1')then
			reg <= (others => '0');
		elsif(clk'event and clk ='1') then
			if(ld = '1') then
				reg <= unsigned(pc_in);
			elsif (inc = '1') then
				reg <= reg + 1;
				end if;
			end if;
	end process;
	
	 

end PC;
