-- Team Number (T-ZERO)
-- Dr. Abdallah S. Abdallah 
-- aua639@psu.edu
-- Sequential_7Segments_Decoder.vhd
-- Version 1.0 , 10/17/2018
---
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Sequential_7Segments_Decoder is
    Port ( 
		
		value : in std_logic_vector(7 downto 0);
		clk : in std_logic;
		dp : out std_logic;
		-- The anodes will be treated as if they are different 
		-- communication channels, which are getting activated and deactivated according to the internal subclock (Sclk)
		channels : out std_logic_vector(3 downto 0);
		
		-- segs are actually your cathod values
	    segs : out std_logic_vector(6 downto 0));
end Sequential_7Segments_Decoder;


architecture behavioral of Sequential_7Segments_Decoder is
    
    
    signal counting: integer :=1; 
	signal cnt: std_logic_vector(25 downto 0); -- divider counter for ~95.3Hz refresh rate (with 100MHz main clock)


	signal intAn: std_logic_vector(3 downto 0); -- internal signal representing Anodes' Values

     --   signal channelsBuffer: std_logic_vector(7 downto 0):= X"00";

signal value1 : std_logic_vector(3 downto 0);
signal value2 : std_logic_vector(3 downto 0);  
signal s,Sclk : std_logic;

begin
	
	
	value1 <= value(3 downto 0);
	value2 <= value(7 downto 4);
	
	 channels <= intAn;
  --seg <= hex;

  -- Clock Division Block
  clockDivider: process(clk)
  begin
    if clk'event and clk = '1' then
        -- every 12.5M clocks
        --resets after 6.25 M clocks
            if cnt = "10111110101111000010000000" then
                s <= not s; -- toggle s
               cnt <="00000000000000000000000000";
            else
                cnt <= cnt +1;
            end if;
    end if;
    
  end process clockDivider;
  
  
  
  
  
  
  
  
  
  Sclk <= s;
  
 
  
    process (Sclk) 
	
	begin
	

       if  Sclk = '1' then
               
               
              intAn <=  "0111";
			  dp <= '1';
                                        
	      end if;
	      
      
       if  Sclk = '0' then
                           
                         
              intAn <= "1110";
                
              dp <= '0';
                                 
           end if;




	end process;
   	
	
	
	
	
	
    process (intAn) 
    begin
	
	if (intAn = "1110" ) THEN 
	    case value2 is
	 --   case counting is
		when "0000" => segs <= NOT "0111111"; -- 0
		when "0001" => segs <=NOT "0000110"; -- 1
		when "0010" => segs <=NOT "1011011"; -- 2
		when "0011" => segs <=NOT "1001111"; -- 3
		when "0100" => segs <=NOT "1100110"; -- 4
		when "0101" => segs <=NOT "1101101"; -- 5
		when "0110" => segs <=NOT "1111101"; -- 6
		when "0111" => segs <=NOT "0000111"; -- 7
		when "1000" => segs <=NOT "1111111"; -- 8
		when "1001" => segs <=NOT "1100111"; -- 9
		when "1010" => segs <=NOT "1110111"; -- A
		when "1011" => segs <=NOT "1111100"; -- b
		when "1100" => segs <=NOT "0111001"; -- c
		when "1101" => segs <=NOT "1011110"; -- d
		when "1110" => segs <=NOT "1111001"; -- E
		when others => segs <=NOT "1110001"; -- F
	    end case;
	    
	    else 
	    
	    case value1 is
     --   case counting is
        when "0000" => segs <= NOT "0111111"; -- 0
        when "0001" => segs <=NOT "0000110"; -- 1
        when "0010" => segs <=NOT "1011011"; -- 2
        when "0011" => segs <=NOT "1001111"; -- 3
        when "0100" => segs <=NOT "1100110"; -- 4
        when "0101" => segs <=NOT "1101101"; -- 5
        when "0110" => segs <=NOT "1111101"; -- 6
        when "0111" => segs <=NOT "0000111"; -- 7
        when "1000" => segs <=NOT "1111111"; -- 8
        when "1001" => segs <=NOT "1100111"; -- 9
        when "1010" => segs <=NOT "1110111"; -- A
        when "1011" => segs <=NOT "1111100"; -- b
        when "1100" => segs <=NOT "0111001"; -- c
        when "1101" => segs <=NOT "1011110"; -- d
        when "1110" => segs <=NOT "1111001"; -- E
        when others => segs <=NOT "1110001"; -- F
        end case;
        
        end if ;
	
    end process;
    
  

end behavioral;
  
    