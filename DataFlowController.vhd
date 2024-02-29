-- Team Number 5
-- Dominick Button and Issac Heim 
-- dmb6904@psu.edu and izh5076@psu.edu
-- DataFlowController.vhd
-- Version 1.0 , 11/22/2022

--This file implements an 8 bit 16 to 1 Multiplexer responsible for controlling the data flow to the 7-segment decoder
--Note: This is a basic 16 to 1 Multiplexer therefore, we must filter our inputs before this point. 

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity DataFlowController is
 port(
  -- 16 8 bit inputs to be passed to the output
  I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15: in STD_LOGIC_VECTOR(7 downto 0);
  
  --Select lines to be used to select the input 
  Selectors: in std_logic_vector (3 downto 0); 
  
  --The final result of the multiplexer, in this case, the result to be passed to the seven segment display. 
  Final_Result : out std_logic_vector (7 downto 0)
 );
 
 end DataFlowController;
 
 architecture RTL of DataFlowController is 
 
 begin
 Final_Result<=		I0 	when Selectors = "0000" else
					I1 	when Selectors = "0001" else
					I2 	when Selectors = "0010" else
					I3 	when Selectors = "0011" else
					I4  when Selectors = "0100" else
					I5 	when Selectors = "0101" else
					I6 	when Selectors = "0110" else
					I7 	when Selectors = "0111" else
					I8	when Selectors = "1000" else
					I9	when Selectors = "1001" else
					I10	when Selectors = "1010" else
					I11	when Selectors = "1011" else
					I12	when Selectors = "1100" else
					I13	when Selectors = "1101" else
					I14	when Selectors = "1110" else
					I15	when Selectors = "1111" else
					"ZZZZZZZZ"; 
 
 end RTL; 