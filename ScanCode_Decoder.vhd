-- Team Number 5
-- Dominick Button and Issac Heim
--dmb6904@psu.edu and izh5076@psu.edu
-- ScanCode_Converter.vhd
-- Version 1.0 , 11/16/2022

--File implements a scan code converter to map key strokes to usable values. 
library IEEE;
use IEEE.std_logic_1164.all;

entity Scan_Code_Converter is
port(

-- 8 bit input
ScanCode : in std_logic_vector(7 downto 0);

Enter: out std_logic; 

-- indicates if the input is a number
Number_Or_Func: out std_logic;  


--The value to be passed to input buffers
TrueValue : out std_logic_vector(7 downto 0)
	);
end Scan_Code_Converter;

architecture behavior of Scan_Code_Converter is 

begin
	
	TrueValue <= "00000000" when ScanCode = x"45" else
				 "00000001" when ScanCode = x"16" else
				 "00000010" when ScanCode = x"1E" else
				 "00000011" when ScanCode = x"26" else 
				 "00000100" when ScanCode = x"25" else
				 "00000101" when ScanCode = x"2E" else
				 "00000110" when ScanCode = x"36" else
				 "00000111" when ScanCode = x"3D" else
				 "00001000" when ScanCode = x"3E" else
				 "00001001" when ScanCode = x"46" else
				 "00000000" when ScanCode = x"05" else
				 "00000001" when ScanCode = x"06" else
				 "00000010" when ScanCode = x"04" else
				 "00000011" When ScanCode = x"0C" else
				 "00000100" when ScanCode = x"03" else
				 "00000101" when ScanCode = x"0B" else
				 "00000110" when ScanCode = x"83" else
				 "00000111" when ScanCode = x"0A" else
				 "00001000" when ScanCode = x"01" else
				 "00001001" when ScanCode = x"09" else
				 "00001010" when ScanCode = x"78" else
				 "00001011" when ScanCode = x"07" else
				 "ZZZZZZZZ"; 
				 
	Number_Or_Func <= 
	             '1' when ScanCode = x"45" else
                  '1' when ScanCode = x"16" else 
                  '1' when ScanCode = x"1E" else
                  '1' when ScanCode = x"26" else
                  '1' when ScanCode = x"25" else
                  '1' when ScanCode = x"2E" else
                  '1' when ScanCode = x"36" else
                  '1' when ScanCode = x"3D" else
                  '1' when ScanCode = x"3E" else
                  '1' when ScanCode = x"46" else
                  '0'; 
                  
    Enter <= '1' when ScanCode = x"5A" else
             '0'; 
			
			
end behavior;  