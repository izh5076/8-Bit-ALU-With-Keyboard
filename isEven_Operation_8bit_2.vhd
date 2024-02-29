-- Team Number 5
-- Dominick Button and Issac Heim
--dmb6904@psu.edu and izh5076@psu.edu
-- isEven_Operation_8bit.vhd
-- Version 1.0 , 11/16/2022

--This file implements an 8 bit isEven operation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity isEven_Operation_8bit is 
Port (
--8 bit input 
A : in std_logic_vector (7 downto 0);

-- The result of whether the the input A is even or not
Even : out std_logic );
end isEven_Operation_8bit;

architecture behavioral of isEven_Operation_8bit is
begin

Even <= not( A(0) and '1'); 

end behavioral;