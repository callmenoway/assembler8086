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
        ;stampo il messaggio di errore (caso valore non compreso)
        mov ah, 09
        lea dx, msgerrore
        int 21h
        jmp fine
        
    verificato:
        ;verifico che il primo numero sia diverso dal secondo
        cmp al,bl
        je print ;nel caso in cui è uguale l'mcd sara' il medesimo
        jg maggiore
        jl minore
     
    maggiore:
        sub al,bl ;numero1 = numero1 - numero2
        mov cl,al ;sposto il risultato sul registro dedicato ai risultati (cl)
        jmp verificato ;ripeto il ciclo di verifica
    minore:
        sub bl,al ;numero2 = numero2 - numero1
        mov cl,bl ;sposto il risultato sul registro dedicato ai risultati (cl)
        jmp verificato
        
    print:
        
        ;dichiaro una nuova riga
        mov ah,09
        mov dx,offset strnewline
        int 21h
        
        ;print messaggio finale
        mov ah, 09h
        lea dx, msgfinish
        int 21h
     
        mov dl, cl
        add dl, '0' ;converto il risultato in carattere ascii
        mov ah, 02h
        int 21h
     
        jmp fine
        
    fine:
        mov ah,4ch ;ritorna il controllo al sistema operativo
        int 21h 
  
    end inizio
