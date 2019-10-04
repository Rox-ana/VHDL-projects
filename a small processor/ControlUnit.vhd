-------------------------------------------------------------------------------
--
-- Title       : ControlUnit
-- Design      : coDesignCPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : ControlUnit.vhd
-- Generated   : Sat Jun 16 19:46:36 2018
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
--{entity {ControlUnit} architecture {ControlUnit}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity ControlUnit is
	port(  
	
	-- memory controlling signals--
	rst : in std_logic;
	mem_rd : out std_logic;
	
	--pc contorolling signals--	
	pc : in std_logic_vector(5 downto 0);
	load_pc : out std_logic;
	inc_pc : out std_logic;
	clr_pc : out std_logic;
	--ir contorling signals-- 
	ir_load : out std_logic;
	
	-- op code and registers ivolved--
	ir_input : in std_logic_vector(5 downto 0);
	op_code : out std_logic_vector(1 downto 0);
	rx : out std_logic_vector(1 downto 0);
	ry : out std_logic_vector(1 downto 0);
	--register controlling signals--
	reg_load : out std_logic_vector(3 downto 0);
	reg_zero : in std_logic_vector(3 downto 0);
	--alu controlling signal--
	alu_co : out std_logic;

	--sequence stuff--
	sc : in std_logic;
	finish: out std_logic
	);
end ControlUnit;

--}} End of automatically maintained section

architecture ControlUnit of ControlUnit is 
signal sig_op_code,sig_rx : std_logic_vector(1 downto 0);

signal sfinish : std_logic;
signal rz : std_logic;
begin
--register transactions--
	sig_rx <= ir_input(3 downto 2);
	rx <= sig_rx;
	ry <= ir_input(1 downto 0);
	sig_op_code <= ir_input(5 downto 4);
	op_code <= sig_op_code;
-- this signal is '1' when the registers are not empty(aka. do not equal "000000")		
	rz <= '1' when ((reg_zero(0) = '0') and (reg_zero(1) = '0') and  (reg_zero(2) = '0') and (reg_zero(3) = '0')) else '0';
	
--pc signals--		
	inc_pc <= '1' when ((sc = '0') or ((sc = '1') and (sig_op_code = "00")) or ((sc = '1') and (sig_op_code = "11") and (rz = '0') ))else '0';
	clr_pc <= '1' when (rst = '1') else '0';	
	load_pc <= '1' when (sc = '1' and sig_op_code = "11" and rz = '1') else '0';

-- alu activatition--		
	alu_co <= '1' when ((sc = '1' and sig_op_code= "01")or (sc = '1' and sig_op_code = "10")) else '0';
-- registers signals--			 
	reg_load(0) <= '1' when (sc = '1' and sig_op_code /= "11" and sig_rx = "00") else  '0';
	reg_load(1) <= '1' when (sc = '1' and sig_op_code /= "11" and sig_rx = "01") else  '0';
	reg_load(2) <= '1' when (sc = '1' and sig_op_code /= "11" and sig_rx = "10") else  '0';
	reg_load(3) <= '1' when (sc = '1' and sig_op_code /= "11" and sig_rx = "11") else  '0';
--instruction register-- 

ir_load <= '1' when (sc = '0') else '0'; 
	
--memory read--
	mem_rd <= '1' when ((sc = '0') or (sc = '1' and sig_op_code = "00") or (sc = '1' and sig_op_code = "11" and rz = '1')) else '0'; 

	
end ControlUnit;
