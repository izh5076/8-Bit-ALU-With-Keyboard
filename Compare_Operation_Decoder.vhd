-- Team Number 5
-- Dominick Button and Issac Heim
-- dmb6904@psu.edu and izh5076@psu.edu
-- Compare_Operation_Decoder.vhd
-- Version 1.0 , 11/29/2022

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Compare_Operation_Decoder is
    Port (
		Compare_Value: in std_logic_vector(2 downto 0); 
		anodes: out std_logic_vector(3 downto 0); 
		SegVal: out std_logic_vector(6 downto 0)
		);
end Compare_Operation_Decoder;

architecture RTL of Compare_Operation_Decoder is 
begin

	anodes <= "1110"; 
			
	SegVal <= "1000111" when Compare_Value = "001" else
			  "0000110" when Compare_Value = "010" else
			  "0010000" when Compare_Value = "100" else
			  "ZZZZZZZ"; 
end RTL; 