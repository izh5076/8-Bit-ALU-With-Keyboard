-- Team Number 5
-- Dominick Button and Issac Heim
--dmb6904@psu.edu and izh5076@psu.edu
-- AND_Operation4Bit.vhd
-- Version 1.0 , 11/16/2022

--This file implements an 8 bit AND operation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity AND_Operation_8bit is 
Port (
--8 bit inputs to be ANDed together
A,B : in std_logic_vector (7 downto 0);

-- The result of the and operation 
Result : out std_logic_vector (7 downto 0) );
end AND_Operation_8bit;

architecture RTL of AND_Operation_8bit is

begin

Result <= A and B; 

end RTL;
