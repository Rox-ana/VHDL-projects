-------------------------------------------------------------------------------
--
-- Title       : addr_gen
-- Design      : OV7670
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : addr_gen.vhd
-- Generated   : Thu Mar  7 09:34:18 2019
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
--{entity {addr_gen} architecture {addr_gen}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.ALL;

entity addr_gen is 
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
	vsync : in std_logic;
	enable : out std_logic;
	sy : in unsigned(9 downto 0)
	
	);
end addr_gen;

--}} End of automatically maintained section

architecture addr_gen of addr_gen is
signal temp : unsigned(addr_width-1 downto 0) := (others => '0');

begin
   addr <= std_logic_vector(temp);
	process( clk )
		
	begin  
	if ( rising_edge(clk) ) then
		if ( rst = '0' ) then
			temp <= (others => '0');
			enable <= '0';
		else
			IF  (to_unsigned(0,10) < sy and sy <= to_unsigned(visible_height_1,10) and rez0 = '1') then
					enable <= '1';
					if temp < max_value_1 then
						temp <= temp + 1;
					end if;
				
			elsif (to_unsigned(0,10) < sy and sy <= to_unsigned(visible_height_0,10) and rez0 = '0') then 
				 enable <= '1';
					if temp < max_value_0 then
						temp <= temp + 1;
					end if;
			else 
				enable <= '0';
			END IF;
				if vsync = '0' then 
               		temp <= (others => '0');
					enable <= '0';
           		end if;	
		
		end if;		
	end if;		 
	end process;	 

end addr_gen;
