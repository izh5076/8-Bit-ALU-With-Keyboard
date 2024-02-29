-- Team Number 5
-- Dominick Button and Issac Heim 
-- dmb6904@psu.edu and izh5076@psu.edu
--Keyboard_Input_Memory.vhd
-- Version 1.0 , 11/17/2022

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Keyboard_Input_Memory is 
port(
		Keyboard_Input: in std_logic_vector(7 downto 0); 
		A_Input: out std_logic_vector(7 downto 0); 
		B_Input: out std_logic_vector(7 downto 0);
		Standardized_Opcode: out std_logic_vector(7 downto 0); 
		CLK: in std_logic;
		Clear: in std_logic
); 

end Keyboard_Input_Memory; 
architecture behavioral of Keyboard_Input_Memory is 

component Load_Only_PIPO is
    Port (
		Load_NoChange: in std_logic; 
		CLK: in std_logic; 
		Reset : in std_logic; 
		Data_In: in std_logic_vector(7 downto 0); 
		Data_Out: out std_logic_vector(7 downto 0)
		
		);
end component; 
 

component Scan_Code_Converter is
port(

-- 8 bit input
ScanCode : in std_logic_vector(7 downto 0);

-- indicates if the input is a number
Number_Or_Func: out std_logic;  


--The value to be passed to input buffers
TrueValue : out std_logic_vector(7 downto 0)
	);
end component; 

signal Is_Num_Or_Func,Is_Num_Or_Func_BAR: std_logic; 
signal B_Int: std_logic_vector(7 downto 0); 
signal Conversion: std_logic_vector(7 downto 0); 

begin
	Code_Converter: Scan_Code_Converter port map(Keyboard_Input, Is_Num_Or_Func, Conversion); 
	Is_Num_Or_Func_BAR <= not Is_Num_Or_Func; 
	A: Load_Only_PIPO port map(Is_Num_Or_Func_BAR, CLK, Clear, B_Int, A_Input); 
	B: Load_Only_PIPO port map(Is_Num_Or_Func, CLK, Clear, Conversion, B_Int);
	B_Input <= B_Int;  
	Operation: Load_Only_PIPO port map(Is_Num_Or_Func_BAR, CLK, Clear, Conversion, Standardized_Opcode ); 

end behavioral; 
