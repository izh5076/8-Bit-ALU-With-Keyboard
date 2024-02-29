-- Team Number 5
-- Dominick Button and Issac Heim 
-- dmb6904@psu.edu and izh5076@psu.edu
-- ALU_8Bit.vhd
-- Version 1.0 , 11/22/2022

--File implments the operations of a 12 operations 8 bit ALU

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ALU_8Bit is
 port(
        -- 8 bit inputs to the ALU
		A,B: in std_logic_vector (7 downto 0);
		CLK: in std_logic; 
		
		LoadOrShift: in std_logic; 
		
		Reset: in std_logic; 
		-- The carry in for the adder
		Cin: in std_logic; 
		
		-- Carry out for the adder
		Cout: out std_logic; 
		
		Adder_Result,And_Result,Or_Result,Xor_Result: out std_logic_vector(7 downto 0); 
		
		-- The output from the comparator.  
        Compare_Result: out std_logic_vector (2 downto 0);
        
        -- Single bit outputs
        Prime_Result,Odd_Result,Even_Result: out std_logic;
		
		-- 8 bit results from the adder, the And operation, the OR operation, and the XOR operation 
		Shift_Right_Result,Shift_Left_Result,Circular_Shift_Result,Multiplication_Result: out std_logic_vector(7 downto 0)
		
			 
 );
 
 end ALU_8Bit;
 
 architecture RTL of ALU_8Bit is 
 
 component RippleCarryAdder_8Bit is
Port (  
A_EXT : in std_logic_vector(7 downto 0); 
B_EXT : in std_logic_vector(7 downto 0);
Sum_EXT : out std_logic_vector(7 downto 0); 
Cin_EXT : in std_logic; 
Cout_EXT : out std_logic );
end component; 

component AND_Operation_8bit is 
Port (
--8 bit inputs to be ANDed together
A,B : in std_logic_vector (7 downto 0);

-- The result of the and operation 
Result : out std_logic_vector (7 downto 0) );
end component; 

component OR_Operation8bit is 
Port (
--8 bit inputs to be ORed together
A,B : in std_logic_vector (7 downto 0);

--The result of the OR operation 
Result : out std_logic_vector (7 downto 0) );
end component; 

component XOR_Operation8bit is 
Port (
-- 8 bit inputs to be XORed together
A,B : in std_logic_vector (7 downto 0); 

-- The 8 bit result of the XOR operation
Result : out std_logic_vector (7 downto 0) );
end component; 

 
 component Compare_Operation_8bits is 
  port(
 
 A, B : in std_logic_vector(7 downto 0);
 
 Greater_EXT, Equal_EXT, Less_EXT : out std_logic
 );
 end component; 
 
 component isPrime_Operation_8Bits
 
  port(
	-- an 8 bit binary input number
	A: in std_logic_vector (7 downto 0); 

	--output that is 1 if A is prime and 0 if A is not prime
	prime: out std_logic
 );
 
 end component; 
 
 component isOdd_Operation_8bit is 
Port (
--8 bit inputs that will be compared with each other
A : in std_logic_vector (7 downto 0);

-- The result of the compare operation 
Odd : out std_logic );

end component; 

component isEven_Operation_8bit is 
Port (
--8 bit input 
A : in std_logic_vector (7 downto 0);

-- The result of whether the the input A is even or not
Even : out std_logic );
end component;

component Multiply_by_2_Operation_8Bit is
port(

CLEAR, CLK, Enable : in  std_logic;
-- 8 bit input that will be multiplied by 2
A : in std_logic_vector(7 downto 0);
Load_Shift: in std_logic; 
-- 8 bit output that is the product of A*2
Result : out std_logic_vector(7 downto 0)
	);
end component; 

component PIPO_Shift_Right_Operation_8Bit is
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
end component; 

component PIPO_Shift_Left_Operation_8Bit is
port(
-- Clear, Clock, and Enable Signal
CLEAR, CLK, Enable : in  std_logic;
-- 8 bit input
A : in std_logic_vector(7 downto 0);

-- Value to be shifted with
Push_Value: in std_logic; 
-- Load or Shift input
Load_Shift : in std_logic;
-- 8 bit output
Dout : out std_logic_vector(7 downto 0)
	);
end component; 
component Circular_Shift_Right_Operation_8Bit is
port(
-- Clear, Clock, and Enable Signal
CLEAR, CLK, Enable : in  std_logic;
-- 8 bit input
A : in std_logic_vector(7 downto 0);
-- Load or Shift input
Load_Shift : in std_logic;
-- 8 bit output
Dout : out std_logic_vector(7 downto 0)
	);
end component; 

 

 
 begin
 
 Adder_Unit: RippleCarryAdder_8Bit port map(A, B, Adder_Result, Cin, Cout);
 And_Operation: AND_Operation_8bit port map (A, B, And_Result); 
 Or_Operation: OR_Operation8bit port map(A, B, Or_Result); 
 Xor_Operation: XOR_Operation8bit port map (A, B, Xor_Result); 
 Compare_Operation: Compare_Operation_8bits port map(A, B, Compare_Result(2), Compare_Result(1), Compare_Result(0)); 
 Is_Prime_Operation: isPrime_Operation_8Bits port map(A, Prime_Result); 
 Is_Odd_Operation: isOdd_Operation_8bit port map(A, Odd_Result); 
 Is_Even_Operation: isEven_Operation_8bit port map(A, Even_Result);
 
Multiply_By_2_Operation: Multiply_by_2_Operation_8Bit port map(Reset, CLK, '1', A, LoadOrShift, Multiplication_Result); 
Circular_Shift_Right: Circular_Shift_Right_Operation_8Bit port map(Reset, CLK, '1', A, LoadOrShift, Circular_Shift_Result); 
Shift_Right_Operation: PIPO_Shift_Right_Operation_8Bit port map(Reset, CLK, '1', A, '0', LoadOrShift, Shift_Right_Result); 
Shift_Left_Operation: PIPO_Shift_Left_Operation_8Bit port map(Reset, CLK, '1', A, '0', LoadOrShift, Shift_Left_Result); 

 
  
 end RTL; 