library ieee;
use ieee.std_logic_1164.all;

entity USB_keyboard_Top is
	port(clk : in std_logic;
		PS2Clk : in std_logic;
		PS2Data : in std_logic;
		led : out std_logic_vector (15 downto 0));
end USB_keyboard_Top;

architecture behavioral of USB_keyboard_Top is

	type state_type is (PRESS, EXTEND, RLS, CHECK); 

	signal state     : state_type := PRESS;
	signal received  : std_logic_vector (23 downto 0);
	signal data      : std_logic_vector (7 downto 0);
	signal ledreg    : std_logic_vector (7 downto 0);
	signal ready     : std_logic;
	signal ready_prev: std_logic;
  
	component USB_keyboard is
		port(ps2data : in std_logic;
			  ps2clk : in std_logic;
				data : out std_logic_vector (7 downto 0);
			   ready : out std_logic
				);
	end component;

begin
	process (clk)
	begin
		if rising_edge(clk) then
		ready_prev <= ready;

			case state is
			when PRESS =>
			  if (ready_prev='0' and ready='1') then
			  received(23 downto 16) <= data;
			  state <= EXTEND;
			  end if;
			when EXTEND =>
			  if (ready_prev='0' and ready='1') then
			  received(15 downto 8) <= data;
			  state <= RLS;
			  end if; 
			when RLS =>
			  if (received(15 downto 8) /= x"F0") then 
			  state <= EXTEND;
			  elsif (ready_prev='0' and ready='1') then
			  received(7 downto 0) <= data;
			  state <= CHECK;
			  end if;     
			when CHECK =>
				case received(7 downto 0) is 
					when x"16" => ledreg(0) <= not ledreg(0); --toggle if 1 is pressed
					when x"1E" => ledreg(1) <= not ledreg(1); --toggle if 2 is pressed
					when x"26" => ledreg(2) <= not ledreg(2); --toggle if 3 is pressed
					when x"25" => ledreg(3) <= not ledreg(3); --toggle if 4 is pressed
					when x"2E" => ledreg(4) <= not ledreg(4); --toggle if 5 is pressed
					when x"36" => ledreg(5) <= not ledreg(5); --toggle if 6 is pressed
					when x"3D" => ledreg(6) <= not ledreg(6); --toggle if 7 is pressed
					when x"3E" => ledreg(7) <= not ledreg(7); --toggle if 8 is pressed
					when others => ledreg <= ledreg;
				end case;
				state <= PRESS;
			end case;
		end if;
	end process;

	led <= received(7 downto 0) & ledreg;

	kb1 : USB_keyboard port map(ps2data => PS2Data, ps2clk => PS2Clk, data => data, ready => ready);
      
end behavioral;
