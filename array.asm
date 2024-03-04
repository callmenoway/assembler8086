.model small
.stack 100h
.data
    array db 1, 2, 3, 4, 5, 6, 7, 8 ;dichiaro l'array merdoso

.code
    main:
        mov ax, @data ;non te lo commento pk altrimenti accoltello qualcuno
        mov ds, ax

        mov cx, 8 ; lunghezza dell'array

        mov si, 0 ; indice di inizio dell'array
        sub cx, 1
        mov di, cx

    loop_inverso:
        mov al, array[si] ;scambia gli elementi all'indice si e di
        mov ah, array[di]
        mov array[si], ah
        mov array[di], al
        
        inc si
        dec di

        cmp si, di ;verifica se ? necessario continuare l'inversione
        jae stampailfra

        jmp loop_inverso;ripeti il ciclo

    stampailfra:
        mov cx, 8 ;stampa l'array invertito
        mov si, 0

    printastocazzodiloop:
        mov dl, array[si];stampa il numero corrente
        add dl, '0'  ;converti il numero in carattere ASCII
        mov ah, 02h
        int 21h

        ;incrementa l'indice
        inc si

        loop printastocazzodiloop ;verifica se ? necessario continuare la stampa (se sei frocio si)

    ;termina sta minchia di programma plz
    mov ah, 4ch
    int 21h

end main
