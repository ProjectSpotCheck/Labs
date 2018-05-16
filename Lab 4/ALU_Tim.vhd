--------------------------------------------------------------------------------
--
-- LAB #4
--
--------------------------------------------------------------------------------


--- MUX 4 to 1 - (1 BIT) ---
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity mux is
	port (  sel: in std_logic_vector(1 downto 0); 
		A,B,C,D: in std_logic_vector(31 downto 0);
		Y: out std_logic_vector(31 downto 0));
end mux;
	
architecture behavMUX of mux is
begin
	WITH sel SELECT
	   Y <= A when "00",
	  	B when "01",
		C when "10",
		D when others;
end architecture behavMUX;	

------------------------------------------------------------------------------------				 

--- FULLADDER ---
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity fulladder is
    port (a : in std_logic;
          b : in std_logic;
          cin : in std_logic;
          sum : out std_logic;
          carry : out std_logic
         );
end fulladder;

architecture addlike of fulladder is
begin
  sum   <= a xor b xor cin; 
  carry <= (a and b) or (a and cin) or (b and cin); 
end architecture addlike;

--------------------------------------------------------------------------------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity adder_subtracter is
	port(	datain_a: in std_logic_vector(31 downto 0);
		datain_b: in std_logic_vector(31 downto 0);
		add_sub: in std_logic_vector(1 downto 0);
		dataout: out std_logic_vector(31 downto 0);
		co: out std_logic);
end entity adder_subtracter;

architecture calc of adder_subtracter is
	component fulladder is
    		port (a : in std_logic;
         		b : in std_logic;
          		cin : in std_logic;
          		sum : out std_logic;
          		carry : out std_logic);
	end component;	
	signal C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10: std_logic;
	signal C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21: std_logic;
	signal C22,C23,C24,C25,C26,C27,C28,C29,C30,C31: std_logic;
	signal TEMP: std_logic_vector(31 downto 0);
	signal OP: std_logic;
begin
	with add_sub SELECT
		OP <= 	'1' when "10",
			'0' when others;

	TEMP(0)<= OP xor datain_b(0);
	TEMP(1)<= OP xor datain_b(1);
	TEMP(2)<= OP xor datain_b(2);
	TEMP(3)<= OP xor datain_b(3);
	TEMP(4)<= OP xor datain_b(4);
	TEMP(5)<= OP xor datain_b(5);
	TEMP(6)<= OP xor datain_b(6);
	TEMP(7)<= OP xor datain_b(7);
	TEMP(8)<= OP xor datain_b(8);
	TEMP(9)<= OP xor datain_b(9);
	TEMP(10)<= OP xor datain_b(10);
	TEMP(11)<= OP xor datain_b(11);
	TEMP(12)<= OP xor datain_b(12);
	TEMP(13)<= OP xor datain_b(13);
	TEMP(14)<= OP xor datain_b(14);
	TEMP(15)<= OP xor datain_b(15);
	TEMP(16)<= OP xor datain_b(16);
	TEMP(17)<= OP xor datain_b(17);
	TEMP(18)<= OP xor datain_b(18);
	TEMP(19)<= OP xor datain_b(19);
	TEMP(20)<= OP xor datain_b(20);
	TEMP(21)<= OP xor datain_b(21);
	TEMP(22)<= OP xor datain_b(22);
	TEMP(23)<= OP xor datain_b(23);
	TEMP(24)<= OP xor datain_b(24);
	TEMP(25)<= OP xor datain_b(25);
	TEMP(26)<= OP xor datain_b(26);
	TEMP(27)<= OP xor datain_b(27);
	TEMP(28)<= OP xor datain_b(28);
	TEMP(29)<= OP xor datain_b(29);
	TEMP(30)<= OP xor datain_b(30);
	TEMP(31)<= OP xor datain_b(31);

	ad0: fulladder port map(datain_a(0),TEMP(0),OP,dataout(0),C0); 
	ad1: fulladder port map(datain_a(1),TEMP(1),C0,dataout(1),C1); 
	ad2: fulladder port map(datain_a(2),TEMP(2),C1,dataout(2),C2); 	
	ad3: fulladder port map(datain_a(3),TEMP(3),C2,dataout(3),C3);
	ad4: fulladder port map(datain_a(4),TEMP(4),C3,dataout(4),C4);
	ad5: fulladder port map(datain_a(5),TEMP(5),C4,dataout(5),C5);
	ad6: fulladder port map(datain_a(6),TEMP(6),C5,dataout(6),C6);
	ad7: fulladder port map(datain_a(7),TEMP(7),C6,dataout(7),C7);
	ad8: fulladder port map(datain_a(8),TEMP(8),C7,dataout(8),C8);
	ad9: fulladder port map(datain_a(9),TEMP(9),C8,dataout(9),C9);
	ad10: fulladder port map(datain_a(10),TEMP(10),C9,dataout(10),C10);
	ad11: fulladder port map(datain_a(11),TEMP(11),C10,dataout(11),C11);
	ad12: fulladder port map(datain_a(12),TEMP(12),C11,dataout(12),C12);
	ad13: fulladder port map(datain_a(13),TEMP(13),C12,dataout(13),C13);
	ad14: fulladder port map(datain_a(14),TEMP(14),C13,dataout(14),C14);
	ad15: fulladder port map(datain_a(15),TEMP(15),C14,dataout(15),C15);
	ad16: fulladder port map(datain_a(16),TEMP(16),C15,dataout(16),C16);
	ad17: fulladder port map(datain_a(17),TEMP(17),C16,dataout(17),C17);
	ad18: fulladder port map(datain_a(18),TEMP(18),C17,dataout(18),C18);
	ad19: fulladder port map(datain_a(19),TEMP(19),C18,dataout(19),C19); 
	ad20: fulladder port map(datain_a(20),TEMP(20),C19,dataout(20),C20); 
	ad21: fulladder port map(datain_a(21),TEMP(21),C20,dataout(21),C21); 
	ad22: fulladder port map(datain_a(22),TEMP(22),C21,dataout(22),C22); 
	ad23: fulladder port map(datain_a(23),TEMP(23),C22,dataout(23),C23); 
	ad24: fulladder port map(datain_a(24),TEMP(24),C23,dataout(24),C24); 
	ad25: fulladder port map(datain_a(25),TEMP(25),C24,dataout(25),C25);
	ad26: fulladder port map(datain_a(26),TEMP(26),C25,dataout(26),C26); 
	ad27: fulladder port map(datain_a(27),TEMP(27),C26,dataout(27),C27); 
	ad28: fulladder port map(datain_a(28),TEMP(28),C27,dataout(28),C28);
	ad29: fulladder port map(datain_a(29),TEMP(29),C28,dataout(29),C29); 
	ad30: fulladder port map(datain_a(30),TEMP(30),C29,dataout(30),C30); 
	ad31: fulladder port map(datain_a(31),TEMP(31),C30,dataout(31),C31); 
	co <= C31;
end architecture calc;

--------------------------------------------------------------------------------

--- 32-BIT AND ---
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity AND32 is
	port ( DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0));
end AND32;

architecture behavAND32 of AND32 is
begin
	result(31 downto 0) <= dataIn1 and dataIn2;
end architecture behavAND32;

-----------------------------------------------------------------------------------

--- 32-BIT OR ---
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity OR32 is
	port ( DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		op: in std_logic;
		result: out std_logic_vector(31 downto 0));
end OR32;

architecture behavOR32 of OR32 is
begin
	with op SELECT result(31 downto 0) <= 
		(dataIn1 or dataIn2) when '0',
		(dataIn1 or dataIn2) when others;
end architecture behavOR32;

-----------------------------------------------------------------------------------

--- 3-BIT SHIFTER ---
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity shift_register is
	port(	datain: in std_logic_vector(31 downto 0);
	   	dir: in std_logic;
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
end entity shift_register;

architecture shifter of shift_register is
begin
	process (datain,dir,shamt)
	begin
		--SHIFT RIGHT---
		if dir = '0' then
			if shamt = "00001" then
				dataout(30 downto 0) <= datain(31 downto 1);
				dataout(31) <= '0';
			elsif shamt = "00010" then
				dataout(29 downto 0) <= datain(31 downto 2);
				dataout(31 downto 30) <= "00";
			elsif shamt = "00011" then
				dataout(28 downto 0) <= datain(31 downto 3);
				dataout(31 downto 29) <= "000";
			else
				dataout <= datain;
			end if;
		else
		--SHIFT LEFT--
			if shamt = "00001" then
				dataout(31 downto 1) <= datain(30 downto 0);
				dataout(0) <= '0';
			elsif shamt = "00010" then
				dataout(31 downto 2) <= datain(29 downto 0);
				dataout(1 downto 0) <= "00";
			elsif shamt = "00011" then
				dataout(31 downto 3) <= datain(28 downto 0);
				dataout(2 downto 0) <= "000";
			else
				dataout <= datain;
			end if;
		end if;
	end process;
end architecture shifter;

-----------------------------------------------------------------------------------

------ ALU ------
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity ALU is
	Port(	DataIn1:   in std_logic_vector(31 downto 0);
		DataIn2:   in std_logic_vector(31 downto 0);
		ALUCtrl:   in std_logic_vector(4 downto 0);
		Zero:      out std_logic;
		ALUResult: out std_logic_vector(31 downto 0));
end entity ALU;

architecture ALU_Arch of ALU is

component adder_subtracter is
	port(	datain_a: in std_logic_vector(31 downto 0);
		datain_b: in std_logic_vector(31 downto 0);
		add_sub: in std_logic_vector(1 downto 0);
		dataout: out std_logic_vector(31 downto 0);
		co: out std_logic);
end component;

component shift_register is
	port(	datain: in std_logic_vector(31 downto 0);
	   	dir: in std_logic;
		shamt:	in std_logic_vector(4 downto 0);
		dataout: out std_logic_vector(31 downto 0));
end component shift_register;

component AND32 is
	port ( DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		result: out std_logic_vector(31 downto 0));
end component;

component OR32 is
	port ( DataIn1: in std_logic_vector(31 downto 0);
		DataIn2: in std_logic_vector(31 downto 0);
		op: in std_logic;
		result: out std_logic_vector(31 downto 0));
end component;

component mux is
	port (  sel: in std_logic_vector(1 downto 0); 
		A,B,C,D: in std_logic_vector(31 downto 0);
		Y: out std_logic_vector(31 downto 0));
end component;

signal arith: std_logic_vector(31 downto 0);
signal logicAND: std_logic_vector(31 downto 0);
signal logicOR: std_logic_vector(31 downto 0);
signal logicSHIFT: std_logic_vector(31 downto 0);
signal carry: std_logic;
signal result: std_logic_vector(31 downto 0);

begin
	add_sub: 	adder_subtracter port map(DataIn1, DataIn2, ALUCtrl(1 downto 0), arith, carry);
	logic_shift: 	shift_register port map(DataIn1, ALUCtrl(2), DataIn2(10 downto 6), logicSHIFT);
	logic_and: 	AND32 port map(DataIn1, DataIn2, logicAND);
	logic_or: 	OR32 port map(DataIn1, DataIn2, ALUCtrl(0), logicOR);	
	muxOUT: 	mux port map(ALUCtrl(4 downto 3),arith, logicSHIFT, logicAND, logicOR, result);
	ALUResult <= result;
	process(result)
	begin
		if result = "00000000000000000000000000000000" then
			zero <= '1';
		else
			zero <= '0';
		end if;
	end process;
end architecture ALU_Arch;







