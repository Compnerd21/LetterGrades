TITLE LetterGrades

INCLUDE c:\irvine\irvine32.inc
INCLUDELIB c:\irvine\irvine32.lib
INCLUDELIB c:\masm32\lib\user32.lib
INCLUDELIB c:\masm32\lib\kernel32.lib

.data
incStr BYTE "INCORRECT INPUT " ;Added to the Front of Input String When a Re-Entry is Neccessary
inputStr BYTE "Please enter # of Grades from 0 - 20: ",0
incNumStr BYTE "INCORRECT INPUT" ;Added to the Front of Input String When a Re-Entry is Neccessary
inGradeStr BYTE "Please Enter Grade #",0
count DWORD 0 ;Current # of Grade Input
inp BYTE ": ",0
let DWORD ?,0 ;Current Letter Grade Thats Being Checked
grades SDWORD ? ;Current Grade That is Being Checked
tot DWORD ? ;Total Number of Grades
last BYTE " Letter Grades Calculated",0
gradStr BYTE " This Represents A Grade Of: ",0


.code

;The Main Procedure is used to get the various inputs such as number of grades, and the grades themselves,
;and is responsible for checking their validity and looping until it is valid
main PROC
mov EDX, OFFSET inputStr
I1: call WriteString ;loops until the number of grades is a valid number between 0 and 20
call ReadInt
call Crlf
mov grades, EAX
mov EBX, +20
call Range
mov EDX, OFFSET incStr
CMP EAX, -1
JE I1
mov tot, EAX
mov ECX, tot
inGrad: inc count ;Loops through the various Grade Inputs and Outputs their Respective Letter Representations
mov EDX, OFFSET inGradeStr
I2: call WriteString ; The loop for Checking the Grade Inputs Validity
mov EAX, count
call WriteInt
mov EDX, OFFSET inp
call WriteString
call ReadInt
call Crlf
CMP EAX, 0
JE fin ;jump past loop for 0, since there are no entries
mov EBX, +100
call Range

mov EDX, OFFSET incNumStr
CMP EAX, -1
JE I2
call Letters
loop inGrad ;loop continues for n times, where n is the number of grades, Except when n=0
fin: mov EDX, OFFSET last
mov EAX, tot
call WriteInt
call WriteString
exit
main endP

;Range Uses The EAX and EBX Registers for determining if a number is in range, EAX is the input, and EBX is the Max,
;If the number is between 0 and Max, it leaves everything, otherwise it makes EAX = -1
Range PROC
push EBX

CMP EAX, 0
JL wrong
CMP EAX, EBX
JG wrong
jmp ok
wrong: mov EAX, -1
ok: 
pop EBX
RET
Range endP
; Letters Will take the Value in EAX, and Compare it with the various Grade Standards Going from F to A, and will jump
;down to found when it is less than the low value of the next letter. Then calls WriteString to print Letter in let
;(the Plus grades are stored reverse so that they output right, i assume its because of little endian)
Letters PROC
push EAX
mov edx, OFFSET let
mov let, "F" ;Series of if-else representation, where it funnels from F to A until it is less than next limit
CMP EAX, +60
JL found
mov let, "D"
CMP EAX, +65
JL found
mov let,"+D"
CMP EAX, +70
JL found
mov let, "C"
CMP EAX, 75
JL found
mov let, "+C"
CMP EAX, 80
JL found
mov let, "B"
CMP EAX, 85
JL found
mov let, "+B"
CMP EAX, 90
JL found
mov let, "A"
found: mov EDX, OFFSET gradStr
call WriteString
mov EDX, OFFSET let
call WriteString
call Crlf
pop EAX
RET
Letters endP



exit
END MAIN 