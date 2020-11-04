; tests the decimal displays on the 7-segment displays
; Collection of subroutines and other useful code for
; interacting with the ADXL345 accelerometer

ORG 0
 
DPLoop:
    LOADI  &B101010
    OUT    DPs
    LOADI  2
    CALL   DelayAC
    LOADI  &B010101
    OUT    DPs
    LOADI  3
    CALL   DelayAC
    JUMP   DPLoop

DelayAC:
	STORE  DelayTime   ; Save the desired delay
	OUT    Timer       ; Reset the timer
WaitingLoop:
	IN     Timer       ; Get the current timer value
	SUB    DelayTime
	JNEG   WaitingLoop ; Repeat until timer = delay value
	RETURN
DelayTime: DW 0

; IO address constants
Timer:     EQU &H002
DPs:       EQU &H0E0
