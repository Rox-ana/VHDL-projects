-------------------------------------------------------------------------------
--
-- Title       : Q1
-- Design      : Cad Lab
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : Q1.vhd
-- Generated   : Sun Oct  7 10:22:49 2018
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
--{entity {Q1} architecture {Q1}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.ALL;
entity Q1 is
	
	port(
		RESET_N	: in std_logic;
		SW0 : IN STD_logic;	--ON/0FF
		SW1 : IN STD_logic;	--START/STOP
		CLOCK_50 	: in std_logic;
		HEX0	: out std_logic_vector(6 downto 0);
		HEX1	: out std_logic_vector(6 downto 0);
		HEX2	: out std_logic_vector(6 downto 0);
		HEX3	: out std_logic_vector(6 downto 0)
	);
	
end Q1;

--}} End of automatically maintained section

architecture Q1 of Q1 is 
-- CONVERTING THE NUMBER TO STD_LOGIC_VECTOR--
function convSEG (N : std_logic_vector(3 downto 0)) return std_logic_vector is
		variable ans:std_logic_vector(6 downto 0);
begin
	Case N is
		when "0000" => ans:="1000000";	 
		when "0001" => ans:="1111001";
		when "0010" => ans:="0100100";
		when "0011" => ans:="0110000";
		when "0100" => ans:="0011001";
		when "0101" => ans:="0010010";
		when "0110" => ans:="0000010";
		when "0111" => ans:="1111000";
		when "1000" => ans:="0000000";
		when "1001" => ans:="0010000";	   				
		when others => ans:="1111111";
	end case;	
	return ans;
end function convSEG;
--****************************************************
function modTen ( N : unsigned(6 downto 0)) return std_logic_vector is
variable res : std_logic_vector(6 downto 0);
begin			
	res := std_logic_vector( N mod 10);
	 return res;
	end function modTen;
--****************************************************
function BYTen( N : unsigned(6 downto 0)) return std_logic_vector is
variable res : std_logic_vector(6 downto 0);
begin
	res := std_logic_vector( N / 10);
	return res;
end function BYTen ;
--****************************************************
--SIGNALS--	
SIGNAL HEX0_REG_N, HEX0_REG_P,HEX1_REG_P,HEX1_REG_N : STD_LOGIC_VECTOR(6 downto 0) := (OTHERS => '0'); 
SIGNAL HEX2_REG_P,HEX2_REG_N, HEX3_REG_N,HEX3_REG_P : STD_LOGIC_VECTOR(6 downto 0) := (OTHERS => '0');
-- CENTISECOND SIGNALS
CONSTANT CENTISECOND_COUNT_CONSTANT : UNSIGNED(22 DOWNTO 0) := to_unsigned(5000000,23) ;	
CONSTANT CENTISECOND_CONSTANT : UNSIGNED(6 DOWNTO 0) := TO_UNSIGNED(99,7);
SIGNAL CENTISECOND_COUNT_P, CENTISECOND_COUNT_N : UNSIGNED ( 22 DOWNTO 0) := (OTHERS => '0');
SIGNAL CENTISECOND_TRIGGER : STD_logic:= '0';
SIGNAL CENTISECOND_N, CENTISECOND_P : UNSIGNED (6 DOWNTO 0) := (OTHERS => '0');
-- SECOND SIGNALS
CONSTANT SECOND_CONSTANT : UNSIGNED(6 DOWNTO 0) := TO_UNSIGNED(99,7);
SIGNAL SECOND_TRIGGER : STD_logic := '0';	
SIGNAL SECOND_P, SECOND_N : UNSIGNED (6 DOWNTO 0) := (OTHERS => '0');

--****************************************************
begin  
	-- CONVERTING NUMBERS FOR 7 SEGMENTS --											   
		HEX0 <= convSEG(HEX0_REG_P(3 DOWNTO 0));
		HEX1 <= convSEG(HEX1_REG_P(3 DOWNTO 0));
		HEX2 <= convSEG(HEX2_REG_P(3 DOWNTO 0));
		HEX3 <= convSEG(HEX3_REG_P(3 DOWNTO 0));	
	-- WHAT EACH 7 SEGMENT HAS --	
		HEX0_REG_N <="0001010" WHEN (SW0 = '0' AND SW1 = '0') ELSE MODTen(CENTISECOND_P) WHEN (SW0 = '1' AND SW1 = '1') OR (SW0 = '1' AND SW1 = '0') ELSE (OTHERS => 'Z');
		HEX1_REG_N <="0001010" WHEN (SW0 = '0' AND SW1 = '0') ELSE BYTen(CENTISECOND_P) WHEN (SW0 = '1' AND SW1 = '1') OR (SW0 = '1' AND SW1 = '0') ELSE (OTHERS => 'Z');
		HEX2_REG_N <="0001010" WHEN (SW0 = '0' AND SW1 = '0') ELSE MODTen(SECOND_P) WHEN (SW0 = '1' AND SW1 = '1') OR (SW0 = '1' AND SW1 = '0') ELSE (OTHERS => 'Z');
		HEX3_REG_N <="0001010" WHEN (SW0 = '0' AND SW1 = '0') ELSE BYTen(SECOND_P) WHEN (SW0 = '1' AND SW1 = '1') OR (SW0 = '1' AND SW1 = '0') ELSE (OTHERS => 'Z');
	-- CENTISECOND CONSTANT COUNTER --
	CENTISECOND_COUNT_N <= CENTISECOND_COUNT_P + 1 WHEN CENTISECOND_COUNT_P <= CENTISECOND_COUNT_CONSTANT AND (SW0 = '1' AND SW1 = '1') ELSE CENTISECOND_COUNT_P WHEN (SW0 = '1' AND SW1 = '0') ELSE (OTHERS => '0') ;
	--CENTISECOND_TRIGGER <= '1' WHEN  CENTISECOND_COUNT_P = CENTISECOND_COUNT_CONSTANT ELSE '0';
	-- CENTISECOND COUNTER --
	CENTISECOND_N <= CENTISECOND_P + 1 WHEN( CENTISECOND_P <= CENTISECOND_CONSTANT AND (SW0 = '1' AND SW1 = '1') AND CENTISECOND_COUNT_P = CENTISECOND_COUNT_CONSTANT) ELSE CENTISECOND_P WHEN ((SW0 = '1' AND SW1 = '0') OR ((SW0 = '1' AND SW1 = '1') AND CENTISECOND_COUNT_P /= CENTISECOND_COUNT_CONSTANT )) ELSE (OTHERS => '0'); -- 
	--SECOND_TRIGGER <= '1' WHEN CENTISECOND_P = CENTISECOND_CONSTANT ELSE '0'; 	
	-- SECOND COUNTER --
	SECOND_N <= SECOND_P + 1 WHEN (SECOND_P <= SECOND_CONSTANT AND (SW0 = '1' AND SW1 = '1') AND CENTISECOND_P = CENTISECOND_CONSTANT and CENTISECOND_COUNT_P = CENTISECOND_COUNT_CONSTANT) ELSE SECOND_P WHEN ((SW0 = '1' AND SW1 = '0') OR ((SW0 = '1' AND SW1 = '1') and SECOND_P < SECOND_CONSTANT)) ELSE (OTHERS => '0'); 
	-- THE CLOCK AND RESET PROCESS--
	process( CLOCK_50,RESET_N )
		
	begin  	
		IF 	(RESET_N = '0') THEN 
			--PS <= S0; 
			CENTISECOND_COUNT_P <= (OTHERS => '0');
			CENTISECOND_P <=   (OTHERS => '0');
			SECOND_P <=   (OTHERS => '0');
			HEX0_REG_P <= "0001010";
			HEX1_REG_P <="0001010";
			HEX2_REG_P <="0001010";
			HEX3_REG_P <= "0001010";
			ELSIF (CLOCK_50'EVENT AND CLOCK_50 = '1')THEN
				--PS <= NS;  
				HEX0_REG_P <= HEX0_REG_N;
				HEX1_REG_P <= HEX1_REG_N;
				HEX2_REG_P <= HEX2_REG_N;
				HEX3_REG_P <= HEX3_REG_N;
				CENTISECOND_COUNT_P <= CENTISECOND_COUNT_N;
				CENTISECOND_P <= CENTISECOND_N;
				SECOND_P <= SECOND_N;
		END IF;
		
	end process;  

	

end Q1;
