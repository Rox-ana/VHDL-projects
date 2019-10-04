library coDesignCPU;
use coDesignCPU.muxreg.all;
library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity cpu_tb is
end cpu_tb;

architecture TB_ARCHITECTURE of cpu_tb is
	-- Component declaration of the tested unit
	component cpu
	port(
		clk : in STD_LOGIC;
		rst : in STD_LOGIC
		 );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal rst : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : cpu
		port map (
			clk => clk,
			rst => rst
			
		);

	-- Add your stimulus here ...
   process
   begin
   	 clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
   end process;		  
   
   rst <= '1','0' after 10 ns;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cpu of cpu_tb is
	for TB_ARCHITECTURE
		for UUT : cpu
			use entity work.cpu(cpu);
		end for;
	end for;
end TESTBENCH_FOR_cpu;

