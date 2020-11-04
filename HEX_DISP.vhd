LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

-- Hexadecimal to 7 Segment Decoder for LED Display
--  1) when free held low, displays latched data
--  2) when free held high, constantly displays input (free-run)
--  3) data is latched on rising edge of CS

ENTITY HEX_DISP IS
  PORT( hex_val  : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        cs       : IN STD_LOGIC := '0';
        free     : IN STD_LOGIC := '0';
        resetn   : IN STD_LOGIC := '1';
        segments : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END HEX_DISP;

ARCHITECTURE a OF HEX_DISP IS
  SIGNAL latched_hex : STD_LOGIC_VECTOR(4 DOWNTO 0);
  SIGNAL hex_d       : STD_LOGIC_VECTOR(4 DOWNTO 0);

BEGIN

  PROCESS (resetn, cs)
  BEGIN
    IF (resetn = '0') THEN
      latched_hex <= "00000";
    ELSIF ( RISING_EDGE(cs) ) THEN
      latched_hex <= hex_val;
    END IF;
  END PROCESS;
  
  WITH free SELECT
    hex_d  <= latched_hex WHEN '0',
              hex_val     WHEN '1';
           
  WITH hex_d SELECT
    segments <= "1000000" WHEN "00000",
                "1111001" WHEN "00001",
                "0100100" WHEN "00010",
                "0110000" WHEN "00011",
                "0011001" WHEN "00100",
                "0010010" WHEN "00101",
                "0000010" WHEN "00110",
                "1111000" WHEN "00111",
                "0000000" WHEN "01000",
                "0010000" WHEN "01001", 
                "0001000" WHEN "01010",
                "0000011" WHEN "01011", 
                "1000110" WHEN "01100", 
                "0100001" WHEN "01101", 
                "0000110" WHEN "01110", 
                "0001110" WHEN "01111",
					 "0000111" WHEN "10000",	-- t
					 "1001111" WHEN "10001",	-- I
					 "1000111" WHEN "10010",	-- L
					 "0001100" WHEN "10011",	-- P
					 "1000001" WHEN "10100",	-- U
					 "0010010" WHEN "10101",	-- S
					 "0001001" WHEN "10110",	-- H
					 "1010101" WHEN "10111",	-- W
					 "1111111" WHEN "11111",	-- NOTHING
                "0111111" WHEN OTHERS;
END a;

