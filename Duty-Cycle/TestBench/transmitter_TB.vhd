library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity transmitter_tb is
end transmitter_tb;

architecture TB_ARCHITECTURE of transmitter_tb is
	-- Component declaration of the tested unit
	component transmitter
	port(
		clk : in STD_LOGIC;
	--	tdin : in STD_LOGIC;
		txin : in UNSIGNED(7 downto 0);
		txout : out STD_LOGIC
		--tdout : out STD_LOGIC
		);
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	--signal tdin : STD_LOGIC;
	signal txin : UNSIGNED(7 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal txout : STD_LOGIC;
	--signal tdout : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : transmitter
		port map (
			clk => clk,
			--tdin => tdin,
			txin => txin,
			txout => txout
			--tdout => tdout
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
		--tdin <= '0';
		--wait for 10 ns;
		--tdin <= '1';
		txin<= x"00";
		wait for 200 ns;
		--tdin <= '0';
		--wait for 10 ns;
		---tdin <= '1';
		txin <= x"02";
		wait for 200 ns;
		
		txin <= x"A0";
		wait for 200 ns;
		txin <= x"02";
		--tdin <= '0';
		wait for 200 ns;
		wait;
	end process;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_transmitter of transmitter_tb is
	for TB_ARCHITECTURE
		for UUT : transmitter
			use entity work.transmitter(transmitter);
		end for;
	end for;
end TESTBENCH_FOR_transmitter;

