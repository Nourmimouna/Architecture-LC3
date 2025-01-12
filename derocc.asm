    .ORIG x3000              

MAIN:
    LEA R1, chaine           ; charge l'adresse de la chaîne "HELLO" dans R1
    LD R2, caract            ; charge le caractère recherché ('L') dans R2
    JSR RINDEX               ; appelle la routine RINDEX
    HALT                     ; arrête le programme une fois la routine terminée

; routine RINDEX
; R1 : adresse de début de la chaîne
; R2 : caractère recherché
; R0 : adresse de la dernière occurrence

RINDEX:
    AND R0, R0, 0            ; initialise R0 à 0

loop:
    LDR R3, R1, 0            ; charge le caractère pointé par R1 dans R3
    BRz RINDEX_END           ; si le caractère est nul (fin de chaîne), termine
    NOT R4, R2               ; inverse les bits de R2 (caractère recherché)
    ADD R4, R4, #1           ; additionne 1 pour préparer la soustraction
    ADD R4, R3, R4           ; soustrait R2 de R3 (R3 - R2)
    BRz RINDEX_C             ; si égal (résultat de la soustraction est 0), mettre à jour R0
    ADD R1, R1, #1           ; passe au caractère suivant
    BR loop                  ; répéte la boucle

RINDEX_C:
    ADD R0, R1, #0           ; met à jour l'adresse dans R0 (dernière occurrence trouvée)
    ADD R1, R1, #1           ; passe au caractère suivant après une correspondance
    BR loop                  ; continue la boucle

RINDEX_END: RET                      

; chaîne de test
chaine: .STRINGZ "HELLO"     

; Caractère recherché (code ASCII de 'L')
caract: .FILL x004C          

    .END                     

