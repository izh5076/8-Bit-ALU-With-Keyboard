-- fpga4student.com: FPGA projects, Verilog projects, VHDL projects 
-- VHDL project: VHDL code for a comparator 
-- A comparator with 2 2-bit input A and B, and three outputs 
-- A less than B, A equal B, and A greater than B
-- The comparator is designed by using truth table, K-Map. 
-- The final output expressions are used for VHDL coding
library IEEE;
use IEEE.std_logic_1164.all;
entity Comparator_2bits_stolen is
port (
 A,B: in std_logic_vector(1 downto 0); -- two inputs for comparison
 A_less_B: out std_logic; -- '1' if A < B else '0'
 A_equal_B: out std_logic;-- '1' if A = B else '0'
 A_greater_B: out std_logic-- '1' if A > B else '0'
 );
end Comparator_2bits_stolen;
architecture comparator_structural of Comparator_2bits_stolen is


-- intermediate names for internal wires

signal tmp1,tmp2,tmp3,tmp4,tmp5, tmp6, tmp7, tmp8: std_logic; 
-- temporary signals 
begin
 -- A_equal_B combinational logic circuit
 tmp1 <= A(1) xnor B(1);
 tmp2 <= A(0) xnor B(0);
 A_equal_B <= tmp1 and tmp2;
 -- A_less_B combinational logic circuit
 tmp3 <= (not A(0)) and (not A(1)) and B(0);
 tmp4 <= (not A(1)) and B(1);
 tmp5 <= (not A(0)) and B(1) and B(0);
 A_less_B <= tmp3 or tmp4 or tmp5;
 -- A_greater_B combinational logic circuit
 tmp6 <= (not B(0)) and (not B(1)) and A(0);
 tmp7 <= (not B(1)) and A(1);
 tmp8 <= (not B(0)) and A(1) and A(0);
 A_greater_B <= tmp6 or tmp7 or tmp8;
end comparator_structural;