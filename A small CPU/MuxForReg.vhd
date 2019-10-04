-------------------------------------------------------------------------------
--
-- Title       : MuxForReg
-- Design      : coDesignCPU
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : MuxForReg.vhd
-- Generated   : Wed Jun 13 10:45:25 2018
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
--{entity {MuxForReg} architecture {MuxForReg}}
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
package muxreg is
	type mreg is array(3 downto 0) of std_logic_vector(5 downto 0);
end package muxreg;

	
	
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use work.muxreg.all;
entity MuxForReg is	 
	port(
	mux : in mreg;
	msel : in std_logic_vector(1 downto 0);
	mout : out std_logic_vector(5 downto 0)
	);
end MuxForReg;

--}} End of automatically maintained section

architecture MuxForReg of MuxForReg is
begin

	process(msel,mux)
	begin
	case msel is
		when "00" =>
		mout <= mux(0);--- r0
		when "01" =>
		mout <= mux(1);--- r1
		when "10" =>
		mout <= mux(2);	--- r2
		when "11" =>
		mout <= mux(3);	--- r3
		when others =>
		mout <= (others => 'Z');
		end case;
	end process; 
	

end MuxForReg;
