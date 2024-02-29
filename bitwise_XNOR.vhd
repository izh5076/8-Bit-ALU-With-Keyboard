library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity bitwise_XNOR is
        port(  data : in std_logic_vector (7 downto 0);
               myresult : out std_logic
               );
end bitwise_XNOR;



architecture behav of bitwise_XNOR is

begin


    myresult <= data(0) xnor data(1) xnor data(2) xnor data(3) xnor data(4) xnor data(5) xnor data(6) xnor data(7); 



end behav;