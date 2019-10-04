-------------------------------------------------------------------------------
--
-- Title       : OV7670_top
-- Design      : OV7670
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : OV7670_top.vhd
-- Generated   : Wed Mar  6 23:05:15 2019
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
--{entity {OV7670_top} architecture {OV7670_top}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all; 

entity OV7670_top is 
	generic (
	addr_width : positive := 17	;
	data_width : positive := 12
		);	
	  Port ( 
		clk_50        : in    STD_LOGIC;
		OV7670_SIOC  : out   STD_LOGIC;
		OV7670_SIOD  : inout STD_LOGIC;
		OV7670_RESET : out   STD_LOGIC;
		OV7670_PWDN  : out   STD_LOGIC;
		OV7670_VSYNC : in    STD_LOGIC;
		OV7670_HREF  : in    STD_LOGIC;
		OV7670_PCLK  : in    STD_LOGIC;
		OV7670_XCLK  : out   STD_LOGIC;
		OV7670_D     : in    STD_LOGIC_VECTOR(7 downto 0);

		LED         : out    STD_LOGIC;

		vga_red      : out   STD_LOGIC_VECTOR(3 downto 0);
		vga_green    : out   STD_LOGIC_VECTOR(3 downto 0);
		vga_blue     : out   STD_LOGIC_VECTOR(3 downto 0);
		vga_hsync    : out   STD_LOGIC;
		vga_vsync    : out   STD_LOGIC;
		rst 		    : in    STD_LOGIC;
		sw0 : in std_logic;
		sw1 : in std_logic;
		btn0 : in std_logic;
		btn1 : in std_logic
	 );
end OV7670_top;

--}} End of automatically maintained section

architecture OV7670_top of OV7670_top is 
--*******************components*******************
component OV7670_capture is
	generic(
	addr_width : positive := 17;
	data_width : positive := 12;	
	max_value_1 : positive :=  19200;
	max_value_0 : positive :=  76800
	);
	Port (
	capture : in std_logic;
	one_frame : in std_logic;
	rez0 : in std_logic;
	pclk  : in   STD_LOGIC;
           vsync : in   STD_LOGIC;
           href  : in   STD_LOGIC;
           d     : in   STD_LOGIC_VECTOR (7 downto 0);
           addr  : out  STD_LOGIC_VECTOR (addr_width-1 downto 0);
           dout  : out  STD_LOGIC_VECTOR (data_width-1 downto 0);
           we    : out  STD_LOGIC);
	
end component;

component Ov7670_controller is
	Port ( clk   : in    STD_LOGIC;
			  resend :in    STD_LOGIC;
			  config_finished : out std_logic;
           sioc  : out   STD_LOGIC;
           siod  : inout STD_LOGIC;
           reset : out   STD_LOGIC;
           pwdn  : out   STD_LOGIC;
			  xclk  : out   STD_LOGIC
);
end component;

component vga is
	port(
	nclk, rst: in std_logic;
	VS, HS : out std_logic;
	red,blue,GREEN : out std_logic_vector(3 downto 0);-- these two are 5 bits
	rez0 : in std_logic;
	cin : in std_logic_vector(11 downto 0); -- the color that we gets in 
	--activeArea : out std_logic;
	sy : out unsigned(9 downto 0)
	);
end component;

component clocking is
	port (
	clk : in std_logic;
	clk_25 : out std_logic
		 );	
end component;

component ram is 
generic(
	data_width : positive := 12;
	addr_width : positive := 17
	
	);
	port(
	clka : in std_logic;
	clkb : in std_logic;
	din : in std_logic_vector(data_width-1 downto 0);
	dout : out std_logic_vector(data_width-1 downto 0);
	addra : in std_logic_vector(addr_width-1 downto 0);
	addrb : in std_logic_vector(addr_width-1 downto 0);
	ren : in std_logic;
	wre : in std_logic
	);	
end component;

component addr_gen is 
generic (
	addr_width : positive := 17	   ;
	visible_height_0 : positive := 240;
	visible_height_1 : positive := 120;
	max_value_0 : positive := 76800;
	max_value_1 : positive :=  19200
	);
	port(
	rez0 : in std_logic;
	addr : out std_logic_vector(addr_width-1 downto 0);
	clk : in std_logic;
	rst : in std_logic;
	enable : out std_logic;
	vsync : in std_logic; 
	sy : in unsigned(9 downto 0)
	
	);	
end component;
--******************************************signals
signal rsd : std_logic := '0';
signal sy : unsigned(9 downto 0) := (others => '0');
signal clk : std_logic:= '0';
signal wr_addr : std_logic_vector(addr_width-1 downto 0) := (others => '0');
signal rd_addr : std_logic_vector(addr_width-1 downto 0) := (others => '0');
signal data_in,data_out : std_logic_vector(data_width-1 downto 0) := (others => '0');
signal wren,ren,v : std_logic := '0';
begin
vga_vsync <= v;	
OV7670_capt: OV7670_capture port map(
capture => sw1,
	one_frame => btn1,
rez0 => sw0,
pclk => OV7670_PCLK,
           vsync => OV7670_VSYNC,
           href  => OV7670_HREF,
           d     => OV7670_D,
           addr  => wr_addr,
           dout  => data_in,
           we    => wren
);
rsd <= rst and btn0;
Ov7670_cont: OV7670_controller port map(
	clk   => clk_50,
			  resend => rsd,
			  config_finished => led,
           sioc  => OV7670_SIOC,
           siod  => OV7670_SIOD,
           reset => OV7670_RESET,
           pwdn  => OV7670_PWDN	  ,
			  xclk  => OV7670_XCLK
);
vga_controller: vga port map(
rez0 => sw0,
nclk => clk, 
rst=> rst,
VS =>v , 
HS => vga_hsync,
red => 	vga_red,
blue => vga_blue,
GREEN => vga_green,	
	cin => data_out,
	sy => sy
);	
clock: clocking port map(
clk => clk_50,
clk_25 => clk
);	
ram0 : ram port map 
(
clka => OV7670_PCLK,
	clkb => clk,
	din => data_in,
	dout => data_out,
	addra => wr_addr,
	addrb => rd_addr,
	ren => ren,
	wre => wren
);
address_generator: addr_gen port map
(
addr => rd_addr,
rez0 => sw0,
	clk => clk,
	rst => rst,
	sy => sy ,
	enable => ren,
	vsync => v

);
end OV7670_top;
