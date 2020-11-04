; Create a 50% duty cycle at 1 Hz and display it on the 
; decimal point of first 7-segment display

Org 0

; Light decimal point LED
High:
	LOADI &B000001
	OUT DPs
	LOADI 0
	JUMP HighWaste

; waste ~0.5 seconds (25*(2^16))
HighWaste:
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 1
	JZERO Low
	JUMP HighWaste
	
; turn decimal point LED off
Low:
	LOADI 0
	OUT DPs
	JUMP LowWaste
	
; wastes ~0.5 seconds (25*(2^16))
LowWaste:
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 0
	ADDI 1
	JZERO High
	JUMP LowWaste
	
; IO address constants
DPs:       EQU &H0E0