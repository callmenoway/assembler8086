.model small
.stack 100
.data
    msg1 db "GLORY$"
    msg2 db "NPT$"
    msg3 db 9 dup (?)
.code
    inizio:
        mov ax, @data ;dichiarazione data segment
        mov ds, ax

        lea di,msg3
        lea si,msg1
    ciclo:
        mov al, [si]
        cmp al, "$"
        jz ciclo2_i
        
        mov cl,[si]
        mov [di], cl
        
        inc si
        inc di
            
        jmp ciclo
        
    ciclo2_i:
        mov [di], ' '
        inc di
        
        lea si, msg2
    ciclo2:
        mov al, [si]
        cmp al, "$"
        jz cout
        
        mov cl,[si]
        mov [di], cl
        
        inc si
        inc di
   
        jmp ciclo2
        
    cout:
      mov [di], "$"
      mov ah, 09h ;output stringa
      lea dx, msg3 ;caricamento indirizzo stringa
      int 21h ;caricato in dx
                
        
    fine:
        mov ah,4ch ;ritorna il controllo al sistema operativo
        int 21h 
  
    end inizio
