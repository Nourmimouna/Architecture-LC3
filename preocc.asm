    .ORIG x3000

; programme de test pour INDEX
MAIN:
    LEA R1, chaine        ; charge l'adresse de la chaîne dans R1
    LD R2, caract         ; charge le caractère souhaité (par exemple 'L') dans R2
    JSR INDEX             ; appelle la routine INDEX
    HALT                  ; arrête le programme une fois la routine terminée

; routine INDEX
INDEX:
    AND R0, R0, 0         ; initialise R0 à 0 (adresse de la première occurrence ou 0 si non trouvé)
loop:
    LDR R3, R1, 0         ; charge le caractère pointé par R1 dans R3
    BRz INDEX_END         ; si le caractère est nul, fin de la chaîne
    NOT R4, R3            ; inverse les bits de R2 (caractère cible)
    ADD R4, R4, 1         ; comparaison par complément de R2 (méthode pour vérifier égalité)
    ADD R4, R4, R2        ; compare R3 et R2
    BRz INDEX_F           ; si égal, adresse trouvée
    ADD R1, R1, 1         ; passe au caractère suivant
    BR loop               ; répète la boucle
INDEX_F:
    ADD R0, R1, 0         ; stocke l'adresse actuelle dans R0
INDEX_END:
    RET                   ; retourne à l'appelant

; chaîne de test
chaine: .STRINGZ "HELLO"

; caractère souhaité (code ASCII de 'L')
caract: .FILL x004C

    .END                   
    
