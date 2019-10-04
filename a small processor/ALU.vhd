-------------------------------------------------------------------------------
--
-- Title       : ALU
-- Design      : coDesignCPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : ALU.vhd
-- Generated   : Wed Jun 13 10:36:45 2018
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
--{entity {ALU} architecture {ALU}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity ALU is  
	port(
	op1,op2 : in std_logic_vector(5 downto 0);
	res : out std_logic_vector(5 downto 0);
	con : in std_logic;
	asel : in std_logic_vector(1 downto 0)
	);
end ALU;

--}} End of automatically maintained section

architecture ALU of ALU is 
signal alu_res,uop1,uop2 : unsigned(5 downto 0);
begin
	uop1 <= unsigned(op1);
	uop2 <= unsigned(op2);
	alu_res <= uop1 + uop2 when asel = "01" else
			uop1 - uop2 when asel = "10" else
		  	(others => 'Z');
	
		res <= std_logic_vector(alu_res) when con = '1' else (others => 'Z');
	
end ALU;
