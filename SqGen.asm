; Generating a square wave with IO peripheral 

ORG 0
  ; Send the peripheral a value once at reset
  IN   Switches
  OUT  SqGen
; Enter an infinite loop, showing that SCOMP
; doesn't need to do anything and the peripheral
; will continue to generate the square wave.
Here: JUMP Here

; IO address constants
Switches:  EQU &H000
SqGen:		EQU &H0F0