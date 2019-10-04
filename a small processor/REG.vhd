-------------------------------------------------------------------------------
--
-- Title       : REG
-- Design      : coDesignCPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : REG.vhd
-- Generated   : Wed Jun 13 10:27:29 2018
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
--{entity {REG} architecture {REG}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity REG is
	port(
	rin : in std_logic_vector(5 downto 0);
	rout : out std_logic_vector(5 downto 0);
	zero_check : out std_logic; 
	clk,ld : in std_logic
	);
end REG;

--}} End of automatically maintained section

architecture REG of REG is 
signal creg	: std_logic_vector(5 downto 0);
begin
	process(clk)
	begin
	if(rising_edge(clk))then
	if (ld = '1') then
		creg <= rin;
	end if;	
	end if;
	end process;
	rout <= creg;
	zero_check <= '1' when (creg = "000000") else '0'; 
end REG;
