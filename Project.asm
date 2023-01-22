; Mahdi Moghadasi			SOEN 228 Section SS	With Dr. Fancott
;a simple program that gets 2 numbers and returns quotient and remainder


section .data 

mahdi 	db 32
mahdi1  db 11                    ;decimal numbers in this order (Divident, Divisor)

errormsg db  'Division is undifined.',0xa ;our string-Message printed if the user have zero as the divisor
len equ $ - errormsg                      ;length of our string


section .bss                              ; reserving one byte of data to store the values of remainder and qotient in memory
      int1: resb 1
      int2: resb 1


section .text
            global _start    ; declared for linker(ld)
           
_start:                      ;entry point for the linker

           mov eax,0         ; Setting eax to zero
           mov ebx,0 	     ; Setting ebx to zero
           mov ecx,0         ;initialize the loop counter
           mov bl, [mahdi]   ; moving the divident to register bl
           mov al, [mahdi1]  ; moving the divisor to register al
  
 zero:
	   cmp eax,0     ; comparing to see if divisor is zero 
	   je condition1 ; jumping to condition1 if the divisor is zero
	   jmp continue2 ; Otherwise(else) jumping unconditionally to continue2

condition1: 
	   
	   mov edx, len        ;error message length
	   mov ecx, errormsg   ;errormsg to write (Division is undifined.)
	   mov ebx,1           ;file descriptor (stdout)
 	   mov eax,4	       ;system call number (sys_write)
	   int 0x80	       ;call kernel
	   mov eax,1	       ;system call number (sys_exit)
	   int 0x80	       ;call kernel

	
continue2:
              cmp ebx, 0       ;comparing the divident value to zero
              jge condition2   ;jumping to condition2 if the value is equal or greater than zero
              jmp final	       ;Otherwise(else) jumping unconditionally to final
condition2: 
              cmp bl,[mahdi1] ;comparing the divident with the value of divisor
	      jge inst	       ;jumping to inst(instruction) if the divident is greater than or equal to divisor
	      jmp final	       ;jumping to final unconditionally if the previous jump (jge) is not met.(else statement)



inst:      
             sub ebx, eax      ;subtracting the value of register eax(holding divisor in first iteration) from register ebx (holding divedent in first iteration) and saving it in the register ebx
             inc ecx	       ;incrementing the counter in order to get the number of iteration for our loop (quotient)
             jmp continue2     ;jumping to continue2 label again to implement the loop until the control flow passes(jump over) the inst lable when the condition of our if statements become false.

final:

	      
	      mov eax, ecx ; moving the quotient of divison from the counter register to the eax general register.

              mov [int1], ebx  ; storing remainder in memory location int1
              mov [int2], ecx  ; storing quotient in memory location int2
  	      mov dl, [int1]        ; checking if the right value is stored in memory 
              mov bl, [int2]   ; verifying if the right value is stored in memory


End:

mov eax,1 ; The system call for exit (sys_exit) 
mov ebx,0 ; Exit with return code of 0 (no error) 
int 80h   ; call kernel
