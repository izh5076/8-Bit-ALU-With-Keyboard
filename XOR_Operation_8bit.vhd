-- Team Number 5
-- Dominick Button and Issac Heim
-- dmb6904@psu.edu and izh5076@psu.edu
-- XOR_Operation4bit.vhd
-- Version 1.0 , 11/16/2022

--This file implements a 8 bit XOR operation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity XOR_Operation8bit is 
Port (
-- 8 bit inputs to be XORed together
A,B : in std_logic_vector (7 downto 0); 

-- The 8 bit result of the XOR operation
Result : out std_logic_vector (7 downto 0) );
end XOR_Operation8bit;

architecture RTL of XOR_Operation8bit is

begin

Result <= A xor B; 

end RTL;
