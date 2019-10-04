library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity pencoder_tb is
end pencoder_tb;

architecture TB_ARCHITECTURE of pencoder_tb is
	-- Component declaration of the tested unit
	component pencoder
	port(
		input : in STD_LOGIC_VECTOR(7 downto 0);
		output : out STD_LOGIC_VECTOR(2 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal input : STD_LOGIC_VECTOR(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal output : STD_LOGIC_VECTOR(2 downto 0);

	-- Add your code here ...
	
begin

	-- Unit Under Test port map
	UUT : pencoder
		port map (
			input => input,
			output => output
		);

	-- Add your stimulus here ...
	
	STIMULUS: process
	begin				 
		wait for 50 ns;
		input <= "10000000" , "10000100" after 150 ns, "01000000" after 250 ns, "00100000" after 350 ns, "00010000" after 450 ns, "00001000" after 550 ns,  "00000100" after 650 ns,  "00000010" after 750 ns,  "00000001" after 850 ns;
		
		wait;
	end process STIMULUS;

	
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pencoder of pencoder_tb is
	for TB_ARCHITECTURE
		for UUT : pencoder
			use entity work.pencoder(pencoder);
		end for;
	end for;
end TESTBENCH_FOR_pencoder;

