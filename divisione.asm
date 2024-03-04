.model small
.stack 100h
.data
    numero1 db ?
    numero2 db ?
    risultato db 0
    check db 0
    strmsg1 db "inserisci il primo nuero: $"
    strmsg2 db "sei un negro di merda: $"
    strnewline db 13,10,"$"

.code
main:
    mov ax, @data
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
    
    mov ah,09
    mov dx,offset strnewline
    int 21h
    
    mov dl, check   ; Counter per il risultato

    mov risultato, dl ; Inizializza il risultato con 0
    
divisione:
    cmp bl,cl          ; Controlla se il dividendo ? minore del divisore
    jl print_result     ; Se s?, esci dal ciclo

    sub bl,cl          ; Sottrae il divisore dal dividendo
    inc risultato       ; Incrementa il risultato
    
    jmp divisione       ; Ripeti il ciclo di divisione

print_result:
    mov dl, risultato  ; Carica il risultato da stampare
    add dl, '0'        ; Converte il risultato in carattere ASCII
    mov ah, 02h        ; Funzione di output del BIOS per stampare un singolo carattere
    int 21h

    mov ah, 4ch        ; Termina il programma
    int 21h
end main
