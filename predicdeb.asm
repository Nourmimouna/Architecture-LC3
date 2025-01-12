.ORIG x3000            

MAIN:
        LD R0, TEST_VALUE1      ; charge TEST_VALUE1 dans R0
        LD R1, TEST_VALUE2      ; charge TEST_VALUE2 dans R1
        JSR PREDICT_OVERFLOW    ; appelle la routine de prédiction de débordement
        HALT                    ; termine le programme

PREDICT_OVERFLOW:
        ; extrait le bit de poids fort de R0
        JSR EXTRACT_MSB_SINGLE_BIT_8BITS1 
        ADD R4, R3, 0           ; sauvegarde la position MSB de R0 dans R4

        ; extrait le bit de poids fort de R1 
        JSR EXTRACT_MSB_SINGLE_BIT_8BITS2 
        ADD R5, R3, 0           ; sauvegarde la position MSB de R1 dans R5

        ; compare les bits MSB de R4 et R5 et met le résultat dans R2
        JSR COMPARE_BITS        
        RET                     

EXTRACT_MSB_SINGLE_BIT_8BITS1:
        ; charge le masque 0x80 dans R6
        AND R6, R6, 0           ; initialise R6 à 0
        LD R6, MASK_0x80        ; charge la valeur 0x80 dans R6

        ; applique un masque ET pour isoler le bit 7
        AND R3, R0, R6          ; R3 = R0 & 0x80 (isoler le bit de poids fort)

        ; décale à droite de 7 bits pour obtenir 1 ou 0
        BRz MSB1_IS_ZERO        ; si R3 est 0, le bit de poids fort est 0
        AND R3, R3, 0           ; met R3 à 0
        ADD R3, R3, 1           ; R3 = 1 (le bit de poids fort est 1)
        RET                     ; retourne à l'appelant

MSB1_IS_ZERO:
        AND R3, R3, #0          ; R3 = 0 (le bit de poids fort est 0)
        RET                     ; retourne à l'appelant

EXTRACT_MSB_SINGLE_BIT_8BITS2:
        ; charge le masque 0x80 dans R6 (réutilisation de R6)
        AND R6, R6, 0           ; initialiser R6 à 0
        LD R6, MASK_0x80        ; chargee la valeur 0x80 dans R6

        ; applique un masque ET pour isoler le bit 7
        AND R3, R1, R6          ; R3 = R1 & 0x80 (isoler le bit de poids fort)

        ; décale à droite de 7 bits pour obtenir 1 ou 0
        BRz MSB2_IS_ZERO        ; si R3 est 0, le bit de poids fort est 0
        AND R3, R3, 0           ; met R3 à 0
        ADD R3, R3, 1           ; R3 = 1 (le bit de poids fort est 1)
        RET                     ; retourne à l'appelant

MSB2_IS_ZERO:
        AND R3, R3, 0           ; R3 = 0 (le bit de poids fort est 0)
        RET                     ; retourne à l'appelant

COMPARE_BITS:
        ; Comparer R4 et R5 (vérifier s'ils sont égaux)
        NOT R3, R4             ; R3 = -R4 - 1
        ADD R3, R3, 1          ; R3 = -R4
        ADD R3, R3, R5         ; R3 = -R4 + R5, donne 0 si R4 = R5, sinon une valeur différente de 0

        ; si R3 est égal à 0, cela signifie que R4 et R5 sont égaux
        BRz BITS_ARE_EQUAL     ; si R3 = 0, sauter à BITS_ARE_EQUAL

        ; si on arrive ici, cela signifie que les bits sont différents, mettre 0 dans R2
        AND R2, R2, 0          ; met R2 à 0 (bits différents)
        RET                    ; retourne à l'appelant

BITS_ARE_EQUAL:
        ; si R4 et R5 sont égaux, vérifie si les deux bits sont égaux à 1 ou à 0
        AND R3, R4, R5         ; R3 = R4 & R5, donne 1 si les deux bits sont à 1, sinon 0

        ; si R3 est égal à 1, les deux bits sont à 1
        BRz BITS_ARE_ZERO      ; si R3 = 0, cela signifie que les deux bits sont à 0

        ; si on arrive ici, cela signifie que les deux bits sont égaux à 1, mettre 1 dans R2
        AND R2, R2, 0          ; réinitialise R2 à 0
        ADD R2, R2, 1          ; R2 = 1 (les deux bits sont à 1)
        RET                    ; retourne à l'appelant

BITS_ARE_ZERO:
        ; si on arrive ici, cela signifie que les deux bits sont égaux à 0
        AND R2, R2, 0          ; réinitialise R2 à 0
        ADD R2, R2, -1         ; R2 = -1 (les deux bits sont à 0)
        RET                    ; retourne à l'appelant

MASK_0x80:   .FILL xFF80       ; masque pour le bit de poids fort (0x80)
TEST_VALUE1: .FILL x0080       ; exemple de valeur 1
TEST_VALUE2: .FILL x0080       ; exemple de valeur 2
        .END                   ; fin du programme

