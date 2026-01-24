GM_Custom1:
		bsr.w	PaletteFadeOut        
		move.b	#bgm_Stop,d0
		bsr.w	PlaySound_Special ; stop music
		bsr.w	ClearPLC
		bsr.w	PaletteFadeOut
		lea	(vdp_control_port).l,a6
		move.w	#$8004,(a6)	; use 8-colour mode
		move.w	#$8200+(vram_fg>>10),(a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13),(a6) ; set background nametable address
		move.w	#$8700,(a6)	; set background colour (palette entry 0)
		move.w	#$8B00,(a6)	; full-screen vertical scrolling
		clr.b	(f_wtr_state).w
		disable_ints
		move.w	(v_vdp_buffer1).w,d0
		andi.b	#$BF,d0
		move.w	d0,(vdp_control_port).l
		bsr.w	ClearScreen
		locVRAM	0
		lea	(Nem_Custom1).l,a0 ; load Sega	logo patterns
		bsr.w	NemDec
		lea	($FF0000).l,a1
		lea	Asm_Eni_Custom1.l,a0 ; load Sega	logo mappings	
		lea	($FFFF0000).l,a1			; set temporary ram space to dump to					
		move.w	#0,d0
		jsr	EniDec

		copyTilemap	$FF0000,$E510,$17,7
;		copyTilemap	$FF0180,$C000,$27,$1B


.loadpal:
		moveq	#palid_Sonic,d0
		bsr.w	PalLoad1	; load Sega logo palette
		move.w	#-$A,(v_pcyc_num).w
		move.w	#0,(v_pcyc_time).w
		move.w	#0,(v_pal_buffer+$12).w
		move.w	#0,(v_pal_buffer+$10).w
		move.w	(v_vdp_buffer1).w,d0
		ori.b	#$40,d0
		move.w	d0,(vdp_control_port).l

Custom1_WaitPal:
		move.b	#2,(v_vbla_routine).w
		bsr.w	WaitForVBla
		bsr.w	PalCycle_Sega
		bne.s	Custom1_WaitPal

		move.b	#sfx_Sega,d0
		bsr.w	PlaySound_Special	; play "SEGA" sound
		move.b	#$14,(v_vbla_routine).w
		bsr.w	WaitForVBla
		move.w	#$1E,(v_demolength).w

Custom1_WaitEnd:
		move.b	#10,(v_vbla_routine).w
		bsr.w	WaitForVBla
		tst.w	(v_demolength).w
		beq.s	Custom1_GotoTitle
		andi.b	#btnStart,(v_jpadpress1).w ; is Start button pressed?
		beq.s	Custom1_WaitEnd	; if not, branch

Custom1_GotoTitle:
		move.b	#$04,($FFFFF600).w			; set screen mode to "SSRG Screen"
		rts						; return	