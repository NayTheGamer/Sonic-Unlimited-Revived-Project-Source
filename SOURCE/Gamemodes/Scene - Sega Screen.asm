; ---------------------------------------------------------------------------
; Sega screen
; ---------------------------------------------------------------------------
GM_Sega:

    if ClownMDEmu_Compatibility=0
	KDebug.WriteLine "Starting to measure performance of GM_Sega..."
	KDebug.StartTimer
	KDebug.EndTimer 	; this will print number of cycles measured
	else
	endif

 		move.b	#bgm_Stop,d0
		bsr.w	PlaySound_Special ; stop music
		bsr.w	ClearPLC
		bsr.w	PaletteFadeOut
		lea	(vdp_control_port).l,a6
		move.w	#$8004,(a6)	; use 8-colour mode
		move.w	#$8200+(vram_fg>>10),(a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13),(a6) ; set background nametable address
		move.w	#$8B00,(a6)	; full-screen vertical scrolling
		clr.b	(f_wtr_state).w			
		disable_ints			
		move.w	d0,(vdp_control_port).l		
		bsr.w	ClearScreen
        ResetDMAQueue		
		locVRAM	0
		lea	(Nem_SegaLogo).l,a0 ; load Sega	logo patterns
		bsr.w	NemDec
		lea	($FF0000).l,a1
		lea	(mappingsSega).l,a0 ; load Sega	logo mappings
		move.w	#0,d0
		bsr.w	EniDec		

		copyTilemap	$FF0000,vram_bg,$27,$1B
		copyTilemap	$FF0000,vram_fg,$27,$1B		

.loadpal:
		moveq	#palid_SegaBG,d0
		bsr.w	PalLoad1	; load Sega logo palette
		disable_ints
		move.w	(v_vdp_buffer1).l,d0		
		ori.b	#$40,d0
		move.w	d0,(vdp_control_port).l	
		bsr.w	PaletteFadeIn

Sega_WaitPal:
		move.b	#2,(v_vbla_routine).w
		bsr.w	WaitForVBla
		bne.s	Sega_WaitPal

		move.b	#sfx_Sega,d0
		bsr.w	PlaySound_Special	; play "SEGA" sound				
		move.b	#$14,(v_vbla_routine).w
		bsr.w	WaitForVBla
		move.w	#$85,(v_demolength).w

Sega_WaitEnd:
		move.b	#2,(v_vbla_routine).w
		bsr.w	WaitForVBla
		tst.w	(v_demolength).w
		beq.s	Sega_GotoTitle
		andi.b	#btnStart,(v_jpadpress1).w ; is Start button pressed?
		beq.s	Sega_WaitEnd	; if not, branch

Sega_GotoTitle:
        move.b  #id_Title,($FFFFF600).w
		
		rts					

; ===========================================================================