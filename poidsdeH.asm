    .ORIG x3000              

MAIN:
    LEA R1, test_value       ; charge l'adresse de la valeur à tester dans R1
    AND R0, R0, 0            ; initialise R0 à 0 (compteur de bits à 1)
    LDR R2, R1, 0            ; charge la première valeur (entier) dans R2
    
    ; Début du calcul du poids de Hamming
    JSR HAMMING_WEIGHT       ; appelle la routine pour calculer le poids de Hamming
    HALT                     ; termine le programme

; Routine HAMMING_WEIGHT
HAMMING_WEIGHT:
    ; tant que R2 n'est pas nul, on continue à analyser les bits
HAMMING_LOOP:
    BRz HAMMING_END          ; si R2 est nul, termine
    AND R3, R2, 1            ; extrait le bit de poids faible de R2 (R3 = R2 & 0x0001)
    BRz SKIP_INCREMENT       ; si le bit est 0, saute l'incrément

    ; si le bit extrait est 1, incrémente le compteur
    ADD R0, R0, 1           ; incrémente le compteur (R0)
    
SKIP_INCREMENT:
    ADD R2, R2, R2           ; décale R2 à gauche (passer au bit suivant)
    BR HAMMING_LOOP          ; répéte la boucle

HAMMING_END:
    RET                      ; retourne à l'appelant

; Test
test_value:  .FILL 11100  
    
    .END                     

