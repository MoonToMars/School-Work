library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;


entity fib_seq is
-- IO
	port (
		clk					: in std_logic;
		N						: in std_logic_vector(4 downto 0);
		DC_IN					: in std_logic;
		PB						: in std_logic;
		S						: in std_logic;
		START					: in std_logic;
		SEVEN_SEG_DISPLAY : out std_logic_vector(41 downto 0)
	);
end entity fib_seq;


architecture convertor of fib_seq is
	signal prev_val  : integer := 0;
	signal pres_val  : integer := 1;
	type segment_values is array (0 to 5) of std_logic_vector(3 downto 0);
	signal decimals : segment_values; -- Array of each segment's display represented by their decimal value

begin
	
	truth_table_action: process (clk,  prev_val, pres_val, START, DC_IN, S, PB, N)
	 -- Note that you need to use variables because signals are only assigned after the process!
		variable prev 			: integer 	:= 0;
		variable pres 			: integer 	:= 1;
		variable index_pos	: integer 	:= 1;
		variable count			: integer	:= 0; 	-- Number of rising edges that have elapsed
		constant delay_time	: integer	:= 25000000;		-- Number of rising edges we want to delay by
		variable pb_released : std_logic := '1'; 	-- Used to check when the user has released PB

	begin
		
		if (rising_edge(clk)) then

			prev := prev_val;
			pres := pres_val;

			
			if START = '1' then
			-- Display first element and reset variables
				prev := 0;
				pres := 1;
				index_pos := 1;
				pres_val <= 1;
				prev_val <= 0;
			elsif (DC_IN = '1' and index_pos < N and index_pos < 30) then
			-- Begin Traversing the Fibonacci series in ascending order
				if count >= delay_time then
					index_pos := index_pos + 1;
					pres_val <= pres + prev;
					prev_val <= pres;
					count := 0;
				else
					count := count + 1;
				end if;

			else
				if (S = '1' and (PB = '0' and PB_released = '1') and index_pos < N and index_pos < 30) then
				-- Traverse one step in the Fibonacci series in ascending order
					index_pos := index_pos + 1;
					pres_val <= pres + prev;
					prev_val <= pres;
				
					-- Stay zero until user releases button
					PB_released := '0';

				elsif (S = '0' and (PB = '0' and PB_released = '1') and 1 < index_pos) then
				-- Traverse one step in the Fibonacci series in descending order
					index_pos := index_pos - 1;

					-- Set previous values using some cool math
					pres_val <= prev;
					prev_val <= pres - prev;
					
					-- Stay zero until user releases button
					PB_released := '0';

				elsif (PB = '1') then
				-- Push button is released and we keep previous values
					PB_released := '1';
					pres_val <= pres;
					prev_val <= prev;
				else
				-- Do nothing
					pres_val <= pres;
					prev_val <= prev;
				end if;
			end if;
		end if;

	end process truth_table_action;

	dec_segments_rep: process (decimals, pres_val)		
	-- Convert each decimal value to its 4-bit binary decimal representation (0-9) and store it in an array
		variable temp : integer := 1;
	begin
		temp := pres_val / 10;
		temp := pres_val - (temp * 10);
		decimals(0) <= std_logic_vector(to_unsigned(temp, decimals(0)'length)); -- get first 1st order number
		
		temp := pres_val / 100;
		temp := (pres_val - (temp * 100)) / 10;
		decimals(1) <= std_logic_vector(to_unsigned(temp, decimals(1)'length));
		
		temp := pres_val / 1000;
		temp := (pres_val - (temp * 1000)) / 100;
		decimals(2) <= std_logic_vector(to_unsigned(temp, decimals(2)'length));

		temp := pres_val / 10000;
		temp := (pres_val - (temp * 10000)) / 1000;
		decimals(3) <= std_logic_vector(to_unsigned(temp, decimals(3)'length));

		temp := pres_val / 100000;
		temp := (pres_val - (temp * 100000)) / 10000;
		decimals(4) <= std_logic_vector(to_unsigned(temp, decimals(4)'length));
		
		temp := pres_val / 100000;
		decimals(5) <= std_logic_vector(to_unsigned(temp, decimals(5)'length));
	end process dec_segments_rep;
	

	set_segments: process (decimals)
	-- Mapping out of decimals to each corresponding seven segment value for all 6 displays
		type seven_segs is array (0 to 5) of std_logic_vector(6 downto 0);
		variable seven_bit_val : seven_segs;
	begin
		for i in decimals' range loop
		-- Traverse each seven-segment display and assign its corresponding decimal value
			case decimals(i) is
				when "0000" => seven_bit_val(i):= "1000000"; -- 0
				when "0001" => seven_bit_val(i):= "1111001"; -- 1
				when "0010" => seven_bit_val(i):= "0100100"; -- 2
				when "0011" => seven_bit_val(i):= "0110000"; -- 3
				when "0100" => seven_bit_val(i):= "0011001"; -- 4
				when "0101" => seven_bit_val(i):= "0010010"; -- 5
				when "0110" => seven_bit_val(i):= "0000010"; -- 6
				when "0111" => seven_bit_val(i):= "1111000"; -- 7
				when "1000" => seven_bit_val(i):= "0000000"; -- 8
				when "1001" => seven_bit_val(i):= "0010000"; -- 9
				when others => seven_bit_val(i):= "1111111"; -- All Off
			end case;			
		end loop;
		
		-- Last step! Assigning output value
		SEVEN_SEG_DISPLAY <= (seven_bit_val(5) & seven_bit_val(4) & seven_bit_val(3) & seven_bit_val(2) & seven_bit_val(1) & seven_bit_val(0));

	end process set_segments;
end architecture convertor;
