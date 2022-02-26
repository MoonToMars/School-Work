library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.MATH_REAL.ALL;

entity react is 
port ( clk, pb1,pb0, RESET: in std_logic;
	seg7s,seg7a3,seg7a2,seg7a1,seg7a0: out std_logic_vector (6 downto 0);
	DONE: out std_logic);
end react;

architecture life of react is
	
	signal divided_clk : std_logic := '0';
   signal response_clk : std_logic := '0';
	signal seg7a00: integer;
	signal seg7a11: integer;
	signal seg7a22: integer;
	signal seg7a33: integer;
	signal seg7ss: integer;
	signal counter: integer;
	signal sevens: integer; --keeps track of number of sevens
	signal average_value: integer; --average value in miliseconds
	signal response_time: integer; --total value of ALL of the miliseconds until last response inputted

	type test_data_test is array (0 to 29) of integer;
	signal test_data: test_data_test;

begin
   test_data <= (1,2,0,7,5,4,3,7,4,1,2,2,1,7,4,7,6,2,5,7,1,4,7,9,7,5,6,1,3,0); --setting our values

	
	clock_divider: process (clk)
		variable clk_count: integer:=0;
	begin
		if(clk'event and clk = '1') then
			if clk_count = 25000000 then-- for simulation replace 25000000 by 2 or 4 to minimize simulation time
				divided_clk <= not divided_clk;
				clk_count := 0;
			else
				clk_count := clk_count + 1;
			end if;
		end if;
	end process;  -- ends clock_divider process
	
	
	
	clock_response: process (clk)
		variable clk_r: integer:=0;
	begin
		if(clk'event and clk = '1') then
			if clk_r = 25000 then-- for simulation replace 25000000 by 2 or 4 to minimize simulation time
				response_clk <= not response_clk;
				clk_r := 0;
			else
				clk_r := clk_r + 1;
			end if;
		end if;
	end process;  -- ends clock_divider process
	

	seven_tracker: process(pb0) --keeps track of number of sevens
	begin
		if (reset = '0') then
			sevens <= 0;
		elsif(response_clk'event and response_clk = '1') then
			if(pb0 = '0' and sevens /= 0) then --delete sevens when pushbutton 0 is pressed but doesn't allow. Cannot have negative values (for cheaters)
					sevens <= sevens - 1;
			elsif(test_data(counter) = 7 and pb0 = '1') then	--adds a seven counter if a new seven occurs and pushbutton is not being pressed(safety feature for super fast people)
				sevens <= sevens + 1;	
			end if;
		end if;
	end process;
	
	
	timer: process (divided_clk,RESET, pb1)
	begin 
		if (RESET = '0') then
			counter <= 0;
		elsif (rising_edge(divided_clk)) then 
			if (pb1 = '1' and counter /= 29) then 
				counter <= counter + 1;
				seg7ss <= test_data(counter);
			end if;
			if (sevens /= 0) then	--will multiply 
				response_time <= response_time + 1*sevens;			--keeps track of miliseconds for each 7 not responded to
			end if;
		end if;
   end process;
	
	second_averager: process(divided_clk)  --This function will see if every number in the array has been counted for and if so it will average out the 
	begin
	if (reset = '0') then
				seg7a33 <= 0;
            seg7a22 <= 0;
            seg7a11 <= 0;
			   seg7a00 <= 0;
		elsif (rising_edge(divided_clk)) then 
		if(counter = 29 and sevens = 0) then
			 average_value <= response_time / 7;
			 
			 seg7a00 <= average_value mod 10; --0.00#'s value
			 seg7a11 <= ((average_value - seg7a00) mod 100)/10; --0.0#0's value
			 seg7a22 <= ((average_value - seg7a11*10 - seg7a00) mod 1000) / 100; --0.#00's value
			 seg7a33 <= ((average_value - seg7a22*100 - seg7a11*10 - seg7a00) mod 10000) / 1000; --#.000's value


		end if;
	end if;
	end process;
	
	
	
	
				 with seg7a00 select
	seg7a0 <=  "1000000" when 0,
					"1111001" when 1, -- 1
					"0100100" when 2, -- 2
					"0110000" when 3, -- 3
					"0011001" when 4, -- 4
					"0010010" when 5, -- 5
					"0000010" when 6, -- 6
					"1111000" when 7, -- 7
					"0000000" when 8, -- 8
					"0010000" when 9, -- 9
					"1111111" when others; -- All Off
	
	
	with seg7a11 select
	seg7a1 <=  "1000000" when 0,
					"1111001" when 1, -- 1
					"0100100" when 2, -- 2
					"0110000" when 3, -- 3
					"0011001" when 4, -- 4
					"0010010" when 5, -- 5
					"0000010" when 6, -- 6
					"1111000" when 7, -- 7
					"0000000" when 8, -- 8
					"0010000" when 9, -- 9
					"1111111" when others; -- All Off
					
	with seg7a22 select
	seg7a2 <=  "1000000" when 0,
					"1111001" when 1, -- 1
					"0100100" when 2, -- 2
					"0110000" when 3, -- 3
					"0011001" when 4, -- 4
					"0010010" when 5, -- 5
					"0000010" when 6, -- 6
					"1111000" when 7, -- 7
					"0000000" when 8, -- 8
					"0010000" when 9, -- 9
					"1111111" when others; -- All Off
	with seg7a33 select
	seg7a3 <=  "1000000" when 0,
					"1111001" when 1, -- 1
					"0100100" when 2, -- 2
					"0110000" when 3, -- 3
					"0011001" when 4, -- 4
					"0010010" when 5, -- 5
					"0000010" when 6, -- 6
					"1111000" when 7, -- 7
					"0000000" when 8, -- 8
					"0010000" when 9, -- 9
					"1111111" when others; -- All Off
			 
	
					
	with seg7ss select
	seg7s <=   "1000000" when 0,
					"1111001" when 1, -- 1
					"0100100" when 2, -- 2
					"0110000" when 3, -- 3
					"0011001" when 4, -- 4
					"0010010" when 5, -- 5
					"0000010" when 6, -- 6
					"1111000" when 7, -- 7
					"0000000" when 8, -- 8
					"0010000" when 9, -- 9
					"1111111" when others; -- All Off
end life; 