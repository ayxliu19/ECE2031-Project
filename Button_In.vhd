-- Button_In.VHD (a peripheral module for SCOMP)
-- This module reads digital input from button1 Directly

LIBRARY IEEE;
LIBRARY LPM;

USE IEEE.STD_LOGIC_1164.ALL;
USE LPM.LPM_COMPONENTS.ALL;

ENTITY Button_In IS
  PORT(
    CS          : IN    STD_LOGIC;
    DI          : IN    STD_LOGIC_VECTOR(15 DOWNTO 0);
    IO_DATA     : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END Button_In;

ARCHITECTURE a OF Button_In IS
  SIGNAL B_DI : STD_LOGIC_VECTOR(15 DOWNTO 0);

  BEGIN
    -- Use LPM function to create bidirectional I/O data bus
    IO_BUS: lpm_bustri
    GENERIC MAP (
      lpm_width => 16
    )
    PORT MAP (
      data     => B_DI,
      enabledt => CS,
      tridata  => IO_DATA
    );

    PROCESS
    BEGIN
      WAIT UNTIL RISING_EDGE(CS);
      B_DI <= DI; -- sample the input on the rising edge of CS
    END PROCESS;

END a;
