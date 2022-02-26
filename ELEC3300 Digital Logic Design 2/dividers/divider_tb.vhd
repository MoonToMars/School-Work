library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
	
entity divider_tb is
end entity;

architecture bh of divider_tb is
	component div is
		Port(
			CLK, GO, RESET: in std_logic;
			A,B: in std_logic_vector (3 downto 0);
			DONE: out std_logic;
			segQ, segR: out std_logic_vector(6 downto 0)
		);
	End component;
	
	signal	init    			: std_logic;
	signal	initvalueA  	: std_logic_vector(3 downto 0);
	signal	initvalueB  	: std_logic_vector(3 downto 0);
	signal	Go					: std_logic;
	signal	Reset				: std_logic;
	signal	Done				: std_logic;
	signal	Qout  			: std_logic_vector(3 downto 0);
	signal	Rout  			: std_logic_vector(3 downto 0);
	
	signal clk 							: std_logic;
	constant period 				: time := 10 ns;
	constant TinputDelay 	: time := 1 ns;
	
	
begin
	
	uut: div

		Port map(
			Go						=> Go,
			Reset					=> Reset,
			clk					=> clk,
			A						=> initvalueA,
			B						=>	initvalueB,
			segQ					=> Qout,
			segR					=> Rout,
			done					=> Done			
		);

		
	process
	begin
	-- Part 1
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		Go		<= '0';
		initvalueA     <= "1111";
		initvalueB     <= "0101";
		wait for period/2;
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		Go		<= '1';
		wait for period/2;
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		wait for period/2;
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		wait for period/2;
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		wait for period/2;
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		wait for period/2;
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		wait for period/2;
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		wait for period/2;
		clk	<= '0';
		wait for period/2;
		clk	<= '1';
		wait for period/2;
		clk	<= '0';
		wait for period/2;
		clk	<= '1';	
	
	end process;
	
end architecture;