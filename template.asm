TITLE Discriminant Calculator

INCLUDE Irvine32.inc

.data
a_factor REAL8 0.0
b_factor REAL8 0.0
c_factor REAL8 0.0
D_factor REAL8 0.0
Root1 REAL8 0.0
Root2 REAL8 0.0
Rootzero REAL8 0.0
RealPart REAL8 0.0
ImagPart REAL8 0.0
Const2 REAL8 2.0
Const4 REAL8 4.0
title1 BYTE "**Discriminant Calculation**",0
str1 BYTE "Give the Coefficients a,b,c : ",0
zero0 BYTE "The first Coefficient cannot be 0",0
msg1 BYTE "The discriminant's value is: ",0
r1 BYTE "The first root is: ",0
r2 BYTE "The second root is: ",0
rzero BYTE "The unique root is: ",0
negroot BYTE "The roots are complex",0
;For the negative discriminant, we will occur complex numbers:
plusI BYTE " + ",0
minusI BYTE " - ",0
iChar BYTE "i",0
.code

main PROC

finit
mov edx,OFFSET title1
call WriteString
call Crlf
mov edx,OFFSET str1
call WriteString
call ReadFloat
fstp a_factor
fldz ;0 placement at the top of the stack
fld a_factor
ftst
fnstsw ax
sahf
jne NOTZERO1
mov edx,OFFSET zero0
call WriteString
exit
NOTZERO1:
fstp st(0)
fstp st(1)
call ReadFloat
fstp b_factor
call ReadFloat
fstp c_factor

fld b_factor
fmul b_factor 
fld a_factor
fld c_factor
fmul
fld Const4
fmul
fsubp st(1),st(0)
fst D_factor
mov edx,OFFSET msg1
call WriteString
call WriteFloat
call Crlf

fldz
fld D_factor
ftst
fnstsw ax
sahf
jb NEGATIVE
je ZERO
jmp NOTZERO2

ZERO:
fld b_factor
fchs
fld Const2
fmul a_factor
fdivp st(1),st(0)
fst Rootzero
mov edx,OFFSET rzero
call WriteString
call WriteFloat
call Crlf
exit
NEGATIVE:
fstp st(0)
fstp st(0)
;Real part = -b / (2a)
fld b_factor
fchs
fld Const2
fmul a_factor
fdivp st(1),st(0)
fstp RealPart
;Imaginary part = sqrt(-D) / (2a)
fld D_factor
fchs
fsqrt
fld Const2
fmul a_factor
fdivp st(1),st(0)
fstp ImagPart
mov edx,OFFSET negroot
call WriteString
call Crlf
;First complex root
mov edx,OFFSET r1
call WriteString
fld RealPart
call WriteFloat
fstp st(0)
mov edx,OFFSET plusI
call WriteString
fld ImagPart
call WriteFloat
fstp st(0)
mov edx,OFFSET iChar
call WriteString
call Crlf
; Second complex root
mov edx,OFFSET r2
call WriteString
fld RealPart
call WriteFloat
fstp st(0)
mov edx,OFFSET minusI
call WriteString
fld ImagPart
call WriteFloat
fstp st(0)
mov edx,OFFSET iChar
call WriteString
call Crlf
exit
NOTZERO2:
;First root not equal to 0.
fld b_factor
fchs 
fld D_factor
fsqrt 
faddp st(1),st(0)
fld Const2
fmul a_factor
fdivp st(1),st(0)
fst Root1
mov edx,OFFSET r1
call WriteString
call WriteFloat
call Crlf
;Second root not equal to 0.
fld b_factor
fchs 
fld D_factor
fsqrt 
fsubp st(1),st(0)
fld Const2
fmul a_factor
fdivp st(1),st(0)
fst Root2
mov edx,OFFSET r2
call WriteString
call WriteFloat
call Crlf
exit
main ENDP
END main
