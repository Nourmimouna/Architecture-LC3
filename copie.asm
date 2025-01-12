  .ORIG x3000             

MAIN:
    LEA R1, source           ; charge l'adresse de la chaîne source dans R1
    LEA R2, destination      ; charge l'adresse de la chaîne destination dans R2
    JSR STRCPY               ; appelle la routine strcpy
    HALT                     ; arrête le programme une fois la routine terminée

; routine STRCPY
; R1 : adresse de début de la chaîne source
; R2 : adresse de début de la chaîne destination

STRCPY:
    LDR R3, R1, #0           ; charge le caractère pointé par R1 (source) dans R3
    STR R3, R2, #0           ; stocke le caractère dans la destination
    BRz STRCPY_END           ; si c'est le caractère nul (fin de chaîne), termine
    ADD R1, R1, #1           ; passe au caractère suivant de la chaîne source
    ADD R2, R2, #1           ; passe au caractère suivant de la chaîne destination
    BR STRCPY                ; répéte la copie

STRCPY_END:
    RET                     

; chaînes de test
source:      .STRINGZ "HELLO"  
destination: .BLKW 6           ; réserve de l'espace pour la chaîne destination

    .END                       
