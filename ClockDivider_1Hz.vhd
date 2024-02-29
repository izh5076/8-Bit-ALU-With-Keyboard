-- Team Number 5
-- Dominick Button and Issac Heim
-- dmb6904@psu.edu and izh5076@psu.edu
-- ClockDivider.vhd
-- Version 1.0 , 10/15/2022


library IEEE;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ClockDivider_1Hz is

Port (
--System clock signal
CLK : in std_logic; 

--Desired clock signal
CLK_Desired : out std_logic );
end ClockDivider_1Hz;

architecture RTL of ClockDivider_1Hz is
--The width of the counter max value
constant countWidth : integer := 25;
--The max counter value 
constant Max_Count : std_logic_vector(countWidth downto 0) := "10111110101111000010000000"; 

--integer to increase the count by
signal counting: integer :=1; 
--Running totoal of count
signal cnt: std_logic_vector(countWidth downto 0);
-- The signal to be toggled to become the desired CLK
signal s : std_logic;
 
begin


ClockDivider_1Hz: process(clk)
begin
  if clk'event and clk = '1' then
      -- every 12.5M clocks
      --resets after 6.25 M clocks
          if cnt = Max_Count then
              s <= not s; -- toggle s
             cnt <="00000000000000000000000000";
          else
              cnt <= cnt + 1;
          end if;
  end if;
  
end process ClockDivider_1Hz;

CLK_desired <= s; 

end RTL;