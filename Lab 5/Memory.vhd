--------------------------------------------------------------------------------
-- Tim Nguyen and Jack Nelson
-- LAB #5 - Memory and Register Bank
-- 06/01/2018
--------------------------------------------------------------------------------
-- single bit storage
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic := '0';
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	
	-- Note that data is output only when enout = 0	
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;

--------------------------------------------------------------------------------
-- 8-bit register
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
	     enout:  in std_logic;
	     writein: in std_logic;
	     dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	c0: bitstorage port map(datain(0),enout,writein,dataout(0));
	c1: bitstorage port map(datain(1),enout,writein,dataout(1));
	c2: bitstorage port map(datain(2),enout,writein,dataout(2));
	c3: bitstorage port map(datain(3),enout,writein,dataout(3));
	c4: bitstorage port map(datain(4),enout,writein,dataout(4));
	c5: bitstorage port map(datain(5),enout,writein,dataout(5));
	c6: bitstorage port map(datain(6),enout,writein,dataout(6));
	c7: bitstorage port map(datain(7),enout,writein,dataout(7));
end architecture memmy;

--------------------------------------------------------------------------------
-- 32-bit register
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	component register8
		port(datain: in std_logic_vector(7 downto 0);
	     		enout:  in std_logic;
	     		writein: in std_logic;
	     		dataout: out std_logic_vector(7 downto 0));
	end component;

	signal en_out16: std_logic;
	signal en_out8: std_logic;
	signal write_in16: std_logic;
	signal write_in8: std_logic;
begin
	en_out16 <= enout32 and enout16;
	en_out8 <= enout32 and enout16 and enout8;

	write_in16 <= writein32 or writein16;
	write_in8 <= writein32 or writein16 or writein8;

	b3: register8 PORT MAP(datain(31 downto 24), enout32, writein32, dataout(31 downto 24));
	b2: register8 PORT MAP(datain(23 downto 16), enout32, writein32, dataout(23 downto 16));
	b1: register8 PORT MAP(datain(15 downto 8), en_out16, write_in16, dataout(15 downto 8));
	b0: register8 PORT MAP(datain(7 downto 0), en_out8, write_in8, dataout(7 downto 0));
	
end architecture biggermem;

--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity RAM is
    Port(Reset:	  in std_logic;
	 Clock:	  in std_logic;	 
	 OE:      in std_logic;
	 WE:      in std_logic;
	 Address: in std_logic_vector(29 downto 0);
	 DataIn:  in std_logic_vector(31 downto 0);
	 DataOut: out std_logic_vector(31 downto 0));
end entity RAM;

architecture staticRAM of RAM is

   	type ram_type is array (0 to 127) of std_logic_vector(31 downto 0);
   	signal i_ram : ram_type;
	signal address_In: integer;
	signal address_Out: integer;
begin
	RamProc: process(Clock, Reset, OE, WE, Address) is
  	begin
	address_In <= to_integer(unsigned(Address));	--Position in ram
	address_Out <= address_In;
	
	--RESET RAM--
	if Reset = '1' then
		i_ram(0 to 127) <= (others => X"00000000");
    	end if;
	
	--WRITE TO RAM--
    	if falling_edge(Clock) then
		if ((address_In >= 0) and (address_In <= 127)) then
			if WE = '1' then
				i_ram(address_In) <= DataIn;
			end if;
		else
			DataOut <= (others => 'Z');
		end if;
   	end if;
	--READ FROM RAM--
	if OE = '0' then
		if ((address_Out >= 0) and (address_Out <= 127)) then
			DataOut <= i_ram(address_Out);
		else
			DataOut <= (others => 'Z');
		end if;
	end if;
  end process RamProc;

end staticRAM;	


--------------------------------------------------------------------------------
LIBRARY ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

entity Registers is
    Port(ReadReg1: in std_logic_vector(4 downto 0); 
         ReadReg2: in std_logic_vector(4 downto 0); 
         WriteReg: in std_logic_vector(4 downto 0);
	 WriteData: in std_logic_vector(31 downto 0);
	 WriteCmd: in std_logic;
	 ReadData1: out std_logic_vector(31 downto 0);
	 ReadData2: out std_logic_vector(31 downto 0));
end entity Registers;

architecture remember of Registers is

	component register32
  	    port(datain: in std_logic_vector(31 downto 0);
		 enout32,enout16,enout8: in std_logic;
		 writein32, writein16, writein8: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	end component;

	signal enable: std_logic; -- to always enable registers
	signal ZeroReg: std_logic_vector(31 downto 0); -- 
	signal ZeroOut: std_logic_vector(31 downto 0);
	signal Zero_write: std_logic;
	signal a0_write, a1_write, a2_write, a3_write, a4_write, a5_write, a6_write, a7_write: std_logic;
	signal a0_out, a1_out, a2_out, a3_out, a4_out, a5_out, a6_out, a7_out: std_logic_vector(31 downto 0);
	signal Fail_read: std_logic_vector(31 downto 0);
begin
	--INITIALIZE SIGNALS--
	Zero_write <= '1';
	enable <= '0'; -- registers are always enabled
	ZeroReg <= X"00000000"; -- output of zero register is always 0
	Fail_read(31 downto 0) <= (others => 'Z');

 	--WRITE--
	a0_write <= '1' when ((WriteCmd = '1') and (WriteReg = "01010")) else '0';
	a1_write <= '1' when ((WriteCmd = '1') and (WriteReg = "01011")) else '0';
	a2_write <= '1' when ((WriteCmd = '1') and (WriteReg = "01100")) else '0';
	a3_write <= '1' when ((WriteCmd = '1') and (WriteReg = "01101")) else '0';
	a4_write <= '1' when ((WriteCmd = '1') and (WriteReg = "01110")) else '0';
	a5_write <= '1' when ((WriteCmd = '1') and (WriteReg = "01111")) else '0';
	a6_write <= '1' when ((WriteCmd = '1') and (WriteReg = "10000")) else '0';
	a7_write <= '1' when ((WriteCmd = '1') and (WriteReg = "10001")) else '0';
	
	--REGISTERS--
	Zero: register32 port map(ZeroReg, enable, enable, enable, Zero_write, Zero_write, Zero_write, ZeroOut);
	a0: register32 port map(WriteData, enable, enable, enable, a0_write, a0_write, a0_write, a0_out);
	a1: register32 port map(WriteData, enable, enable, enable, a1_write, a1_write, a1_write, a1_out);
	a2: register32 port map(WriteData, enable, enable, enable, a2_write, a2_write, a2_write, a2_out);
	a3: register32 port map(WriteData, enable, enable, enable, a3_write, a3_write, a3_write, a3_out);
	a4: register32 port map(WriteData, enable, enable, enable, a4_write, a4_write, a4_write, a4_out);
	a5: register32 port map(WriteData, enable, enable, enable, a5_write, a5_write, a5_write, a5_out);
	a6: register32 port map(WriteData, enable, enable, enable, a6_write, a6_write, a6_write, a6_out);
	a7: register32 port map(WriteData, enable, enable, enable, a7_write, a7_write, a7_write, a7_out);

	--READ--
	with ReadReg1 select
		ReadData1 <= ZeroOut when "00000", -- Zero reg # x0 = 00000
			     	a0_out when "01010",  -- a0 reg # x10 = 01010
				a1_out when "01011",  -- a1 reg # x11 = 01011
				a2_out when "01100",  -- a2 reg # x12 = 01100
				a3_out when "01101",  -- a3 reg # x13 = 01101
				a4_out when "01110",  -- a4 reg # x14 = 01110	
				a5_out when "01111",  -- a5 reg # x15 = 01111
				a6_out when "10000",  -- a6 reg # x16 = 10000
				a7_out when "10001",  -- a7 reg # x17 = 10001
				Fail_read when others;
	with ReadReg2 select
		ReadData2 <= ZeroOut when "00000", -- Zero reg #00000
			     	a0_out when "01010",  -- a0 reg # x10 = 01010
				a1_out when "01011",  -- a1 reg # x11 = 01011
				a2_out when "01100",  -- a2 reg # x12 = 01100
				a3_out when "01101",  -- a3 reg # x13 = 01101
				a4_out when "01110",  -- a4 reg # x14 = 01110	
				a5_out when "01111",  -- a5 reg # x15 = 01111
				a6_out when "10000",  -- a6 reg # x16 = 10000
				a7_out when "10001",  -- a7 reg # x17 = 10001
				Fail_read when others;

end remember;

----------------------------------------------------------------------------------------------------------------------------------------------------------------