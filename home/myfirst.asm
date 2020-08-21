	BITS 16
start:
	mov ax,07C0h
	add ax,288
	mov ss,ax	;stack space
	mov sp,4096
	
	mov ax, 07C0h
	mov ds,ax	;ds is datasegment register
	
	mov si, text_string ;put string position into SI
	call print_string
	jmp $; infinite loop
	
	text_string db 'Hello!, A basic OS, that only has a bootsector that just displays this string :)- Vineet', 0
	
print_string:	;Routine:output string in SI to screen
	mov ah,0Eh ;we put 0Eh into the AH register (the upper byte of AX)
.repeat:
	lodsb	;get byte from the location pointed by 'si' and store it in the lower byte of AX
	cmp al, 0 ;al is lower byte of AX register
	je .done ;if char is zero , end of string
	int 10h	;interrupt our code and go to bios, which reads the value in the ah register. 0Eh in ah register means, print char in al to screen
	jmp .repeat
.done:
	ret
	
	times 510-($-$$) db 0 ; pad remaining of boot sector with 0s
	dw 0xAA55
