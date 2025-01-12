    .ORIG x3000              

MAIN:
    LEA R1, chaine1          ; charge l'adresse de la première chaîne dans R1
    LEA R2, chaine2          ; charge l'adresse de la deuxième chaîne dans R2
    JSR STRCMP               ; appelle la routine strcmp
    HALT                     ; arrêtee le programme une fois la routine terminée

; routine STRCMP
; R1 : adresse de la première chaîne
; R2 : adresse de la deuxième chaîne
; R0 : résultat de la comparaison : 
;      >0 si chaîne 1 > chaîne 2, 
;      0 si égales, 
;      <0 si chaîne 1 < chaîne 2

STRCMP:
    AND R0, R0, #0           ; initialise R0 à 0 
    
loop:
    LDR R3, R1, 0            ; charge le caractère de la première chaîne dans R3
    LDR R4, R2, 0            ; charge le caractère de la deuxième chaîne dans R4
    BRz STRCMP_END           ; si fin de chaîne 1, vérifier fin de chaîne 2
    
    ; Comparaison des caractères (R3 - R4)
    NOT R4, R4               ; inverse les bits de R4
    ADD R4, R4, #1           ; ajoute 1 à R4 pour obtenir le complément à 2
    ADD R5, R3, R4           ; R5 = R3 + (complément à 2 de R4)
    BRz STRCMP_EQUAL         ; si les caractères sont égaux, continue à comparer
    
    ; si les caractères sont différents
    ADD R0, R5, #0           ; R0 = R5 (résultat de la comparaison)
    BR STRCMP_END            ; termine la comparaison

STRCMP_EQUAL:
    ADD R1, R1, #1           ; passe au caractère suivant de la chaîne 1
    ADD R2, R2, #1           ; passe au caractère suivant de la chaîne 2
    BR loop                  ; répéte la boucle

STRCMP_END: RET                     

; chaînes de test
chaine1: .STRINGZ "IELLO"     
chaine2: .STRINGZ "HELLO"     

    .END                     

