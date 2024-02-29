-- Team Number 5
-- Dominick Button and Issac Heim
--dmb6904@psu.edu and izh5076@psu.edu
-- PIPO_Shift_Right_Operation_8Bit.vhd
-- Version 1.0 , 11/16/2022

-- File implements an 8 bit shift right PIPO shift register

library IEEE;
use IEEE.std_logic_1164.all;

entity PIPO_Shift_Right_Operation_8Bit is
port(
-- Clear, Clock, and Enable Signal
CLEAR, CLK, Enable : in  std_logic;
-- 8 bit input
A : in std_logic_vector(7 downto 0);

-- Value to be shifted with. 
Push_Value: in std_logic; 
-- Load or Shift input
Load_Shift : in std_logic;
-- 8 bit output
Dout : out std_logic_vector(7 downto 0)
	);
end entity PIPO_Shift_Right_Operation_8Bit;

architecture behavior of PIPO_Shift_Right_Operation_8Bit is

signal Q : std_logic_vector(7 downto 0);
begin
	
process(CLK) is
begin
	 if rising_edge(clk) then
   if CLEAR = '1' then
     Q <= "00000000";
   elsif Enable = '1' then                
   if (Load_Shift = '0') then
   -- Load new data into the register
       Q <= A;
   else    
       -- This is a default Shift Right Register
       -- (No further Control over the shifting direction
       Q(7) <= Push_Value;  
       Q(6 downto 0) <= Q(7 downto 1);
       -- Load 0 into the 7th bit position           
        end if;
    end if;
end if; 
end process;

Dout <= Q;
	
end behavior;
