-------------------------------------------------------------------------------
--
-- Title       : connection
-- Design      : dutyCycle
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : connection.vhd
-- Generated   : Fri May 25 13:42:45 2018
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
--{entity {connection} architecture {connection}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity connection is
	port(
	clk : in std_logic ;
	txin : in unsigned(7 downto 0);
	rxout : out unsigned(7 downto 0)
	);
end connection;

--}} End of automatically maintained section

architecture connection of connection is 


component transmitter is 
port(
clk : in std_logic;
	 txin : in unsigned(7 downto 0);
	 txout : out std_logic

);	
end component;

component reciever is
	
	port(
	clk : in std_logic;
	rxin : in std_logic;
	--rdout : out std_logic;
	rxout : out unsigned(7 downto 0)
	);
end component;
  signal dt : std_logic;
begin

	dc_transmitter: transmitter
	port map(
	clk => clk,
	txout => dt,
	txin => txin
	);
	
	dc_receiver : reciever 
	port map (
	clk => clk,
	rxin => dt,
	rxout => rxout
	
	);
	
end connection;
