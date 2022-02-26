library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity div is 
port ( CLK, GO, RESET: in std_logic;
A,B: in std_logic_vector (3 downto 0);
--Q,R: out std_logic_vector (3 downto 0);
DONE: out std_logic;
segQ, segR: out std_logic_vector(6 downto 0)
);
end div; 

architecture behavioural of div is 
type state_type is (S0,S1,S2,S3);
signal state, next_state: state_type; 
signal RQ: std_logic_vector (3 downto 0);
signal RA: std_logic_vector (3 downto 0);
signal RB: std_logic_vector (3 downto 0);
signal RR: std_logic_vector (3 downto 0);                                                                                                                                                                                                                                                                                                                       
signal C: std_logic_vector (1 downto 0);
signal segQ_sig : std_logic_vector(6 downto 0);
signal segR_sig : std_logic_vector(6 downto 0);
signal RQ_output: std_logic_vector (3 downto 0);
signal RR_output: std_logic_vector (3 downto 0);


begin 
state_r: process (CLK, RESET)

   begin 
	if (RESET = '0') then 
		state <= S0;
   else 
		state <= next_state;
    end if;
     
end process;

next_states: process (CLK, state)
begin 
if(rising_edge(CLK)) then
		 case state is 
			when S0 => 
					C <= "11";
					RR <= "0000";
					RQ <= "0000";
					DONE <= '0';
			  
					if (GO = '1') then 
						 next_state <= S1;
					else
						 RB <= B;
						 RA <= A;
						 next_state <= S0;
					end if;
			  
			when S1 =>
				RR <= RR(2 downto 0) & RA(3);
				RA <= RA (2 downto 0) & '0';
				next_state <= S2;
				
			when S2 =>
				C<= C - B"01"; 
				
				if (RR>=RB) then
					RQ <= RQ (2 downto 0) & '1';
					RR <= RR - RB; 
				
				else 
					RQ <= RQ (2 downto 0) & '0';
				end if;
				
				if (C= B"00") then 
					next_state <= S3; 
				else 
					next_state <= S1;
				end if;
				
			when S3 => 
				DONE <= '1'; 
		--		Q <= RQ;
		--		R <= RR;
		--		RQ_output<= RQ;
		--		RR_output<= RR; 
				next_state <= S0;
		end case;
end if;
end process;


    with RQ select
    segQ_sig <=  "1000000" when "0000", -- 0
              "1111001" when "0001", -- 1
              "0100100" when "0010", -- 2
              "0110000" when "0011", -- 3
              "0011001" when "0100", -- 4
              "0010010" when "0101", -- 5
              "0000010" when "0110", -- 6
              "1111000" when "0111", -- 7
              "0000000" when "1000", -- 8
              "0010000" when "1001", -- 9
              "1111111" when others; -- All Off  

    
    with RR select
    segR_sig <=  "1000000" when "0000", -- 0
              "1111001" when "0001", -- 1
              "0100100" when "0010", -- 2
              "0110000" when "0011", -- 3
              "0011001" when "0100", -- 4
              "0010010" when "0101", -- 5
              "0000010" when "0110", -- 6
              "1111000" when "0111", -- 7
              "0000000" when "1000", -- 8
              "0010000" when "1001", -- 9
              "1111111" when others; -- All Off 
				  
		segR <= segR_sig;
		segQ <= segQ_sig;	 
			 
end behavioural; 