library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity USB_keyboard is
    port(ps2data : in std_logic;
          ps2clk : in std_logic;
            data : out std_logic_vector (7 downto 0);
           ready : out std_logic);
end USB_keyboard;

architecture behavioral of USB_keyboard is


    component bitwise_XNOR is
        port(  data : in std_logic_vector (7 downto 0);
           myresult : out std_logic
           );
    end component;


	type state_type is (RDY, RECEIVE, PARITY, STOP); 

	signal state   : state_type := RDY;
	signal received: std_logic_vector (7 downto 0);
	signal prty    : std_logic;
	signal index   : integer := 0;
	signal xnor_result : STD_LOGIC;
  


	begin
	
	instance1: bitwise_XNOR port map(received,xnor_result);
	
	process(ps2clk)
	begin
		if falling_edge(ps2clk) then

			case state is
				when RDY =>
					if (ps2data = '0') then 
					state <= RECEIVE; 
					ready <= '0'; 
					index <= 0;      
					end if;
				when RECEIVE =>
					if (index = 7) then 
					state <= PARITY; 
					end if; 
					received(index) <= ps2data; 
					index <= index + 1;
				when PARITY =>
					prty <= ps2data;  
					state <= STOP;
				when STOP =>
					if (ps2data = '1') then 
					state <= RDY; 
					ready <= '1';
						if (prty /= xnor_result) then 
						data <= x"EE"; 
						else 
						data <= received ;
						end if;
					end if;
			end case;
		end if;
	end process;
 
end behavioral;
