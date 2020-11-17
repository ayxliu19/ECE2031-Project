; Generating a square wave with IO peripheral 

ORG 0
Loop:
  ; Send the peripheral a value once at reset
  in Switches
  shift 2
  OUT  MusicGen
; Enter an infinite loop, showing that SCOMP
; doesn't need to do anything and the peripheral
; will continue to generate the square wave.
	jump Loop
	

; IO address constants
Switches:  		EQU &H000
sqGen:			EQU &H0F0
MusicGen:		EQU &H020

