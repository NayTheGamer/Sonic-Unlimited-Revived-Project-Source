; ---------------------------------------------------------------------------
; Sprite mappings - SCORE, TIME, RINGS
; ---------------------------------------------------------------------------
Map_HUD_internal:
		dc.w .allyellow-Map_HUD_internal
		dc.w .ringred-Map_HUD_internal
		dc.w .timered-Map_HUD_internal
		dc.w .allred-Map_HUD_internal
.allyellow:	dc.b $A
	dc.b $80, $D, $80, $0, $0
	dc.b $80, $D, $80, $18, $20
	dc.b $80, $D, $80, $20, $40
	dc.b $90, $D, $80, $10, $0
	dc.b $90, $D, $80, $28, $28
	dc.b $A0, $D, $80, $8, $0
	dc.b $A0, $1, $80, $0, $1E
	dc.b $A0, $9, $80, $30, $30
	dc.b $40, $5, $81, $A, $0
	dc.b $40, $D, $81, $E, $10
.ringred:	dc.b $A
	dc.b $80, $D, $80, $0, $0
	dc.b $80, $D, $80, $18, $20
	dc.b $80, $D, $80, $20, $40
	dc.b $90, $D, $80, $10, $0
	dc.b $90, $D, $80, $28, $28
	dc.b $A0, $D, $A0, $8, $0
	dc.b $A0, $1, $A0, $0, $1E
	dc.b $A0, $9, $80, $30, $30
	dc.b $40, $5, $81, $A, $0
	dc.b $40, $D, $81, $E, $10
.timered:	dc.b $A
	dc.b $80, $D, $80, $0, $0
	dc.b $80, $D, $80, $18, $20
	dc.b $80, $D, $80, $20, $40
	dc.b $90, $D, $A0, $10, $0
	dc.b $90, $D, $80, $28, $28
	dc.b $A0, $D, $80, $8, $0
	dc.b $A0, $1, $80, $0, $1E
	dc.b $A0, $9, $80, $30, $30
	dc.b $40, $5, $81, $A, $0
	dc.b $40, $D, $81, $E, $10
		dc.b 0
.allred:	dc.b $A
	dc.b $80, $D, $80, $0, $0
	dc.b $80, $D, $80, $18, $20
	dc.b $80, $D, $80, $20, $40
	dc.b $90, $D, $A0, $10, $0
	dc.b $90, $D, $80, $28, $28
	dc.b $A0, $D, $A0, $8, $0
	dc.b $A0, $1, $A0, $0, $1E
	dc.b $A0, $9, $80, $30, $30
	dc.b $40, $5, $81, $A, $0
	dc.b $40, $D, $81, $E, $10
		even