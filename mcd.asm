;ESERCIZIO 5
;ricordati di fare il caso in cui i numeri sono uguali
.model small
.stack 100
.data
    numero1 db ?
    numero2 db ?
    msgstart db "Inserire un numero compreso tra 0 e 9: $"
    msgfinish db "L'MCD tra i due numeri e': $"
    msgerrore db "Il valore non e' compreso tra 0 e 9! $"
    msglog db "ciaofra $"
    valore1 db 0
    valore2 db 9
    strnewline db 13,10,"$"
    contatore db 0
.code
    inizio:
        mov ax, @data ;dichiarazione data segment
        mov ds, ax
        
    inputprimonumero:
        ;stampo il messaggio iniziale di input numero 1
        mov ah, 09h
        lea dx, msgstart
        int 21h
        
        ;input del primo numero
        mov ah,01h
        int 21h
        sub al,30h
        mov cl,al
        
        ;dichiaro una nuova riga
        mov ah,09h
        mov dx,offset strnewline
        int 21h
        
    inputsecondonumero:
        ;stampo il messaggio iniziale di input numero 2
        mov ah, 09h
        lea dx, msgstart
        int 21h
        
        ;input del primo numero
        mov ah,01h
        int 21h
        sub al,30h
        mov bl,al
        
        ;dichiaro una nuova riga
        mov ah,09
        mov dx,offset strnewline
        int 21h
    verifica:
        mov al,cl
        ;su al ho il primo numero e su bl ho il secondo numero
        mov cl,valore1
        mov dl,valore2
        ;su cl e dl ho i valori di verifica
        cmp al,cl
        jl errore
        
        cmp al,dl
        jg errore
        
        cmp bl,cl
        jl errore 
        
        cmp bl,dl
        jg errore
        
        jmp verificato
        
    errore:
        ;stampo il messaggio di errore (valore non compreso)
        mov ah, 09
        lea dx, msgerrore
        int 21h
        jmp fine
    verificato:
        ;controlla quale dei due numeri ? il pi? grande e se sono uguali
        cmp al,bl
        jl numeropiccolo
        cmp al,bl
        jg numerogrande
        
        mov cl,contatore
        
        jmp uguale

        
    numeropiccolo:
        ;il secondo numero e piu grande
        mov dl, bl
        mov bl, al
        mov al, dl
    numerogrande:   
        sub al,bl
        inc cl
        cmp al,bl
        jg numerogrande
        je restozero
        
        jmp particolare
        
    restozero:
        mov cl,al
        
        jmp fattoincapriola
        
    particolare:
        mov dl,2
        cmp al,dl
        je particolaredue
        mov dl,3
        cmp al,dl
        je particolaretre
        
        mov cl,al
        mov cl, 1
        jmp fattoincapriola
    particolaredue:
        mov cl,2
        jmp fattoincapriola
    particolaretre:
        mov cl,3
        jmp fattoincapriola    
    fattoincapriola:
        ;dichiaro una nuova riga
        mov ah,09
        mov dx,offset strnewline
        int 21h
        
        ;se il numero ? uguale l'mcd sar? il numero stesso
        mov ah, 09h
        lea dx, msgfinish
        int 21h
     
        mov dl, cl
        add dl, '0'        ; Converte il risultato in carattere ASCII
        mov ah, 02h        ; Funzione di output del BIOS per stampare un singolo carattere
        int 21h
     
        jmp fine
        
   uguale:
        ;se il numero ? uguale l'mcd sar? il numero stesso
        mov ah, 09h
        lea dx, msgfinish
        int 21h
        
        ;stampo l'mcd
        mov dl,al
        add dl,'0'
        mov ah,02h
        int 21h
        
        jmp fine
    fine:
        mov ah,4ch ;ritorna il controllo al sistema operativo
        int 21h 
  
    end inizio
