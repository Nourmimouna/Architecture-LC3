
# Projet LC3 - Simulateur de Processeur (Logisim)

# Projet LC3 - Simulateur de Processeur (Logisim)

Ce projet implémente un processeur **LC3** dans **Logisim**, incluant toutes les instructions LC3 sauf **JSR** et **JSSR** (encore non implémentées). Un ajout particulier dans ce projet est l'**instruction de bit scan**, qui permet d'analyser les bits dans un registre.


## 📂 Structure du projet

- **`lc-3.circ`** : Fichier principal du processeur LC3 construit sous Logisim.
- **`programs/`** : Programmes LC3 au format assembleur.
- **`Architecture_LC3/`** : Documentation technique expliquant la conception des composants, avec des schémas et explications.

### 📜 Instructions supportées
Le processeur supporte l'ensemble des instructions LC3 classiques ainsi que l'instruction BitScan : BSF- bit scan forward , BSB - bit scan backwards.

Le tableau détaillé de toutes les instructions LC-3, y compris les nouvelles instructions **BSF** et **BSB** :

| **Instruction**        | **Action**                                      | **NZP** | **Opcode** | **Arguments**                          | **Format binaire**                  |  
|-------------------------|------------------------------------------------|---------|------------|----------------------------------------|-------------------------------------|  
| **NOT DR, SR**          | `DR ← NOT SR`                                  | *       | `1001`     | `DR, SR`                               | `1001 DR SR 111111`                 |  
| **ADD DR, SR1, SR2**    | `DR ← SR1 + SR2`                               | *       | `0001`     | `DR, SR1, SR2`                         | `0001 DR SR1 000 SR2`               |  
| **ADD DR, SR1, Imm5**   | `DR ← SR1 + SEXT(Imm5)`                        | *       | `0001`     | `DR, SR1, Imm5`                        | `0001 DR SR1 1 Imm5`                |  
| **AND DR, SR1, SR2**    | `DR ← SR1 AND SR2`                             | *       | `0101`     | `DR, SR1, SR2`                         | `0101 DR SR1 000 SR2`               |  
| **AND DR, SR1, Imm5**   | `DR ← SR1 AND SEXT(Imm5)`                      | *       | `0101`     | `DR, SR1, Imm5`                        | `0101 DR SR1 1 Imm5`                |  
| **LEA DR, label**       | `DR ← PC + SEXT(PCoffset9)`                    | *       | `1110`     | `DR, PCoffset9`                        | `1110 DR PCoffset9`                 |  
| **LD DR, label**        | `DR ← mem[PC + SEXT(PCoffset9)]`               | *       | `0010`     | `DR, PCoffset9`                        | `0010 DR PCoffset9`                 |  
| **ST SR, label**        | `mem[PC + SEXT(PCoffset9)] ← SR`               |         | `0011`     | `SR, PCoffset9`                        | `0011 SR PCoffset9`                 |  
| **LDR DR, BaseR, Offset6** | `DR ← mem[BaseR + SEXT(Offset6)]`           | *       | `0110`     | `DR, BaseR, Offset6`                   | `0110 DR BaseR Offset6`             |  
| **STR SR, BaseR, Offset6** | `mem[BaseR + SEXT(Offset6)] ← SR`           |         | `0111`     | `SR, BaseR, Offset6`                   | `0111 SR BaseR Offset6`             |  
| **LDI DR, label**       | `DR ← mem[mem[PC + SEXT(PCoffset9)]]`          | *       | `1010`     | `DR, PCoffset9`                        | `1010 DR PCoffset9`                 |  
| **STI SR, label**       | `mem[mem[PC + SEXT(PCoffset9)]] ← SR`          |         | `1011`     | `SR, PCoffset9`                        | `1011 SR PCoffset9`                 |  
| **BR[n][z][p] label**   | `Si (cond) PC ← PC + SEXT(PCoffset9)`          |         | `0000`     | `n, z, p, PCoffset9`                   | `0000 nzp PCoffset9`                |  
| **NOP**                 | No Operation                                   |         | `0000`     | Aucun                                  | `0000 0000 00000000`                |  
| **JMP BaseR**           | `PC ← BaseR`                                   |         | `1100`     | `BaseR`                                | `1100 000 BaseR 000000`             |  
| **RET** (≡ `JMP R7`)    | `PC ← R7`                                      |         | `1100`     | `R7`                                   | `1100 000 R7 000000`                |  
| **JSR label**           | `R7 ← PC; PC ← PC + SEXT(PCoffset11)`          |         | `0100`     | `PCoffset11`                           | `0100 1 PCoffset11`                 |  
| **JSRR BaseR**          | `R7 ← PC; PC ← BaseR`                          |         | `0100`     | `BaseR`                                | `0100 0 000 BaseR 000000`           |  
| **RTI**                 | cf. interruptions                              |         | `1000`     | Aucun                                  | `1000 000000000000`                 |  
| **TRAP Trapvect8**      | `R7 ← PC; PC ← mem[Trapvect8]`                 |         | `1111`     | `Trapvect8`                            | `1111 0000 Trapvect8`               |  
| **BSF DR, SR**          | `DR ← Index du bit 1 de poids faible dans SR`  | *       | `1101`     | `DR, SR`                               | `1101 DR SR 0 0000`                 |  
| **BSB DR, SR**          | `DR ← Index du bit 1 de poids fort dans SR`    | *       | `1101`     | `DR, SR`                               | `1101 DR SR 1 0000`                 |  


Créé par NOUR❤️

