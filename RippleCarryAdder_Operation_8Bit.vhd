-- Team Number 5
-- Dominick Button and Issac Heim 
-- dmb6904@psu.edu and izh5076@psu.edu
--RippleCarryAdder_Operation_8Bit.vhd
-- Version 1.0 , 11/16/2022


-- This file implements a design of a 8 Bit Ripple Carry Adder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity RippleCarryAdder_8Bit is
Port (  
A_EXT : in std_logic_vector(7 downto 0); 
B_EXT : in std_logic_vector(7 downto 0);
Sum_EXT : out std_logic_vector(7 downto 0); 
Cin_EXT : in std_logic; 
Cout_EXT : out std_logic );
end RippleCarryAdder_8Bit;

architecture RTL of RippleCarryAdder_8Bit is

component FullAdder_1bit is
port (
B: in std_logic;
A: in std_logic;
Cin: in std_logic;
SUM: out std_logic;
Cout: out std_logic 
); 
end component; 

signal Cout0, Cout1, Cout2, Cout3, Cout4, Cout5, Cout6  : std_logic; 

begin

adder0 : FullAdder_1bit port map ( B_EXT(0), A_EXT(0), Cin_EXT, Sum_EXT(0), Cout0 );  
adder1 : FullAdder_1bit port map ( B_EXT(1), A_EXT(1), Cout0, Sum_EXT(1), Cout1 );  
adder2 : FullAdder_1bit port map ( B_EXT(2), A_EXT(2), Cout1, Sum_EXT(2), Cout2 );  
adder3 : FullAdder_1bit port map ( B_EXT(3), A_EXT(3), Cout2, Sum_EXT(3), Cout3 );  
adder4 : FullAdder_1bit port map ( B_EXT(4), A_EXT(4), Cout3, Sum_EXT(4), Cout4 );  
adder5 : FullAdder_1bit port map ( B_EXT(5), A_EXT(5), Cout4, Sum_EXT(5), Cout5 );  
adder6 : FullAdder_1bit port map ( B_EXT(6), A_EXT(6), Cout5, Sum_EXT(6), Cout6 );  
adder7 : FullAdder_1bit port map ( B_EXT(7), A_EXT(7), Cout6, Sum_EXT(7), Cout_EXT );  


end RTL;
