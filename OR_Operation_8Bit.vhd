-- Team Number 5
-- Dominick Button and Issac Heim
--dmb6904@psu.edu and izh5076@psu.edu
-- OR_Opeation4Bit.vhd
-- Version 1.0 , 11/16/2022

--This file implements a 8 bit OR operation

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity OR_Operation8bit is 
Port (
--8 bit inputs to be ORed together
A,B : in std_logic_vector (7 downto 0);

--The result of the OR operation 
Result : out std_logic_vector (7 downto 0) );
end OR_Operation8bit;

architecture RTL of OR_Operation8bit is

begin

Result <= A or B; 

end RTL;
