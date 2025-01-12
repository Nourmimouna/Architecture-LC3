; Routine STRLEN

; R1 : adresse de début de la chaîne
; R0 : longueur de la chaîne

; Programme de test pour STRLEN
    .ORIG x3000

MAIN:
    LEA R1, STRING     ; charge l'adresse de la chaîne dans R1
    JSR STRLEN         ; appele la routine STRLEN
    HALT               ; arrête le programme une fois la routine terminée

; Routine STRLEN
STRLEN:
    AND R0, R0, 0     ; initialise R0 à 0 (compteur)
STRLEN_LOOP:
    LDR R2, R1, 0     ; charge le caractère pointé par R1 dans R2
    BRz STRLEN_END    ; si le caractère est nul, fin de la chaîne
    ADD R0, R0, 1     ; incrémente le compteur R0
    ADD R1, R1, 1     ; avancer à l'adresse du caractère suivant
    BR STRLEN_LOOP    ; répéte la boucle
STRLEN_END: RET

; Chaîne de test
STRING: .STRINGZ "Hello"

    .END               ; fin du programme
