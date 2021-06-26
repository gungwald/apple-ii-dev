
********************************
*                              *
* SCROLL.HGR                   *
*                              *
* AUTHOR:  BILL CHATFIELD      *
* LICENSE: GPL                 *
*                              *
********************************

               ORG   $801       ;LOAD ADDRESS
               TYP   $06        ;BINARY FILE
               DSK   SCROLL.HGR ;OUTPUT FILE NAME

********************************
*                              *
* CONSTANTS                    *
*                              *
********************************

USERARG        EQU   6          ;VALUE PASSED IN FROM CALLER
LOADDR         EQU   6
HIADDR         EQU   8
LINELEN        EQU   40         ;LENGTH OF AN HGR LINE IN BYTES
LINECNT        EQU   192        ;SCREEN HEIGHT IN PIXELS 0-191

********************************
*                              *
* MACRO: PUSH X ONTO THE STACK *
*                              *
********************************

PUSHX          MAC
               TXA
               PHA
               <<<

********************************
*                              *
* MACRO: POP X FROM THE STACK  *
*                              *
********************************

POPX           MAC
               PLA
               TAX
               <<<

********************************
*                              *
* MACRO: CONVERT HGR LINE      *
*        NUMBER TO MEMORY ADDR *
*                              *
********************************

LN2AD          MAC
               PUSHX
               LDA   ]1         ; LOAD LINE NUMBER
               ASL   A          ; MULT BY 2 B/C ADDR TBL
               TAX              ; COPY CALC'D TBL IDX TO X 
                         ===== Page 2 - SCROLL.HGR =====
 
               LDA   HGRMEM,X
               STA   ]2
               INX
               LDA   HGRMEM,X
               STA   ]2+1
               POPX
               <<<

********************************
*                              *
* MACRO: CONVERT HGR LINE      *
*        NUMBER IN X TO MEMORY *
*        ADDRESS               *
*                              *
********************************

X2AD           MAC
               TXA
               ASL   A
               TAX
               LDA   HGRMEM,X
               STA   ]1
               INX
               LDA   HGRMEM,X
               STA   ]1+1
               LSR              ; DIVIDE BY 2 TO RESTORE X
               <<<
*
* BEGINNING OF MAIN PROGRAM
* INITIALIZE VARIABLES
* TODO: FIND OUT IF REGISTERS NEED TO BE SAVED/RESTORED
*
               LDA   USERARG
               STA   SCROLCNT
               STA   LOLINE
               LDA   #0
               STA   HILINE
*
* DETERMINE LINE ADDRESSES
*
NEXTLINE       LN2AD HILINE;HIADDR
               LN2AD LOLINE,LOADDR
*
* COPY BYTES FROM LINE AT LOADDR TO LINE AT HIADDR
*
               LDY   #0
NEXTBYTE       LDA   (LOADDR),Y
               STA   (HIADDR),Y
               INY
               CPY   #LINELEN
               BMI   NEXTBYTE
*
* INCREMENT LINES
*
               INC   HILINE
               INC   LOLINE
* 
                         ===== Page 3 - SCROLL.HGR =====
 
* CHECK IF AT LAST SCROLL LINE
*
               LDA   LOLINE
               CMP   #LINECNT
               BMI   NEXTLINE
*
* CLEAR TO BOTTOM OF SCREEN. USE X AS THE LINE NUMBER
*
               LDX   HILINE
CLRLINE        X2AD  HIADDR
               LDA   #0
               LDY   #0
CLRBYTE        STA   (HIADDR),Y
               INY
               CPY   #LINELEN
               BMI   CLRBYTE
*
* CHECK IF AT LAST CLEAR LINE
*
               INX
               CPX   #LINECNT
               BMI   CLRLINE
*
* THIS IS THE END
*
               RTS
*
* VARIABLES
*
SCROLCNT       DB    0
LOLINE         DB    0
HILINE         DB    0
HGRMEM         DA    $2000      ; LINE 0
               DA    $2400      ; LINE 1
               DA    $2800      ; LINE 2
               DA    $2C00      ; LINE 3
               DA    $3000      ; LINE 4
               DA    $3400      ; LINE 5
               DA    $3800      ; LINE 6
               DA    $3C00      ; LINE 7
*
               DA    $2080      ; LINE 8
               DA    $2480      ; LINE 9
               DA    $2880      ; LINE 10
               DA    $2C80      ; LINE 11
               DA    $3080      ; LINE 12
               DA    $3480      ; LINE 13
               DA    $3880      ; LINE 14
               DA    $3C80      ; LINE 15
*
               DA    $2100      ; LINE 16
               DA    $2500      ; LINE 17
               DA    $2900      ; LINE 18
               DA    $2D00      ; LINE 19
               DA    $3100      ; LINE 20
               DA    $3500      ; LIN3 21
               DA    $3900      ; LINE 22 
                         ===== Page 4 - SCROLL.HGR =====
 
               DA    $3D00      ; LINE 23
*
               DA    $2180      ; LINES 24-31
               DA    $2200      ; LINES 32-39
               DA    $2280
               DA    $2300
               DA    $2380
               DA    $2028
               DA    $20A8
               DA    $2128
               DA    $22A8
*
               DA    $2228
               DA    $23A8
               DA    $232A
               DA    $23A8
               DA    $2050
               DA    $20D0
               DA    $2150
               DA    $21D0
               DA    $2250
               DA    $22D0
               DA    $2350
               DA    $23D0
