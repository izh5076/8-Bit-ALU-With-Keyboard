-- Team Number 5
-- Dominick Button and Issac Heim
-- dmb6904@psu.edu and izh5076@psu.edu
-- Load_Only_PIPO.vhd
-- Version 1.0 , 11/29/2022

--This file implements an 8 bit PIPO shift register with a Load signal
--The PIPO is specifically designed to Load when load is high and hold when load is low

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Load_Only_PIPO is
    Port (
    --Load/pause signal
		Load_NoChange: in std_logic; 
		
		--Reset signal for the PIPO shift register. 
		Reset: in std_logic; 
		
		
		--Fast clock to make sure input gets into the PIPO
		CLK: in std_logic; 
		
		--Data to load into the register
		Data_In: in std_logic_vector(7 downto 0); 
		
		--The output of the PIPO register
		Data_Out: out std_logic_vector(7 downto 0)
		);
end Load_Only_PIPO;

architecture behavioral of Load_Only_PIPO is 
-- Flip flop output signal
signal Q: std_logic_vector (7 downto 0); 

begin

process(CLK) is
begin 
    
if rising_edge(CLK) then 
    if Reset = '1' then 
        Q <= "00000000"; 
    elsif Load_NoChange = '1' then 
    Q <= Data_In; 
    end if; 
end if; 
Data_Out <= Q; 
 
end process; 
end behavioral; 
