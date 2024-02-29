-- Team Number (T-ZERO)
-- Dr. Abdallah S. Abdallah 
-- aua639@psu.edu
-- Comparator_4bits_fromScratch.vhd
-- Version 1.0 , 02/24/2019

library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity Comparator_4bits_fromScratch is
 port(
 
 A_EXT,B_EXT : in STD_LOGIC_VECTOR(3 downto 0);
 
 Greater, Equal, Less : out STD_LOGIC
 );
 
 end Comparator_4bits_fromScratch;


Architecture design1 of Comparator_4bits_fromScratch is



component Comparator_2bits_stolen is
port (
 A,B: in std_logic_vector(1 downto 0); -- two inputs for comparison
 A_less_B: out std_logic; -- '1' if A < B else '0'
 A_equal_B: out std_logic;-- '1' if A = B else '0'
 A_greater_B: out std_logic-- '1' if A > B else '0'
 );
 
end component;


signal GHigh, EHigh, LHigh , GLOW, ELOW, LLOW : std_logic;


begin





comp0 : Comparator_2bits_stolen port map (  A_EXT (1 downto 0), B_EXT (1 downto 0) ,  LLOW, ELOW, GLOW);

comp1 : Comparator_2bits_stolen port map (  A_EXT (3 downto 2), B_EXT (3 downto 2) , LHIGH, EHIGH, GHIGH);


Greater <= GHIGH OR (EHIGH AND GLOW); 

Equal  <= EHIGH AND ELOW; 

Less <= LHIGH OR (EHIGH AND LLOW);





end  design1; 