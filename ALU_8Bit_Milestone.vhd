-- Team Number 5
-- Dominick Button and Issac Heim
-- dmb6904@psu.edu and izh5076@psu.edu
-- ALU_8Bit_Milestone.vhd
-- Version 1.0 , 11/9/2022

--This is file implements an 8 bit 12 operations ALU

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU_8Bit_Milestone is
    Port (
        --Value to be passed to input A or input B
		A_Or_B_Value: in std_logic_vector(7 downto 0); 
		
		Reg_Clear: in std_logic; 
		
		--switch to control when the shift registers shift
		Load_Shift: in std_logic;  
		
		--Carry in for the adder
		Cin_EXT: in std_logic; 
		
		--Master Clock to be divided
		CLK: in std_logic; 
		
		--Clock for ps2 keyboard
		PS2_CLK: in std_logic; 
		
		--Data from ps2 keyboard
		PS2_DATA: in std_logic; 
		 
		
		--Signal for the decimal point for the carry out
		DP_EXT: out std_logic; 
		
		--7 segment display anodes
		an: out std_logic_vector(3 downto 0); 
				
		--7 segment display Cathodes
		seg : out std_logic_vector(6 downto 0)
		);
end ALU_8Bit_Milestone;

architecture RTL of ALU_8Bit_Milestone is 

component ALU_8Bit is
 port(
        -- 8 bit inputs to the ALU
		A,B: in std_logic_vector (7 downto 0);
		
		--Clock signal for the sequential elements
		CLK: in std_logic; 
		
		--Signal to control when the registers shift
		LoadOrShift: in std_logic; 
		
		--Resets the sequential shift registers
		Reset: in std_logic; 
		
		-- The carry in for the adder
		Cin: in std_logic; 
		
		-- Carry out for the adder
		Cout: out std_logic; 
		
		--Results for the first 4 operations
		Adder_Result,And_Result,Or_Result,Xor_Result: out std_logic_vector(7 downto 0); 
		
		-- The output from the comparator.  
        Compare_Result: out std_logic_vector (2 downto 0);
        
        -- Single bit outputs
        Prime_Result,Odd_Result,Even_Result: out std_logic;
		
		-- 8 bit results from the adder, the And operation, the OR operation, and the XOR operation 
		Multiplication_Result,Circular_Shift_Result,Shift_Right_Result,Shift_Left_Result: out std_logic_vector(7 downto 0)
		
			 
 );
 
 end component; 
 
component Sequential_7Segments_Decoder is
    Port ( 
	--Value to be displayed (8 bit value)
	value : in std_logic_vector(7 downto 0);
	
	--Clock to control the switching of the anodes
    Sclk : in std_logic;
    
    -- The anodes will be treated as if they are different 
    -- communication channels, which are getting activated and deactivated according to the internal subclock (Sclk)
    channels : out std_logic_vector(3 downto 0);
    -- segs are actually your cathod values
    segs : out std_logic_vector(6 downto 0); 
    
    --Decimal point signal
    dp : out std_logic
    ); 

end component; 

component Compare_Operation_Decoder is
    Port (
        --Value to be turned into a G, E, or L
		Compare_Value: in std_logic_vector(2 downto 0); 
		
		-- The signal for the anodes 
		anodes: out std_logic_vector(3 downto 0); 
		
		-- Value for the cathodes to display
		SegVal: out std_logic_vector(6 downto 0)
		);
end component; 

component ClockDivider is

Port (
--System clock signal
CLK : in std_logic; 

--Desired clock signal
CLK_Desired : out std_logic );
end component; 

component DataFlowController is
 port(
  -- 16 8 bit inputs to be passed to the output
  I0, I1, I2, I3, I4, I5, I6, I7, I8, I9, I10, I11, I12, I13, I14, I15: in STD_LOGIC_VECTOR(7 downto 0);
  
  --Select lines to be used to select the input 
  Selectors: in std_logic_vector (3 downto 0); 
  
  --The final result of the multiplexer, in this case, the result to be passed to the seven segment display. 
  Final_Result : out std_logic_vector (7 downto 0)
 );
 end component;
 
 component ClockDivider_1Hz is
 
 Port (
 --System clock signal
 CLK : in std_logic; 
 
 --Desired clock signal
 CLK_Desired : out std_logic );
 end component; 
 

 
 component USB_keyboard_Top is
     port(clk : in std_logic;
         PS2Clk : in std_logic;
         PS2Data : in std_logic;
         led : out std_logic_vector (15 downto 0));
 end component; 
 
 Component Load_Only_PIPO is
     Port (
     --Load/pause signal
         Load_NoChange: in std_logic; 
         
         --Reset signal for the PIPO
         Reset: in std_logic; 
         
         --Fast clock to make sure input gets into the PIPO
         CLK: in std_logic; 
         
         --Data to load into the register
         Data_In: in std_logic_vector(7 downto 0); 
         
         --The output of the PIPO register
         Data_Out: out std_logic_vector(7 downto 0)
         );
 end component; 
 
 component Scan_Code_Converter is
 port(
 
 -- 8 bit input
 ScanCode : in std_logic_vector(7 downto 0);
 
 Enter: out std_logic; 
 
 -- indicates if the input is a number
 Number_Or_Func: out std_logic;  
 
 
 --The value to be passed to input buffers
 TrueValue : out std_logic_vector(7 downto 0)
     );
 end component; 
 
--Internal signals for input A and B
signal A, B: std_logic_vector(7 downto 0); 

--Internal signal for the result value to be passed to the seven segment decoder
signal INT_Result: std_logic_vector(7 downto 0);

--Internal cathode value to be multiplexed to the cathodes
signal INT_Seg: std_logic_vector(6 downto 0);  

-- an internal cathode signal for when the comparator is on
signal Comparator_Segs: std_logic_vector(6 downto 0); 

--Carry out result to be processed for the decimal point
signal cout_int: std_logic; 

--Internal signals for the anodes from the seven segment decoder and the comparator decoder
signal Comparator_Anodes, INT_An: std_logic_vector(3 downto 0); 

--100 Hz clock signal to drive the system. 
signal SegClock: std_logic; 

--1 Hz clock sgnal to drive the PIPO elements in the ALU
signal ALU_Clock: std_logic; 

--Results for all outputs from the ALU
signal Adder_Result_INT, And_Result_INT, Or_Result_INT, Xor_Result_INT, Prime_Result_INT, 
Odd_Result_INT, Even_Result_INT, Compare_Result_INT, Multiply_Result_INT, 
Shift_Left_Result_INT, Shift_Right_Result_INT, Circular_Shift_Result_INT:  std_logic_vector(7 downto 0);

-- Value from the keyboard
signal scanVal : std_logic_vector(15 downto 0);

--Opcode for the ALU, however, it is a standard 8 bits from the input Memory
signal intOpcode : std_logic_vector(7 downto 0); 

--Internal signal that takes on the Value of the B PIPO shift register
signal B_Int : std_logic_vector(7 downto 0); 

--Internal signals to tell whether the input is a number or a function. 
signal Is_Num_Or_Func,Is_Num_Or_Func_BAR: std_logic; 


signal Conversion: std_logic_vector(7 downto 0); 
signal Is_Enter: std_logic; 
signal B_PIPO_Enable: std_logic; 



begin 
--Module that gets the keyboard scan codes from a PS2 compatible key board
KeyboardTop: USB_keyboard_Top port map(CLK, PS2_CLK, PS2_DATA, scanVal); 

--converts the scan code to an actual value and outputs a signal to the 
Code_Converter: Scan_Code_Converter port map(scanVal(15 downto 8),Is_Enter, Is_Num_Or_Func, Conversion); 

-- used for a load signal
Is_Num_Or_Func_BAR <= (not Is_Num_Or_Func) and (not Is_Enter); 


--Holds input A
A_PIPO: Load_Only_PIPO port map(Is_Num_Or_Func_BAR, Reg_Clear, SegClock, B_Int, A); 

B_PIPO_Enable <= Is_Num_Or_Func and (not Is_Enter); 
-- holds input B
B_PIPO: Load_Only_PIPO port map(B_PIPO_Enable, Reg_Clear, SegClock, Conversion, B_Int);

-- Moves the internal signal to B for the ALU
B <= B_Int;  

--Holds the operation code. 
Operation: Load_Only_PIPO port map(Is_Num_Or_Func_BAR, Reg_Clear, SegClock, Conversion, intOpcode);

--Main ALU module that gets all results for all operations
ALU: ALU_8Bit port map(A, B, ALU_Clock, Load_Shift, Reg_Clear, Cin_EXT, cout_int , Adder_Result_INT, And_Result_INT, 
Or_Result_INT, Xor_Result_INT, Compare_Result_INT(2 downto 0), Prime_Result_INT(0), Odd_Result_INT(0),
Even_Result_INT(0), Multiply_Result_INT, Circular_Shift_Result_INT, Shift_Right_Result_INT, Shift_Left_Result_INT); 

--Processes the carry out signal, if the adder operation is selected, the carry out is processed and sent to the dp
DP_EXT <= not cout_int when intOpcode(3 downto 0) = "0000" else
          'Z'; 

--16 to one multiplexer to decide which result to output to the seven segment display
 OutputController:  DataFlowController port map(Adder_Result_INT, And_Result_INT, Or_Result_INT, Xor_Result_INT, Compare_Result_INT, 
 Prime_Result_INT, Odd_Result_INT, Even_Result_INT, Multiply_Result_INT, Circular_Shift_Result_INT, Shift_Right_Result_INT, 
 Shift_Left_Result_INT, "ZZZZZZZZ", "ZZZZZZZZ", "ZZZZZZZZ", "ZZZZZZZZ", intOpcode(3 downto 0), INT_Result); 

--Takes in the master clock and outputs a 100 Hz clock to drive the system. 
Divider: ClockDivider port map(CLK, SegClock); 
SlowClock: ClockDivider_1Hz port map(CLK, ALU_Clock); 

--Outputs the cathode value for the comparator when the opcode is the comparator
Compare_Segs: Compare_Operation_Decoder port map(Compare_Result_INT(2 downto 0), Comparator_Anodes, Comparator_Segs); 

 
--Seven segment Decoder
SevenSeg: Sequential_7Segments_Decoder port map(INT_Result, SegClock, INT_An, INT_Seg);

--sets the seven segment to the comparator setting when the opcode is the comparator
seg <= Comparator_Segs when intOpcode(3 downto 0) = "0100" else
       INT_Seg; 
       
--setting the seven segment anodes to the comparator setting when the opcode is the comparator. 
an <= Comparator_Anodes when intOpcode(3 downto 0) = "0100" else
      INT_An; 
end RTL; 