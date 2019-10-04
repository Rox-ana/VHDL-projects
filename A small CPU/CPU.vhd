-------------------------------------------------------------------------------
--
-- Title       : CPU
-- Design      : coDesignCPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : CPU.vhd
-- Generated   : Wed Jun 13 11:08:16 2018
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
--{entity {CPU} architecture {CPU}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.muxreg.all;
entity CPU is
	port(
			clk,rst : in std_logic
		);
end CPU;

--}} End of automatically maintained section

architecture CPU of CPU is	
signal cpu_bus : std_logic_vector(5 downto 0);
signal r0,r1,r2,r3 : std_logic_vector(5 downto 0);
signal zc0,zc1,zc2,zc3 ,ssc: std_logic;
signal ld0,ld1,ld2,ld3,ld_pc,ld_ir,mem_read,pc_clr : std_logic;
signal pc_out_mem_in,ir_out,alu_in1,alu_in2 : std_logic_vector(5 downto 0); 
signal pc_inc : std_logic;
signal rxsel,rysel,opcode : std_logic_vector(1 downto 0); 
signal alu_con : std_logic;
--COMPONENTS--
component reg is 
	port(
	rin : in std_logic_vector(5 downto 0);
	rout : out std_logic_vector(5 downto 0);
	zero_check : out std_logic; 
	clk,ld : in std_logic
	);
end component;

component alu is 
	port(
	op1,op2 : in std_logic_vector(5 downto 0);
	res : out std_logic_vector(5 downto 0);
	con : in std_logic;
	asel : in std_logic_vector(1 downto 0)
	);	
end component;

component muxforreg is 
	port(
	mux : in mreg;
	msel : in std_logic_vector(1 downto 0);
	mout : out std_logic_vector(5 downto 0)
	);
end component;

component pc is 
	port(
	pc_in	: in std_logic_vector(5 downto 0);
	pc_out : out std_logic_vector(5 downto 0);
	clk,clr,inc,ld : in std_logic 
	);
end component;

component controlunit is 
port(
	  rst : in std_logic;
	-- memory controlling signals--
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
	alu_co : out std_logic;
	
	--sequence stuff--
	sc : in std_logic
	
	);	
end component;

component rom is
	port(
	mem_out : out std_logic_vector(5 downto 0);
	RD : in std_logic; 
	
	mem_in : in std_logic_vector(5 downto 0)
	);
end component;

component seq_counter is
	port(
	clk,rst : in std_logic;
	sq : out std_logic
	);
end component;

component ir is 
port(
	irin : in std_logic_vector(5 downto 0);
	irout : out std_logic_vector(5 downto 0); 
	clk,ld : in std_logic
	);	
end component;

begin
--BANK REGISTERS--
reg0 : reg
port map
(
  rin => cpu_bus,
	rout => r0,
	zero_check => zc0, 
	clk => clk,
	ld => ld0
);

reg1 : reg
port map
(
  rin => cpu_bus,
	rout => r1,
	zero_check => zc1, 
	clk => clk,
	ld => ld1
);

reg2 : reg
port map
(
  rin => cpu_bus,
	rout => r2,
	zero_check => zc2,
	clk => clk,
	ld => ld2
); 

reg3 : reg
port map
(
  rin => cpu_bus,
	rout => r3,
	zero_check => zc3, 
	clk => clk,
	ld => ld3
);
--program counter--
program_counter : pc
port map
(
  pc_in	=> cpu_bus,
	pc_out => pc_out_mem_in,
	clk => clk,
	clr => pc_clr,
	inc => pc_inc,
	ld => ld_pc
);
--instruction register--
instruction_register : ir
port map 
(
irin => cpu_bus,
	irout => ir_out,
	clk => clk ,
	ld => ld_ir
);
--multiplexers--
mux1 : muxforreg
port map
(
mux(0) => r0,
mux(1) => r1,
mux(2) => r2,
mux(3) => r3,
msel =>	 rxsel,
	mout =>	alu_in1
);

mux2 : muxforreg
port map
(
mux(0) => r0,
mux(1) => r1,
mux(2) => r2,
mux(3) => r3,
msel =>	 rysel,
	mout =>	alu_in2
);
--alu--
alu_part : alu
port map
(
op1 => alu_in1,
op2 => alu_in2,
res => cpu_bus,
con => alu_con,
	asel => opcode
);
--rom--
ROMemory : rom
port map(
mem_out => cpu_bus, 
RD => mem_read,

	mem_in => pc_out_mem_in
);	
--sequence counter--
scounter : seq_counter
port map(
clk => clk,
rst => rst,
	sq => ssc
	);
--control unit--
control_unit :  controlunit
  port map(
  	 
  	 rst => rst,
	-- memory controlling signals--
	mem_rd => mem_read,
	--pc contorolling signals--
	load_pc => ld_pc,
	inc_pc => pc_inc,
	clr_pc => pc_clr,
	pc => pc_out_mem_in,
	--ir contorling signals-- 
	ir_load => ld_ir,
	-- op code and registers ivolved--
	ir_input => ir_out,
	op_code => opcode,
	rx => rxsel,
	ry => rysel,
	alu_co => alu_con ,
	
	--register controlling signals--
	reg_load(0) => ld0,
	reg_load(1) => ld1,
	reg_load(2) => ld2,
	reg_load(3) => ld3,
	
	reg_zero(0) => zc0,
	reg_zero(1) => zc1,
	reg_zero(2) => zc2,
	reg_zero(3) => zc3,
	--sequence stuff--
	sc => ssc
	
	);
end CPU;
