    .ORIG x3000              

MAIN:
    LEA R1, source           ; charge l'adresse de la chaîne source dans R1
    LEA R2, destination      ; charge l'adresse de la chaîne destination dans R2
    LD R0, size              ; charge la taille de la copie dans R0
    JSR STRNCPY              ; appelle la routine strncpy
    HALT                     ; arrête le programme une fois la routine terminée

; routine STRNCPY
; R0 : nombre de caractères à copier
; R1 : adresse de début de la chaîne source
; R2 : adresse de début de la chaîne destination

STRNCPY:
    AND R3, R3, 0           ; initialise R3 à 0 (compteur)

loop:
    LDR R4, R1, 0           ; charge le caractère pointé par R1 dans R4
    STR R4, R2, 0           ; copie le caractère dans la destination
    BRz STRNCPY_FILL_ZERO   ; si le caractère est nul, remplit avec des zéros
    ADD R1, R1, 1           ; passe au caractère suivant dans la chaîne source
    ADD R2, R2, 1           ; passe au caractère suivant dans la chaîne destination
    ADD R3, R3, 1           ; incrémente le compteur

    ; comparer R3 (compteur) avec R0 (taille de la copie)
    NOT R5, R0              ; R5 = -R0-1 
    ADD R5, R5, 1           ; R5 = -R0
    ADD R5, R5, R3          ; 
    BRz STRNCPY_END         ; si R5 = 0, la copie est terminée (R3 = R0)

    BR loop                 ; répéte la boucle

STRNCPY_FILL_ZERO:
    STR R3, R2, 0           ; si fin de chaîne, remplit de zéro
    ADD R2, R2, 1           ; passe à la case suivante de la destination
    ADD R3, R3, 1           ; incrémente le compteur

    ; Comparer R3 (compteur) avec R0 (taille de la copie)
    NOT R5, R0              ; R5 = -R0-1
    ADD R5, R5, 1           ; R5 = -R0
    ADD R5, R5, R3          ; R5 = R3 - R0
    BRz STRNCPY_END         ; si R5 = 0, la copie est terminée (R3 = R0)

    BR loop                 ; répéte la boucle

STRNCPY_END:         RET                     

; chaînes de test
source:      .STRINGZ "HE"   
destination: .BLKW 6         
size:        .FILL x0004        ; nombre de caractères à copier

    .END                    

