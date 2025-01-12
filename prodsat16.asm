; programme de multiplication saturée

; R1 = multiplicande, R2 = multiplicateur
; résultat : R0 = produit saturé

	.ORIG x3000

MAIN:
    AND R0, R0, 0      ; 
    AND R3, R3, 0      ; R3 = 0 (compteurde bits)
    LD R3, ITERATIONS     ; R3 = 16, on va multiplier pendant 16 itérations
    LD R5, MAX_VALUE   ; charge 0xFFFF dans R5 pour la saturation

    ; initialisation des registres R1 et R2
    LD R1, MULTIPLICANDE   
    LD R2, MULTIPLICATEUR 

MULT_LOOP:
    ; vérifie si le bit de poids faible de R2 est 1
    AND R4, R2, 1      ; R4 = R2 & 1 (bit le plus faible de R2)
    BRz SKIP_ADD        ; si R4 = 0, ne pas ajouter le multiplicande

    ; ajoute R1 à R0 si le bit est 1
    ADD R0, R0, R1      ; R0 = R0 + R1

    ; vérifie la saturation : si R0 dépasse 16 bits, met R0 à 0xFFFF
    ; si R0 < 0, met R0 à 0x0000
    BRn SATURATE_MIN     ; si R0 < 0, va à la saturation minimale
    ADD R6, R0, 0       ; copie R0 dans R6
    BRzp CONTINUE_LOOP   ; si R0 >= 0, vérifie si R0 <= 0xFFFF
    SATURATE_MAX:
    ADD R0, R5, 0      ; R0 = 0xFFFF (saturation maximum)
    BR CONTINUE_LOOP

SATURATE_MIN:
    AND R0, R0, 0      ; sature à 0
    BR CONTINUE_LOOP

SKIP_ADD:
    ; décale R1 (multiplicande) à gauche et R2 (multiplicateur) à droite
    ADD R1, R1, R1      ; R1 = R1 << 1
    ADD R2, R2, R2      ; R2 = R2 >> 1

    ; décrémente le compteur de bits
    ADD R3, R3, -1
    BRp MULT_LOOP        ; si R3 > 0, recommence la boucle

    ; Fin de programme
    HALT

CONTINUE_LOOP:
    BR MULT_LOOP         ; fin de l'itération, continue

; données pour saturation
MAX_VALUE: .FILL xFFFF

; données d'initialisation
MULTIPLICANDE: .FILL x0012   ; exemple de multiplicande (0x12)
MULTIPLICATEUR: .FILL x0034  ; exemple de multiplicateur (0x34)
ITERATIONS: .FILL x0016  ;
	.END

