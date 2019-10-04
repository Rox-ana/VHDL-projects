library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity pen_tb is
	-- Generic declarations of the tested unit
		generic(
		n : POSITIVE := 3 );
end pen_tb;

architecture TB_ARCHITECTURE of pen_tb is
	-- Component declaration of the tested unit
	component pen
		generic(
		n : POSITIVE := 3 );
	port(
		inp : in STD_LOGIC_VECTOR(2**n-1 downto 0);
		outp : out STD_LOGIC_VECTOR(n-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal inp : STD_LOGIC_VECTOR(2**n-1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal outp : STD_LOGIC_VECTOR(n-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : pen
		generic map (
			n => n
		)

		port map (
			inp => inp,
			outp => outp
		);

	-- Add your stimulus here ...
	
	process
	begin
		wait for 10 ns;
		inp <= "00000011";
		wait for 10 ns;
		inp <= "10000000";
		wait for 10 ns;
		inp <= "10100000";
		wait for 10 ns;
		inp <= "01100011";
		wait for 10 ns;
		wait;
		end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pen of pen_tb is
	for TB_ARCHITECTURE
		for UUT : pen
			use entity work.pen(beh);
		end for;
	end for;
end TESTBENCH_FOR_pen;

