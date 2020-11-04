; InstructionDisplayTest.asm

ORG 0

	; Get and store the switch values
Push1:
	LOAD DisplayP
	OUT Hex5
	LOAD DisplayU
	OUT Hex4
	LOAD DisplayS
	OUT Hex3
	LOAD DisplayH
	OUT Hex2
	LOADI 31
	OUT Hex1
	LOADI 1
	OUT Hex0
	
	IN Switches
	JPOS Tilt
	
	JUMP Push1
	
Tilt:
	LOAD DisplayT
	OUT Hex5
	LOAD DisplayI
	OUT Hex4
	LOAD DisplayL
	OUT Hex3
	LOAD DisplayT
	OUT Hex2
	LOADI 31
	OUT Hex1
	LOADI 31
	OUT Hex0
	
	IN Switches
	AND Bit2
	JPOS Switch
	
	JUMP Tilt

Switch:
	LOAD DisplayS
	OUT Hex5
	LOAD DisplayW
	OUT Hex4
	LOADI 31
	OUT Hex3
	LOADI 4
	OUT Hex2
	LOADI 31
	OUT Hex1
	LOADI 31
	OUT Hex0
	
	IN Switches
	JZERO Push1
	
	JUMP Switch

; Variables
DisplayP:	 DW &B10011
DisplayU:	 DW &B10100
DisplayS:	 DW &B10101
DisplayH:	 DW &B10110
DisplayT:	 DW &B10000
DisplayI:	 DW &B10001
DisplayL:	 DW &B10010
DisplayW:	 DW &B10111
Bit2:		 DW &B10




; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
Hex2:      EQU 006
Hex3:      EQU 007
Hex4:      EQU 008
Hex5:      EQU 009
