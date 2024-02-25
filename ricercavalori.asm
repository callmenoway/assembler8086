.model small
.stack 100h

.data
	dim equ 10
	vet db dim dup (?)
	str_temp db "Inserire 10 valori:", 13, 10, "$"
	str_search db "Inserire valore da cercare:", 13, 10, "$"
	str_found db 13, 10,"Trovato :)$"
	str_lost db 13, 10,"Non trovato :($"
	nl db 13, 10, "$"


.code
	main:
		mov ax, @data
		mov ds, ax
		
		lea dx, str_temp
		mov ah, 09h
		int 21h
		
		xor cx, cx
		mov cl, dim
		lea bx, vet
		
		temp:
			mov ah, 01h
			int 21h
			sub al, 30
			mov [bx], al
			inc bx
			loop temp
		
		mov ah, 09h
		lea dx, nl
		int 21h
		
		;ricerca
		lea dx, str_fi
		mov ah, 09h
		int 21h
		mov ah, 09h
		lea dx, nl
		int 21h
		mov ah, 01
		int 21h
		sub al, 30
		xor ah, ah
		mov cx, 0
		mov cl, dim
		lea bx, vet
		
		search:
			cmp al, [bx]
			je found
			inc bx
			loop search 
			jmp lost
			
		lost:
			lea dx, str_lost
			mov ah, 09h
			int 21h

		found:
			lea dx, str_found
			mov ah, 09h
			int 21h
			jmp qu
			

		qu:
			mov ah, 4ch
			int 21h
	end main
