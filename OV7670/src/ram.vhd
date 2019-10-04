-------------------------------------------------------------------------------
--
-- Title       : ram
-- Design      : OV7670
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : ram.vhd
-- Generated   : Wed Mar  6 23:08:29 2019
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
--{entity {ram} architecture {ram}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.ALL;
entity ram is
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
	wre,ren : in std_logic
	);
end ram;

--}} End of automatically maintained section

architecture ram of ram is
type memory is array((2**addr_width)-1 downto 0) of std_logic_vector(data_width-1 downto 0); 
signal ram : memory := (others => (others => '0'));
begin
	process( clka )
		
	begin  
		if rising_edge(clka) then
			if wre = '1' then
				ram(to_integer(unsigned(addra))) <= din;
			end if;
		end if;
	end process;	  
	
process( clkb )
		
	begin  
		if rising_edge(clkb) then
			if ren = '1' then
				dout <= ram(to_integer(unsigned(addrb)));
			end if;
			
		end if;
	end process;
end ram;
