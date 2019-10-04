-------------------------------------------------------------------------------
--
-- Title       : seq_counter
-- Design      : coDesignCPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : seq_counter.vhd
-- Generated   : Sat Jun 16 20:52:48 2018
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
--{entity {seq_counter} architecture {seq_counter}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity seq_counter is 
	port(
	clk,rst : in std_logic;
	sq : out std_logic
	);
end seq_counter;

--}} End of automatically maintained section

architecture seq_counter of seq_counter is 
type s is (s0,s1);
signal state : s;
signal scount : std_logic;
begin

	process(clk,rst)
	
	begin
		if (rst = '1') then
			state <= s0; 
		
		elsif (rising_edge(clk)) then
			case state is
				when s0 => 
		
				state <= s1;
				when s1 => 
		
				state <= s0;  
				when others =>
				state <= s0;
			end case;
			end if;
		end process;
		
		
		  sq <= '1' when state = s1 else '0';
end seq_counter;
