-------------------------------------------------------------------------------
--
-- Title       : OV7670_controller
-- Design      : OV7670
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : OV7670_controller.vhd
-- Generated   : Wed Mar  6 22:57:18 2019
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
--{entity {OV7670_controller} architecture {OV7670_controller}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity OV7670_controller is	
	 Port ( clk   : in    STD_LOGIC;
			  resend :in    STD_LOGIC;
			  config_finished : out std_logic;
           sioc  : out   STD_LOGIC;
           siod  : inout STD_LOGIC;
           reset : out   STD_LOGIC;
           pwdn  : out   STD_LOGIC;
			  xclk  : out   STD_LOGIC
);
end OV7670_controller;

--}} End of automatically maintained section

architecture OV7670_controller of OV7670_controller is
COMPONENT ov7670_registers
	PORT(
		clk      : IN std_logic;
		advance  : IN std_logic;          
		resend   : in STD_LOGIC;
		command  : OUT std_logic_vector(15 downto 0);
		finished : OUT std_logic
		);
	END COMPONENT;

	COMPONENT i2c_sender
	PORT(
		clk   : IN std_logic;
		send  : IN std_logic;
		taken : out std_logic;
		id    : IN std_logic_vector(7 downto 0);
		reg   : IN std_logic_vector(7 downto 0);
		value : IN std_logic_vector(7 downto 0);    
		siod  : INOUT std_logic;      
		sioc  : OUT std_logic
		);
	END COMPONENT;

	signal sys_clk  : std_logic := '0';	
	signal command  : std_logic_vector(15 downto 0);
	signal finished : std_logic := '0';
	signal taken    : std_logic := '0';
	signal send     : std_logic;

	constant camera_address : std_logic_vector(7 downto 0) := x"42"; -- 42"; -- Device write ID - see top of page 11 of data sheet
begin
   config_finished <= finished;
	
	send <= not finished;
	Inst_i2c_sender: i2c_sender PORT MAP(
		clk   => clk,
		taken => taken,
		siod  => siod,
		sioc  => sioc,
		send  => send,
		id    => camera_address,
		reg   => command(15 downto 8),
		value => command(7 downto 0)
	);

	reset <= '1'; 						-- Normal mode
	pwdn  <= '0'; 						-- Power device up
	xclk  <= sys_clk;
	
	Inst_ov7670_registers: ov7670_registers PORT MAP(
		clk      => clk,
		advance  => taken,
		command  => command,
		finished => finished,
		resend   => resend
	);

	process(clk)
	begin
		if rising_edge(clk) then
			sys_clk <= not sys_clk;
		end if;
	end process;
end OV7670_controller;
