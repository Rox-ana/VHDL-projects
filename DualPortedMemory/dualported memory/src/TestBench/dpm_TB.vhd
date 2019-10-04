library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity dpm_tb is
	-- Generic declarations of the tested unit
		generic(
		dw : POSITIVE := 8;
		aw : POSITIVE := 8 );
end dpm_tb;

architecture TB_ARCHITECTURE of dpm_tb is
	-- Component declaration of the tested unit
	component dpm
		generic(
		dw : POSITIVE := 8;
		aw : POSITIVE := 8 );
	port(
		clk : in STD_LOGIC;
		cs1 : in STD_LOGIC;
		we1 : in STD_LOGIC;
		cs2 : in STD_LOGIC;
		we2 : in STD_LOGIC;
		ad1 : in STD_LOGIC_VECTOR(aw-1 downto 0);
		ad2 : in STD_LOGIC_VECTOR(aw-1 downto 0);
		d1 : inout STD_LOGIC_VECTOR(dw-1 downto 0);
		d2 : inout STD_LOGIC_VECTOR(dw-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC;
	signal cs1 : STD_LOGIC;
	signal we1 : STD_LOGIC;
	signal cs2 : STD_LOGIC;
	signal we2 : STD_LOGIC;
	signal ad1 : STD_LOGIC_VECTOR(aw-1 downto 0);
	signal ad2 : STD_LOGIC_VECTOR(aw-1 downto 0);
	signal d1 : STD_LOGIC_VECTOR(dw-1 downto 0);
	signal d2 : STD_LOGIC_VECTOR(dw-1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : dpm
		generic map (
			dw => dw,
			aw => aw
		)

		port map (
			clk => clk,
			cs1 => cs1,
			we1 => we1,
			cs2 => cs2,
			we2 => we2,
			ad1 => ad1,
			ad2 => ad2,
			d1 => d1,
			d2 => d2
		);

	-- Add your stimulus here ...  
	process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;
	
	process
	begin
	cs1 <= '0';
	cs2 <= '0';
	wait for 10ns;
	cs1 <= '1';
	cs2 <= '1';
	we1 <= '1';
	we2 <= '1';
	ad1 <= x"ff";
	ad2 <= x"fe";
	d1 <= x"de";
	d2 <= x"4a";
	wait for 10 ns;
	cs1 <= '1';
	cs2 <= '1';
	we1 <= '1';
	we2 <= '0';
	ad1 <= x"fd";
	ad2 <= x"ff";
	d2 <= (others => 'Z');
	d1 <= x"2a";
	wait for 10 ns;
	cs1 <= '1';
	cs2 <= '1';
	we1 <= '0';
	we2 <= '1';
	ad1 <= x"fe";
	ad2 <= x"fc";
	d1 <= (others => 'Z');
	d2 <= x"e2";
	wait for 10 ns;
	 cs1 <= '1';
	cs2 <= '1';
	we1 <= '0';
	we2 <= '0';
	d1 <= (others => 'Z');
	d2 <= (others => 'Z');
	ad1 <= x"fc";
	ad2 <= x"fd";
	wait for 10 ns;
	cs1 <= '0';
	cs2 <= '0';
	wait for 10 ns;
	wait ;
	end process;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_dpm of dpm_tb is
	for TB_ARCHITECTURE
		for UUT : dpm
			use entity work.dpm(dpm);
		end for;
	end for;
end TESTBENCH_FOR_dpm;

