.model small
.stack 100h
.data
  strParola db "Inserire una parola: $"
  strLettera db "Inserire la lettera da cercare: $"
  strNonTrovato db "Non Trovata$"
  strTrovato db "Trovata$"
  parola db 255, 0 ;buffer parola
  carattere db 0 ;buffer lettera
  si_inizio dw 0 ;registro si per l'inizio della parola
  di_carattere db 0 ;registro di per il carattere da cercare
  
.code
inizio:
  mov ax, @data
  mov ds, ax

  mov ah, 09h ;output stringa
  lea dx, strParola ;caricamento indirizzo stringa
  int 21h ;caricato in dx
  
  ;input parola iniziale
  lea dx, parola ;caricamento indirizzo parola
  mov ah, 0ah ;attesa input
  int 21h ;caricato in dx
  
  ;rimuovi il terminatore di stringa aggiunto dall'input
  mov si, offset parola + 1
  mov cl, [si]
  mov byte ptr [si], 0
  mov si_inizio, offset parola + 2 ;salva l'inizio della parola in si

  mov ah, 09h ;output stringa
  lea dx, strLettera ;caricamento indirizzo stringa
  int 21h ;caricato in dx
  
  ;input carattere da cercare
  lea dx, carattere ;caricamento indirizzo carattere
  mov ah, 01h ;attesa input
  int 21h ;caricato in dx

  ;cerca la lettera nella parola
  mov si, si_inizio ;inizializza si con l'inizio della parola
  mov di, offset carattere ;inizializza di con il carattere da cercare
  
ricerca:
  cmp byte ptr [si], 0 ;controlla se si è raggiunto il terminatore della stringa
  je  nontrovato ;se sì, la lettera non è stata trovata

  cmp byte ptr [di], 0 ;controlla se si è raggiunto il terminatore del carattere
  je  nontrovato ;se sì, la lettera non è stata trovata

  cmp al, [si] ;confronta il carattere con il carattere corrente nella parola
  je  trovato ;se sono uguali, la lettera è stata trovata

  inc si ;passa al prossimo carattere nella parola
  inc di ;passa al prossimo carattere nel carattere
  jmp ricerca ;ripeti il ciclo di ricerca

trovato:
  lea dx, strTrovato ;output stringa trovato
  mov ah, 09h ;output stringa
  int 21h ;caricato in dx
  jmp fine ;salta al termine il programma

nontrovato:
  lea dx, strNonTrovato ;output stringa non trovato
  mov ah, 09h ;output stringa
  int 21h ;caricato in dx
  jmp fine ;salta al termine il programma

fine:
  mov ah, 4ch ;ritorna il controllo al sistema operativo
  int 21h ;caricato in dx
end inizio ;termine del programma