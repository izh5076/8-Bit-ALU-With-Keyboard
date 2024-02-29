-- Team Number 5
-- Dominick Button and Issac Heim
--dmb6904@psu.edu and izh5076@psu.edu
-- isOdd_Operation_8bit.vhd
-- Version 1.0 , 11/16/2022

--This file implements an 8 bit isOdd operation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity isOdd_Operation_8bit is 
Port (
--8 bit inputs that will be compared with each other
A : in std_logic_vector (7 downto 0);

-- The result of the compare operation 
Odd : out std_logic );
end isOdd_Operation_8bit;

architecture behavioral of isOdd_Operation_8bit is

begin

Odd <= A(0) and '1'; 

end behavioral;