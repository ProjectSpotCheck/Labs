
--------------------------------------------------------------------------------
--
-- Test Bench for LAB #4
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY mytest IS
END mytest;

ARCHITECTURE behavior OF mytest IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT ALU
	PORT(
		DataIn1 : IN std_logic_vector(31 downto 0);
		DataIn2 : IN std_logic_vector(31 downto 0);
		ALUCtrl : IN std_logic_vector(4 downto 0);          
		Zero : OUT std_logic;
		ALUResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL DataIn1 :  std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL DataIn2 :  std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL control : std_logic_vector(4 downto 0) := (others=>'0');
	
	
	--Outputs
	SIGNAL Zero : std_logic := '0';
	SIGNAL co :  std_logic;
	SIGNAL addsubdataout : std_logic_vector(31 downto 0);

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: ALU PORT MAP(
		DataIn1 => DataIn1,
		DataIn2 => DataIn2,
		ALUCtrl => control,
		ALUResult => addsubdataout
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		-- test the adder--
		DataIn1 <= X"4F302C85";
		DataIn2 <= X"7A222578";
		wait for 20 ns; -- dataout should be 0xC95251FD
		control <= "00010"; -- subtraction at 120nS
		wait for 20 ns; -- dataout should be 0xD50E070D
		control <= "00001"; -- addition at 140nS
		DataIn1 <= X"C0765A22";
		DataIn2 <= X"B4059ADD";
		wait for 20 ns; -- dataout should be 0x747BF4FF
		control <= "00010"; -- subtraction at 160nS
		wait for 20 ns; -- dataout should be 0x0C70BF45

		-- TEST SHIFT --
		DataIn1 <= X"789ABCDE";
		control <= "010--"; -- shift right
		DataIn2 <= "01111000100110101011100001011101"; -- shamt 1 bit
		-- Expected : 0x3C4D5E6F
		wait for 30 ns;
		control <= "011--"; -- shift left
		DataIn2 <= "01111000100110101011100010011110"; -- shamt 2 bits
		-- Expected : 0xE26AF378
		wait for 30 ns; 
		
		-- TEST AND --
		DataIn1 <= X"00000000";
		DataIn2 <= X"FFFFFFFF"; -- expected 0x00000000
		control <= "10---"; 
		wait for 30 ns; 
		DataIn1 <= X"AAAAAAAA";
		DataIn2 <= X"AAAAAAAA"; -- expected 0xAAAAAAAA;
		control <= "10---"; 
		wait for 30 ns;

		-- TEST or --
		DataIn1 <= X"FFFFFFFF";
		DataIn2 <= X"00000000"; -- expected 0xFFFFFFFF
		control <= "11--0"; --or
		wait for 30 ns; 
		DataIn1 <= X"AAAAAAAA";
		DataIn2 <= X"55555555"; -- expected 0xFFFFFFFF
		control <= "11--1"; --ori
		wait for 30 ns; 
		
		wait; -- will wait forever
	END PROCESS;

END;
