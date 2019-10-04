library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity reciever_tb is
end reciever_tb;

architecture TB_ARCHITECTURE of reciever_tb is
	-- Component declaration of the tested unit
	component reciever
	port(
		clk : in STD_LOGIC;
		rxin : in STD_LOGIC;
		--din : in STD_LOGIC;
		--dout : out STD_LOGIC;
		rxout : out UNSIGNED(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal rxin : STD_LOGIC;
	--signal din : STD_LOGIC;
	-- Observed signals - signals mapped to the output ports of tested entity
	--signal dout : STD_LOGIC;
	signal rxout : UNSIGNED(7 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : reciever
		port map (
			clk => clk,
			rxin => rxin,
			--din => din,
			--dout => dout,
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
		--din <= '1';
		rxin <='1';
		wait for 20ns;
		--din <= '0';
		rxin <= '0';
		wait for 180 ns;
		--din <= '1';
		rxin <= '1';
		wait for 180 ns;
		rxin <= '0';
		wait for 20 ns;
		rxin <= '1';
		wait for 178 ns;
		rxin <= '0';
		wait for 22 ns;
		
		wait;
		end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_reciever of reciever_tb is
	for TB_ARCHITECTURE
		for UUT : reciever
			use entity work.reciever(reciever);
		end for;
	end for;
end TESTBENCH_FOR_reciever;

