-- Team Number 5
-- Dominick Button and Issac Heim 
-- dmb6904@psu.edu and izh5076@psu.edu
-- isPrime_Operation_8Bits.vhd
-- Version 1.0 , 11/17/2022

--File implements a unit to determine if the input number is prime. 

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity isPrime_Operation_8Bits is
 port(
	-- an 8 bit binary input number
	A: in std_logic_vector (7 downto 0); 

	--output that is 1 if A is prime and 0 if A is not prime
	prime: out std_logic
 );
 
 end isPrime_Operation_8Bits;
 
 architecture RTL of isPrime_Operation_8Bits is 
 
 begin
	--Most simplified SOP expression
	prime <= ((not A(3)) and (not A(2)) and A(1)) or ((not A(2)) and A(1) and A(0)) or
	 ((not A(3)) and  A(2) and  A(0)) or (A(2) and (not A(1)) and A(0)); 
 
 end RTL; 