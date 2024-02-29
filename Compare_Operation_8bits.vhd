-- Team Number 5
-- Dominick Button and Issac Heim 
-- dmb6904@psu.edu and izh5076@psu.edu
-- Compare_Operation_8bits.vhd
-- Version 1.0 , 11/17/2022

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Compare_Operation_8bits is
 port(
 
 A, B : in std_logic_vector(7 downto 0);
 
 Greater_EXT, Equal_EXT, Less_EXT : out std_logic
 );
 
 end Compare_Operation_8bits;
 
 Architecture RTL of Compare_Operation_8bits is

component Comparator_4bits_fromScratch is
 port(
 
 A_EXT,B_EXT : in STD_LOGIC_VECTOR(3 downto 0);
 
 Greater, Equal, Less : out STD_LOGIC
 );
 
 end component;
 
 signal G1, E1, L1, G0, E0, L0 : std_logic; 
 
begin


--Creating an instance of a 4 bit comparator to get the compare value of the low 4 bits
comparator0: Comparator_4bits_fromScratch port map(A(3 downto 0), B(3 downto 0), G0, E0, L0);

--Creating an instance of a 4 bit comparator to get the compare value of the high 4 bits
comparator1: Comparator_4bits_fromScratch port map(A(7 downto 4), B(7 downto 4), G1, E1, L1);


Greater_EXT <= G1 or (E1 and G0); 

Equal_EXT  <= E1 and E0; 

Less_EXT <= L1 or (E1 and L0);


end RTL; 