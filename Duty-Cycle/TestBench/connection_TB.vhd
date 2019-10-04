library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity connection_tb is
end connection_tb;

architecture TB_ARCHITECTURE of connection_tb is
	-- Component declaration of the tested unit
	component connection
	port(
		clk : in STD_LOGIC;
		txin : in UNSIGNED(7 downto 0);
		rxout : out UNSIGNED(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal txin : UNSIGNED(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal rxout : UNSIGNED(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : connection
		port map (
			clk => clk,
			txin => txin,
			rxout => rxout
		);

	-- Add your stimulus here ...
	process
	begin
		clk <= '0';
		wait for 1 ns;
		clk <= '1';
		wait for 1 ns;
	end process;
	
	process
	begin
		txin<= x"00";
		wait for 200 ns;
		txin <= x"02";
		wait for 200 ns;
		txin <= x"A0";
		wait for 200 ns;
		txin <= x"04";
		wait for 200 ns;
		wait; 
		
	end process;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_connection of connection_tb is
	for TB_ARCHITECTURE
		for UUT : connection
			use entity work.connection(connection);
		end for;
	end for;
end TESTBENCH_FOR_connection;

