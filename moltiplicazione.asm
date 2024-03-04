    ;programma per scimmie
    .model small
    .stack 100h
    .data
        numero1 db ?
        numero2 db ?
        risultato db ?
        check db 1
        strmsg1 db "inserisci il primo schiavo: $"
        strmsg2 db "inserisci il secondo schiavo: $"
        strnewline db 13,10,"$"
    .code
        main:
            mov ax, @data ;accoltello un marokkino
            mov ds, ax
            
            mov ah,09h
            lea dx,strmsg1
            int 21h
            
            mov ah,01h
            int 21h
            sub al,30h
            mov bl,al
            
            mov ah,09h
            mov dx,offset strnewline
            int 21h
            
            mov ah,09h
            lea dx,strmsg2
            int 21h
            
            mov ah,01h
            int 21h
            sub al,30h
            mov cl,al
            
            mov ah,09h
            mov dx,offset strnewline
            int 21h
            
            mov risultato,bl
        ciclo:
            cmp cl,check
            je print
            jg bigger
        bigger:
            add risultato,bl
            dec cl
            jmp ciclo
        print:
            
            mov dl, risultato ;stampa il cazzo di carlo
            add dl,'0'
            mov ah, 02h
            int 21h
            
            mov ah, 4ch ;perfavore chiudi il programma negro
            int 21h
        end main
