-- Team Number 5
-- Dominick Button and Issac Heim
--dmb6904@psu.edu and izh5076@psu.edu
-- Multiply_by_2_Operation_8Bit.vhd
-- Version 1.0 , 11/16/2022

library IEEE;
use IEEE.std_logic_1164.all;

entity Multiply_by_2_Operation_8Bit is
port(

CLEAR, CLK, Enable : in  std_logic;
-- 8 bit input that will be multiplied by 2
A : in std_logic_vector(7 downto 0);
Load_Shift: in std_logic; 
-- 8 bit output that is the product of A*2
Result : out std_logic_vector(7 downto 0)
	);
end Multiply_by_2_Operation_8Bit;

architecture behavioral of Multiply_by_2_Operation_8Bit is
signal Q : std_logic_vector(7 downto 0); 

begin

process(CLK) is begin
	 if rising_edge(clk) then
        if CLEAR = '1' then
          Q <= "00000000";
        elsif Enable = '1' then                
        if (Load_Shift = '0') then
        -- Load new data into the register
            Q <= A;
        else    
            -- This is a default Shift Left Register
            -- (No further Control over the shifting direction
            Q(7 downto 1) <= Q(6 downto 0);
            Q(0) <= '0';            
        end if;
        
     end if;
end if;
end process;
		
Result <= Q;
	
end behavioral;