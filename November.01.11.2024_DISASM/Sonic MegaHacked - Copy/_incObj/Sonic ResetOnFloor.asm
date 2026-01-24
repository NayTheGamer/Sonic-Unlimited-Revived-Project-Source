; ---------------------------------------------------------------------------
; Subroutine to	reset Sonic's mode when he lands on the floor
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_ResetOnFloor:
		btst	#4,obStatus(a0)
		beq.s	loc_137AE
		
		tst.b	obDoubleJumpFlag(a0)
;		beq.s	.ret
		cmpi.b	#$14,obDoubleJumpProp(a0)	; is it fully revved up?
		blt.s	.noability					; if not, exit
		bra.w	DropDash_Release

.noability:
		clr.b	obDoubleJumpFlag(a0)
		clr.b	obDoubleJumpProp(a0)		
		
;		nop	
;		nop	
;		nop	

loc_137AE:
		bclr	#5,obStatus(a0)
		bclr	#1,obStatus(a0)
		bclr	#4,obStatus(a0)
		btst	#2,obStatus(a0)
		beq.s	loc_137E4
		bclr	#2,obStatus(a0)
		move.b	#$13,obHeight(a0)
		move.b	#9,obWidth(a0)
		move.b	#id_Walk,obAnim(a0) ; use running/walking animation
		subq.w	#5,obY(a0)

loc_137E4:
		move.b	#0,$3C(a0)
		move.w	#0,(v_itembonus).w	

        rts		
; End of function Sonic_ResetOnFloor

			btst	#sta2ndInvinc,d0			; is Sonic invincible OR Super?
			bne.s	.skipshieldcheck			; if yes, enable Drop Dash
			andi.b	#mask2ndChkElement,d0		; Check for any elemental shields
;			bne.s	.noability					; if he has, we will exit
		.skipshieldcheck:
			cmpi.b	#$14,obDoubleJumpProp(a0)	; is it fully revved up?
			bra.w	DropDash_Release

			
; ---------------------------------------------------------------------------
; Subroutine to	allow Sonic to perform the Drop Dash
; Modified (possibly fixed) thanks to Giovanni
; ---------------------------------------------------------------------------

; =============== S U B R O U T I N E =======================================


DropDash_Release:
		move.w	#$800,d2						; minimum speed
		move.w	#$C00,d3						; maximum speed
		btst	#sta2ndSuper,obStatus2nd(a0)	; is player super?
		beq.s	.notSuper						; if not, branch
		move.w	#$C00,d2						; else, use alt values
		move.w	#$D00,d3

.notSuper:
		move.w	obInertia(a0),d4
		btst	#bitL,(v_jpadhold2).w	; is left being pressed?
		bne.s	.dropLeft				; if yes, branch	
		btst	#bitR,(v_jpadhold2).w	; is right being pressed?
		bne.s	.dropRight				; if yes, branch		
		btst	#staFacing,obStatus(a0)	; if neither are being pressed, check orientation
		beq.s	.dropRight

.dropLeft:
		neg.w	d2						; negate base value
		neg.w	d3						; negate base value

		bset	#staFacing,obStatus(a0)	; force orientation to correct one
		tst.w	obVelX(a0)				; check if speed is greater than 0
		bgt.s	.dropSlopeLeft			; if yes, branch
		asr.w	#2,d4           		; divide ground speed by 4
		add.w	d2,d4           		; add speed base to ground speed
		cmp.w	d3,d4           		; check if current speed is lower than speed cap
		bgt.s	.setspeed				; if not, branch
		move.w	d3,d4					; if yes, cap speed
		bra.s	.setspeed

.dropSlopeLeft:
		tst.b	obAngle(a0)				; check if Sonic is on a flat surface
		beq.s	.dropBackLeft			; if yes, branch
		asr.w	#1,d4					; divide ground speed by 2
		add.w	d2,d4					; add speed base to ground speed
		bra.s	.setspeed

.dropBackLeft:
		move.w	d2,d4					; move speed base to ground speed
		bra.s	.setspeed
		
.dropMaxLeft:
		move.w	d3,d4					; grant sonic the highest possible speed
		bra.s	.setspeed

.dropRight:
		bclr	#staFacing,obStatus(a0)	; force orientation to correct one			
		tst.w	obVelX(a0)				; check if speed is lower than 0
		blt.s	.dropSlopeRight			; if yes, branch
		asr.w	#2,d4           		; divide ground speed by 4
		add.w	d2,d4           		; add speed base to ground speed
		cmp.w	d3,d4           		; check if current speed is lower than speed cap
		blt.s	.setspeed				; if not, branch
		move.w	d3,d4			  		; if yes, cap speed
		bra.s	.setspeed
		
.dropSlopeRight:
		tst.b	obAngle(a0)				; check if Sonic is on a flat surface
		beq.s	.dropBackRight			; if yes, branch
		asr.w	#1,d4					; divide ground speed by 2
		add.w	d2,d4					; add speed base to ground speed
		bra.s	.setspeed
	
.dropBackRight:
		move.w	d2,d4					; move speed base to ground speed 
		bra.s	.setspeed
	
.dropMaxRight:
		move.w	d3,d4
		
.setspeed:	
		move.w	d4,obInertia(a0)			; move dash speed into inertia	

;		move.b	#$10,(v_cameralag).w
		bsr.w	Reset_Sonic_Position_Array
		move.b	#$E,obHeight(a0)
		move.b	#7,obWidth(a0)
		move.b	#id_Roll,obAnim(a0)
		bset	#staSpin,obStatus(a0)
		addq.w	#5,obY(a0)					; add the difference between Sonic's rolling and standing heights
		clr.b	obDoubleJumpFlag(a0)
		clr.b	obDoubleJumpProp(a0)

	; Create drop dash dust
		jsr		(FindFreeObj).l
		bne.s	.noDust
		_move.b	#id_Obj05,obID(a1)		; load obj07
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.b	obStatus(a0),obStatus(a1)	; match Player's x orientation
		andi.b	#maskFacing,obStatus(a1)	; only retain staFacing (staFlipX)
		move.b	#3,obAnim(a1)
		move.b	#2,obRoutine(a1)
		move.l	#MapUnc_1DF5E,obMap(a1)
		ori.b	#4,obRender(a1)
		move.w	#priority1,obPriority(a1)	; RetroKoH/Devon S3K+ Priority Manager
		move.b	#$10,obActWid(a1)
		move.w	#ArtTile_DashDust,obGfx(a1)
		movea.l	a0,a1

		move.w	#sfx_Teleport,d0
		jmp		PlaySound_Special		; play spindash release sfx

.noDust:
		movea.l	a0,a1
		rts			