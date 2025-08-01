; ---------------------------------------------------------------------------
; Subroutine to	prevent	Sonic leaving the boundaries of	a level
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_LevelBound:
		move.l	obX(a0),d1
		move.w	obVelX(a0),d0
		ext.l	d0
		asl.l	#8,d0
		add.l	d0,d1
		swap	d1
		move.w	(v_limitleft2).w,d0
		addi.w	#$10,d0
		cmp.w	d1,d0		; has Sonic touched the	side boundary?
		bhi.s	sides		; if yes, branch
		move.w	(v_limitright2).w,d0
		addi.w	#$128,d0
		tst.b	(f_lockscreen).w
		bne.s	.screenlocked
		addi.w	#$40,d0

.screenlocked:
		cmp.w	d1,d0		; has Sonic touched the	side boundary?
		bls.s	sides		; if yes, branch

chkbottom:
		move.w	(v_limitbtm2).w,d0
		addi.w	#$E0,d0
		cmp.w	obY(a0),d0	; has Sonic touched the	bottom boundary?
		blt.s	.bottom		; if yes, branch
		rts	
; ===========================================================================

.bottom:
        move.w ($FFFFF726).w,d0
        move.w ($FFFFF72E).w,d1
        cmp.w d0,d1
        blt.s .bottom_locret
        cmpi.w #$501,($FFFFFE10).w ; is level SBZ2?
        bne.w KillSonic_JMP ; if not, kill Sonic
        cmpi.w #$2000,($FFFFD008).w
        bcs.w KillSonic_JMP
        clr.b ($FFFFFE30).w ; clear lamppost counter
        move.w #1,($FFFFFE02).w ; restart the level
        move.w #$103,($FFFFFE10).w ; set level to SBZ3 (LZ4)


.bottom_locret:
        rts

KillSonic_JMP:
        jmp KillSonic
; ===========================================================================

sides:
		move.w	d0,obX(a0)
		move.w	#0,obX+2(a0)
		move.w	#0,obVelX(a0)	; stop Sonic moving
		move.w	#0,obInertia(a0)
		bra.s	chkbottom
; End of function Sonic_LevelBound