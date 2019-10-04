-------------------------------------------------------------------------------
--
-- Title       : reciever
-- Design      : dutyCycle
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : reciever.vhd
-- Generated   : Wed May 16 23:40:28 2018
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
--{entity {reciever} architecture {reciever}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity reciever is
	port( 
	clk : in std_logic;
	rxin : in std_logic;
	--rdout : out std_logic;
	rxout : out unsigned(7 downto 0)
	
	);
end reciever;

--}} End of automatically maintained section

architecture reciever of reciever is  
type state is 
(
idle,
cstate,
done
);
	
signal c : unsigned (7 downto 0) := x"00";
signal o : unsigned (7 downto 0) := x"00";

signal s : state;

begin

	-- enter your statem
	process(clk)
	begin	   
		if(rising_edge(clk)) then
		case s is
			when idle =>
			c <= x"00";
			--rdout <= '1';
			if (rxin = '1') then 
				c <= c+1;
				s <= cstate;
			else
				s <= idle;
			end if;
			when cstate =>
			if (rxin = '1') then
				c <= c+1;
				if (c >= x"63") then
					s <= done;
				else
					s <= cstate;
				end if;
				
			else
					s <= done;
			end if;
			when done =>  
			o <= c + c -20;	 
			--rdout <= '0';
			s <= idle;
			when others =>
			s <= idle;
			end case;
		end if;
		
	end process;
		   rxout <= o;
end reciever;


