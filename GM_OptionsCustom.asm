; ---------------------------------------------------------------------------
; Options screen
; ---------------------------------------------------------------------------		


GM_Options:
		move.b	#bgm_Stop,d0
		bsr.w	PlaySound_Special ; stop music
		bsr.w	ClearPLC
		bsr.w	PaletteFadeOut
		lea	(vdp_control_port).l,a6
		move.w	#$8004,(a6)	; use 8-colour mode
		move.w	#$8200+(vram_fg>>10),(a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13),(a6) ; set background nametable address
		clr.b	(f_wtr_state).w
		disable_ints	
		bsr.w	ClearScreen
        ResetDMAQueue
        locVRAM  0		
		lea	(Menu_Font).l,a0 ; load Options logo patterns
		bsr.w	NemDec			
		
;   options commented out for stable reasons
;   the bgs
		
;Options_Background:
;		moveq	#palid_Sonic,d0
;		bsr.w	PalLoad1	; load Options logo palette		
;        locVRAM $140		
;        lea (Kos_OldUnlimitedBackground).l,a0
;        bsr.w  KosDec
;		lea	($FF0000).l,a1		
;		lea (Eni_OldUnlimitedBackground).l,a0
;		move.w	#0,d0		
;		bsr.w  EniDec

;		copyTilemap	$FF0000,$D000,$3F,$1F	

.loadpal:
		moveq	#palid_Menu,d0
		bsr.w	PalLoad1	; load Options logo palette										
		disable_ints
		move.w	(v_vdp_buffer1).l,d0		
		ori.b	#$40,d0
		bsr.w	PaletteFadeIn	
		move.b	#bgm_Options,d0
		bsr.w	PlaySound_Special	; play "Options" sound						

Options_WaitOptions:
		move.b	#8,(v_vbla_routine).w
		bsr.w	WaitForVBla
		andi.b	#btnStart,(v_jpadpress1).w ; is Start button pressed?			
		beq.s	Options_WaitOptions	
		bsr.w   PlayLevel					
		rts

Options_Adresses:		
;    move.w ($FFFFF102),d0  ; Set adresses
;    move.w ($FFFFF104),d0  ; Set adresses
;    move.w ($FFFFF106),d0  ; Set adresses	

    rts	

Options_Main:
    ; TODO: add stuff for setting which setting to go here and that, will probably move it after the ASCII
	; Text for consinstency sake.	

 ; temporarily remap characters to title card letter format
 ; Characters are encoded as Aa, Bb, Cc, etc. through a macro
LevelSelect_Text:




Options_Selections:
    ; I dont even know........
	
;   includes/bincludes go here

Kos_MenuText:    binclude "Screens/Options/KosMenuText.nem"	
    even	
Kos_OldUnlimitedBackground:    binclude "Screens/Options/OldUnlimitedBackground.kos"	
    even	
Eni_OldUnlimitedBackground:    binclude "Screens/Options/OldUnlimitedBackground.eni"	
    even	
Pal_OptionsBackground:    binclude "Screens/Options/OldUnlimitedBackground.pal"	 ; wont be added to the pointers for now because im lazy :P
    even			
	
Options_GotoTitle:
		rts
		
;   thanks DSK for helping me on this, fucking hell.		

;   I'll probably end up screwing dis up :-?
		