-- SQ_GEN.VHD (a peripheral module for SCOMP)
-- 2020.10.10
--
-- Generates a square wave with period dependant on value
-- sent from SCOMP.

LIBRARY IEEE;
LIBRARY LPM;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE LPM.LPM_COMPONENTS.ALL;


ENTITY SQ_GEN IS
	PORT(CLOCK,
		RESETN,
		CS       : IN STD_LOGIC;
		IO_DATA  : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		SQ       : OUT STD_LOGIC
	);
END SQ_GEN;


ARCHITECTURE a OF SQ_GEN IS
	SIGNAL COUNT    : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL COMPARE  : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL D        : STD_LOGIC;

	BEGIN

	PROCESS (CLOCK, RESETN, CS)
	BEGIN
	
		-- Create a register to store the data sent from SCOMP
		IF (RESETN = '0') THEN
			COMPARE <= "0000";
		ELSIF rising_edge(CS) THEN
			-- When written to, latch IO_DATA into the compare register.
			COMPARE <= IO_DATA(3 DOWNTO 0);
		END IF;
		
		-- Create a counter, and a comparator that resets the counter when it matches
		-- the number sent from SCOMP
		IF (rising_edge(CLOCK)) THEN
			-- On compare match, reset counter and flip output.
			-- Count+1 is used so that the number sent from SCOMP
			-- is directly the number of intervals (instead of
			-- needing to subtract 1 on SCOMP's side).
			IF (COUNT+1) >= COMPARE THEN
				COUNT <= "0000";
				D <= not D;
			-- else, increment counter
			ELSE
				COUNT <= COUNT + 1;
			END IF;
		END IF;
	END PROCESS;

	SQ <= D;
	
END a;

