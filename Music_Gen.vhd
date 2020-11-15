-- Music_Gen.VHD 
--
-- generates different chimes based on inputs

LIBRARY IEEE;
LIBRARY LPM;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE LPM.LPM_COMPONENTS.ALL;


ENTITY Music_Gen IS
	PORT(CLOCK,
		RESETN,
		CS       : IN STD_LOGIC;
		IO_DATA  : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
		SQ       : OUT STD_LOGIC;
		
		denom		: OUT STD_LOGIC_VECTOR (11 DOWNTO 0);
		numer		: OUT STD_LOGIC_VECTOR (23 DOWNTO 0);
		quotient	: IN STD_LOGIC_VECTOR (23 DOWNTO 0)
	);
END Music_Gen;


ARCHITECTURE a OF Music_Gen IS
	SIGNAL COUNT    : STD_LOGIC_VECTOR(23 DOWNTO 0);
	SIGNAL COMPARE  : STD_LOGIC_VECTOR(23 DOWNTO 0);
	SIGNAL D        : STD_LOGIC;
	
	-- figure out how to do integer and arithmetic with IO data	
	



	BEGIN

	PROCESS (CLOCK, RESETN, CS)
	BEGIN
	
		numer <= "010011000100101101000000"; -- (1/2) * 10MHz
		denom <= IO_Data;
	
		-- Create a register to store the data sent from SCOMP
		IF (RESETN = '0') THEN
			COMPARE <= "000000000000000000000000";
		ELSIF rising_edge(CS) THEN
			-- When written to, latch IO_DATA into the compare register.
			-- compare = (1/2) * clock_speed / IO_data
			COMPARE <= quotient;
			
			
		END IF;
		
		-- Create a counter, and a comparator that resets the counter when it matches
		-- the number sent from SCOMP
		IF (rising_edge(CLOCK)) THEN
			-- On compare match, reset counter and flip output.
			-- Count+1 is used so that the number sent from SCOMP
			-- is directly the number of intervals (instead of
			-- needing to subtract 1 on SCOMP's side).
			IF (COUNT+1) >= COMPARE THEN
				COUNT <= "000000000000000000000000";
				D <= not D;
			-- else, increment counter
			ELSE
				COUNT <= COUNT + 1;
			END IF;
		END IF;
	END PROCESS;

	SQ <= D;
	
END a;

