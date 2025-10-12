; ---------------------------------------------------------------------------
; Sprite mappings - zone title cards
; ---------------------------------------------------------------------------
Map_Card:	dc.w M_Card_GHZ-Map_Card
		dc.w M_Card_LZ-Map_Card
		dc.w M_Card_MZ-Map_Card
		dc.w M_Card_SLZ-Map_Card
		dc.w M_Card_SYZ-Map_Card
		dc.w M_Card_SBZ-Map_Card
		dc.w M_Card_Zone-Map_Card
		dc.w M_Card_Act1-Map_Card
		dc.w M_Card_Act2-Map_Card
		dc.w M_Card_Act3-Map_Card
		dc.w M_Card_Oval-Map_Card
		dc.w M_Card_FZ-Map_Card
M_Card_GHZ:	dc.b $E	;  GREEN HILL | FANATIC SUNSET
		dc.b $F8, 5, 0, $14, $80	; F
		dc.b $F8, 5, 0, 0, $90		; A
		dc.b $F8, 5, 0, $2E, $A0	; N
		dc.b $F8, 5, 0, 0, $B0		; A
		dc.b $F8, 5, 0, $42, $C0	; T
		dc.b $F8, 1, 0, $20, $D0	; I
		dc.b $F8, 5, 0, 8, $D8		; C
		dc.b $F8, 0, 0, $56, $E8	; Space
		dc.b $F8, 5, 0, $3E, $F8	; S
		dc.b $F8, 5, 0, $46, $8	; U
		dc.b $F8, 5, 0, $2E, $18	; N
		dc.b $F8, 5, 0, $3E, $28	; S
		dc.b $F8, 5, 0, $10, $38	; E
		dc.b $F8, 5, 0, $42, $48	; T
		even
M_Card_LZ:	dc.b $F	;  LABYRINTH | LABYRINTH DECAY
		dc.b $F8, 5, 0, $26, $80	; L
		dc.b $F8, 5, 0, 0, $90		; A
		dc.b $F8, 5, 0, 4, $A0		; B
		dc.b $F8, 5, 0, $4A, $B0	; Y
		dc.b $F8, 5, 0, $3A, $C0	; R
		dc.b $F8, 1, 0, $20, $D0	; I
		dc.b $F8, 5, 0, $2E, $D8	; N
		dc.b $F8, 5, 0, $42, $E8	; T
		dc.b $F8, 5, 0, $1C, $F8	; H
		dc.b $F8, 0, 0, $56, $8	; Space
		dc.b $F8, 5, 0, $0C, $18	; D
		dc.b $F8, 5, 0, $10, $28	; E
		dc.b $F8, 5, 0, 8, $38		; C
		dc.b $F8, 5, 0, 0, $48		; A
		dc.b $F8, 5, 0, $4A, $58	; Y
		even
M_Card_MZ:	dc.b $F	;  MARBLE | CRUMBLED MARBLE
		dc.b $F8, 5, 0, 8, $80		; C
		dc.b $F8, 5, 0, $3A, $90	; R
		dc.b $F8, 5, 0, $46, $A0	; U
		dc.b $F8, 5, 0, $2A, $B0	; M
		dc.b $F8, 5, 0, 4, $C0		; B
		dc.b $F8, 5, 0, $26, $D0	; L
		dc.b $F8, 5, 0, $10, $E0	; E
		dc.b $F8, 5, 0, $0C, $F0	; D
		dc.b $F8, 0, 0, $56, $0	; Space
		dc.b $F8, 5, 0, $2A, $10	; M
		dc.b $F8, 5, 0, 0, $20		; A
		dc.b $F8, 5, 0, $3A, $30	; R
		dc.b $F8, 5, 0, 4, $40		; B
		dc.b $F8, 5, 0, $26, $50	; L
		dc.b $F8, 5, 0, $10, $60	; E
	    even
M_Card_SLZ:	dc.b $D	;  STAR LIGHT | PEACEFUL CITY
		dc.b $F8, 5, 0, $36, $80	; P
		dc.b $F8, 5, 0, $10, $90	; E
		dc.b $F8, 5, 0, 0, $A0		; A
		dc.b $F8, 5, 0, 8, $B0		; C
		dc.b $F8, 5, 0, $10, $C0	; E
		dc.b $F8, 5, 0, $14, $D0	; F
		dc.b $F8, 5, 0, $46, $E0	; U
		dc.b $F8, 5, 0, $26, $F0	; L
		dc.b $F8, 0, 0, $56, $0	; Space
		dc.b $F8, 5, 0, 8, $10		; C
		dc.b $F8, 1, 0, $20, $20	; I
		dc.b $F8, 5, 0, $42, $28	; T
		dc.b $F8, 5, 0, $4A, $38	; Y
		even
M_Card_SYZ:	dc.b $E	;  SPRING YARD | SPARKLING CITY
		dc.b $F8, 5, 0, $3E, $80	; S
		dc.b $F8, 5, 0, $36, $90	; P
		dc.b $F8, 5, 0, 0, $A0		; A
		dc.b $F8, 5, 0, $3A, $B0	; R
		dc.b $F8, 5, 0, $22, $C0	; K
		dc.b $F8, 5, 0, $26, $D0	; L
		dc.b $F8, 1, 0, $20, $E0	; I
		dc.b $F8, 5, 0, $2E, $E8	; N
		dc.b $F8, 5, 0, $18, $F8	; G
		dc.b $F8, 0, 0, $56, $8	; Space
		dc.b $F8, 5, 0, 8, $18		; C
		dc.b $F8, 1, 0, $20, $28	; I
		dc.b $F8, 5, 0, $42, $30	; T
		dc.b $F8, 5, 0, $4A, $40	; Y
		even
M_Card_SBZ:	dc.b $A			; SCRAP BRAIN
		dc.b $F8, 5, 0,	$3E, $AC
		dc.b $F8, 5, 0,	8, $BC
		dc.b $F8, 5, 0,	$3A, $CC
		dc.b $F8, 5, 0,	0, $DC
		dc.b $F8, 5, 0,	$36, $EC
		dc.b $F8, 5, 0,	4, $C
		dc.b $F8, 5, 0,	$3A, $1C
		dc.b $F8, 5, 0,	0, $2C
		dc.b $F8, 1, 0,	$20, $3C
		dc.b $F8, 5, 0,	$2E, $44
		even
M_Card_Zone:	dc.b 4			; ZONE
		dc.b $F8, 5, 0,	$4E, $E0
		dc.b $F8, 5, 0,	$32, $F0
		dc.b $F8, 5, 0,	$2E, 0
		dc.b $F8, 5, 0,	$10, $10
		even
M_Card_Act1:	dc.b 2			; ACT 1
		dc.b 4,	$C, 0, $53, $EC
		dc.b $F4, 2, 0,	$57, $C
M_Card_Act2:	dc.b 2			; ACT 2
		dc.b 4,	$C, 0, $53, $EC
		dc.b $F4, 6, 0,	$5A, 8
M_Card_Act3:	dc.b 2			; ACT 3
		dc.b 4,	$C, 0, $53, $EC
		dc.b $F4, 6, 0,	$60, 8
M_Card_Oval:	dc.b $D			; Oval
		dc.b $E4, $C, 0, $70, $F4
		dc.b $E4, 2, 0,	$74, $14
		dc.b $EC, 4, 0,	$77, $EC
		dc.b $F4, 5, 0,	$79, $E4
		dc.b $14, $C, $18, $70,	$EC
		dc.b 4,	2, $18,	$74, $E4
		dc.b $C, 4, $18, $77, 4
		dc.b $FC, 5, $18, $79, $C
		dc.b $EC, 8, 0,	$7D, $FC
		dc.b $F4, $C, 0, $7C, $F4
		dc.b $FC, 8, 0,	$7C, $F4
		dc.b 4,	$C, 0, $7C, $EC
		dc.b $C, 8, 0, $7C, $EC
		even
M_Card_FZ:	dc.b $F	;  FINAL | FINAL BOSSFIGHT
		dc.b $F8, 5, 0, $14, $80	; F
		dc.b $F8, 1, 0, $20, $90	; I
		dc.b $F8, 5, 0, $2E, $98	; N
		dc.b $F8, 5, 0, 0, $A8		; A
		dc.b $F8, 5, 0, $26, $B8	; L
		dc.b $F8, 0, 0, $56, $C8	; Space
		dc.b $F8, 5, 0, 4, $D8		; B
		dc.b $F8, 5, 0, $32, $E8	; O
		dc.b $F8, 5, 0, $3E, $F8	; S
		dc.b $F8, 5, 0, $3E, $8	; S
		dc.b $F8, 5, 0, $14, $18	; F
		dc.b $F8, 1, 0, $20, $28	; I
		dc.b $F8, 5, 0, $18, $30	; G
		dc.b $F8, 5, 0, $1C, $40	; H
		dc.b $F8, 5, 0, $42, $50	; T
	    even	