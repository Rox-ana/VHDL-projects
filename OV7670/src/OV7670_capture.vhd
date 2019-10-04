-------------------------------------------------------------------------------
--
-- Title       : OV7670_capture
-- Design      : OV7670
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : OV7670_capture.vhd
-- Generated   : Wed Mar  6 22:56:42 2019
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
--{entity {OV7670_capture} architecture {OV7670_capture}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
entity OV7670_capture is
	generic(
	addr_width : positive := 17;
	data_width : positive := 12;	
	max_value_1 : positive :=  19200;
	max_value_0 : positive :=  76800
	);
	Port (
	rez0 : in std_logic;
	capture : in std_logic;
	one_frame : in std_logic;
	pclk  : in   STD_LOGIC;
           vsync : in   STD_LOGIC;
           href  : in   STD_LOGIC;
           d     : in   STD_LOGIC_VECTOR (7 downto 0);
           addr  : out  STD_LOGIC_VECTOR (addr_width-1 downto 0);
           dout  : out  STD_LOGIC_VECTOR (data_width-1 downto 0);
           we    : out  STD_LOGIC);
end OV7670_capture;

--}} End of automatically maintained section

architecture OV7670_capture of OV7670_capture is
 signal d_latch      : std_logic_vector(15 downto 0) := (others => '0');
   signal address      : STD_LOGIC_VECTOR(addr_width-1 downto 0) := (others => '0');
   signal lin         : std_logic_vector(1 downto 0)  := (others => '0');
   signal href_last    : std_logic_vector(6 downto 0)  := (others => '0');
   signal we_reg       : std_logic := '0';
   signal href_hold    : std_logic := '0';
   signal latched_vsync : STD_LOGIC := '0';
   signal latched_href  : STD_LOGIC := '0';
   signal latched_d     : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	signal frame_reg : std_logic := '1';
begin 
	
   addr <= address;
   we <= we_reg;
   dout    <= d_latch(15 downto 12) & d_latch(10 downto 7) & d_latch(4 downto 1); 
   
   process(pclk)
   begin
	   if rising_edge(pclk) then
     if we_reg = '1' then
            address <= std_logic_vector(unsigned(address)+1);
         end if;
		
         if href_hold = '0' and latched_href = '1' then
            case lin is
               when "00"   => lin <= "01";
               when "01"   => lin <= "10";
               when "10"   => lin <= "11";
               when others => lin <= "00";
            end case;
         end if;
         href_hold <= latched_href;
         
         -- capturing the data from the camera, 12-bit RGB
         if latched_href = '1' then
            d_latch <= d_latch( 7 downto 0) & latched_d;
         end if;
         we_reg  <= '0';

         -- Is a new screen about to start (i.e. we have to restart capturing
         if latched_vsync = '1' then 
            address      <= (others => '0');
            href_last    <= (others => '0');
            lin         <= (others => '0');
				frame_reg <= one_frame;
         else
            -- If not, set the write enable whenever we need to capture a pixel
            if (href_last(6) = '1' and rez0 = '1') or (rez0 = '0' and href_last(2) = '1') then
               if lin = "10" and rez0 = '1' then
						if (unsigned(address) < to_unsigned(max_value_1,15) and capture = '0') or (unsigned(address) < to_unsigned(max_value_1,15) and capture = '1' and frame_reg = '0') then 
							we_reg <= '1';
						end if;
			   elsif (rez0 = '0' and lin(1) = '1') then 
				   if (capture = '0' or (capture = '1' and frame_reg = '0')) then
							we_reg <= '1';
						end if;
               end if;
               href_last <= (others => '0');
            else
               href_last <= href_last(href_last'high-1 downto 0) & latched_href;
            end if;
         end if;
      end if;
      if falling_edge(pclk) then
         latched_d     <= d;
         latched_href  <= href;
         latched_vsync <= vsync;
      end if;
   end process;


end OV7670_capture;
