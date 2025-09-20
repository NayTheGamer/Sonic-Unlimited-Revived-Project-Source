; ---------------------------------------------------------------------------
; Title	screen
; ---------------------------------------------------------------------------

GM_Title:

    if ClownMDEmu_Compatibility=0
	KDebug.WriteLine "Starting to measure performance of GM_Title..."
	KDebug.StartTimer
	KDebug.EndTimer 	; this will print number of cycles measured
	else
	endif

		move.b	#bgm_Stop,d0
		bsr.w	PlaySound_Special ; stop music
		bsr.w	ClearPLC
		disable_ints
		bsr.w	SoundDriverLoad
		lea	(vdp_control_port).l,a6
		move.w	#$8004,(a6)	; 8-colour mode
		move.w	#$8200+(vram_fg>>10),(a6) ; set foreground nametable address
		move.w	#$8400+(vram_bg>>13),(a6) ; set background nametable address
		move.w	#$9001,(a6)	; 64-cell hscroll size
		move.w	#$9200,(a6)	; window vertical position
		move.w	#$8B03,(a6)
		move.w	#$8720,(a6)	; set background colour (palette line 2, entry 0)
		clr.b	(f_wtr_state).w
		bsr.w	ClearScreen
        ResetDMAQueue
		
        if Sonic_Hacking_Contest_Splash=1		
        jsr SHC	
        else
        endif 		

		lea	(v_objspace).w,a1
		moveq	#0,d0
		move.w	#$7FF,d1


Tit_ClrObj1:
		move.l	d0,(a1)+
		dbf	d1,Tit_ClrObj1	; fill object space ($D000-$EFFF) with 0

		locVRAM	0
		lea	(Nem_JapNames).l,a0 ; load Japanese credits
		bsr.w	NemDec
		locVRAM	$14C0
		lea	(Nem_CreditText).l,a0 ;	load alphabet
		bsr.w	NemDec
		lea	($FF0000).l,a1
		lea	(Eni_JapNames).l,a0 ; load mappings for	Japanese credits
		move.w	#0,d0
		bsr.w	EniDec

		copyTilemap	$FF0000,$C000,$27,$1B

		lea	(v_pal_dry_dup).w,a1
		moveq	#cBlack,d0
		move.w	#$1F,d1

Tit_ClrPal:
		move.l	d0,(a1)+
		dbf	d1,Tit_ClrPal	; fill palette with 0 (black)	

		moveq	#palid_Sonic,d0	; load Sonic's palette
		bsr.w	PalLoad1		
		bsr.w	PaletteFadeIn
		disable_ints
		bsr.w	DeformLayers		
		bsr.w   PaletteWhiteOut
		move.b   #sfx_TransitionLmao,d0
		jsr     PlaySound_Special
		locVRAM	$4000
		lea	(Nem_TitleFg).l,a0 ; load title	screen patterns
		bsr.w	NemDec
		locVRAM	$D000,4(a6)
		lea	(Art_Text).l,a5	; load level select font
		move.w	#$28F,d1

Tit_LoadText:
		move.w	(a5)+,(a6)
		dbf	d1,Tit_LoadText	; load level select font

		move.b	#0,(v_lastlamp).w ; clear lamppost counter
		if DebugTools<>0
		move.w	#0,(v_debuguse).w ; disable debug item placement mode
		move.w	#0,(f_demo).w	; disable debug mode
		endif		
		move.w	#0,($FFFFFFEA).w ; unused variable
		move.w	#(id_GHZ<<8),(v_zone).w	; set level to GHZ (00)
		move.w	#0,(v_pcyc_time).w ; disable palette cycling
		bsr.w	LevelSizeLoad
		lea	(v_16x16).w,a1
		lea	(Blk16_TS).l,a0 ; load	GHZ 16x16 mappings
		move.w	#0,d0
		bsr.w	EniDec
		lea	(Blk256_TS).l,a0 ; load GHZ 256x256 mappings
		lea	(v_256x256).l,a1
		bsr.w	KosDec
		bsr.w	LevelLayoutLoad
		bsr.w	PaletteFadeOut
		disable_ints
		bsr.w	ClearScreen
		lea	(vdp_control_port).l,a5
		lea	(vdp_data_port).l,a6
		lea	(v_bgscreenposx).w,a3
		lea	(v_lvllayout+$40).w,a4
		move.w	#$6000,d2
		bsr.w	DrawChunks
		lea	($FF0000).l,a1
		lea	(Eni_Title).l,a0 ; load	title screen mappings
		move.w	#0,d0
		bsr.w	EniDec

		copyTilemap	$FF0000,$C206,$21,$15

		locVRAM	0
		lea	(Nem_TS).l,a0 ; load GHZ patterns
		bsr.w	NemDec
		move.b	#bgm_Title,d0
		bsr.w	PlaySound_Special	; play title screen music
		if DebugTools=0		
		move.b	#0,(f_debugmode).w ; disable debug mode
		else
		endif
		move.w	#$148,(v_demolength).w ; run title screen for $178 frames
		lea	(v_objspace+$80).w,a1
		moveq	#0,d0
		move.w	#7,d1

Tit_ChkPal4:
		moveq	#palid_Title,d0	; load title screen palette
		bsr.w	PalLoad1
		lea (palid_Title),a0	

Tit_ClrObj2:
		move.l	d0,(a1)+
		dbf	d1,Tit_ClrObj2


.isjap:
		move.b	#2,(v_objspace+$100+obFrame).w
		jsr	(ExecuteObjects).l
		bsr.w	DeformLayers
		jsr	(BuildSprites).l
		moveq	#plcid_Main,d0
		bsr.w	NewPLC
		move.w	#0,(v_title_dcount).w
		move.w	#0,(v_title_ccount).w
		move.w	(v_vdp_buffer1).w,d0
		ori.b	#$40,d0
		move.w	d0,(vdp_control_port).l
		bsr.w	PaletteFadeIn

Tit_MainLoop:
		move.b	#4,(v_vbla_routine).w
		bsr.w	WaitForVBla
		jsr	(ExecuteObjects).l
		bsr.w	DeformLayers
		jsr	(BuildSprites).l
		move.w	(v_objspace+obX).w,d0
		addq.w	#2,d0
		move.w	d0,(v_objspace+obX).w ; move Sonic to the right
		cmpi.w	#$1C00,d0	; has Sonic object passed $1C00 on x-axis?
		blo.s	Tit_ChkRegion	; if not, branch

		move.b	#id_Sega,(v_gamemode).w ; go to Sega screen
		rts	
; ===========================================================================

Tit_ChkRegion:
		tst.b	(v_megadrive).w	; check	if the machine is US or	Japanese
		bpl.s	Tit_RegionJap	; if Japanese, branch

		lea	(LevSelCode_US).l,a0 ; load US code
		bra.s	Tit_EnterCheat

Tit_RegionJap:
		lea	(LevSelCode_US).l,a0 ; load J code

Tit_EnterCheat:
		move.w	(v_title_dcount).w,d0
		adda.w	d0,a0
		move.b	(v_jpadpress1).w,d0 ; get button press
		andi.b	#btnDir,d0	; read only UDLR buttons
		cmp.b	(a0),d0		; does button press match the cheat code?
		bne.s	Tit_ResetCheat	; if not, branch
		addq.w	#1,(v_title_dcount).w ; next button press
		tst.b	d0
		bne.s	Tit_CountC
		lea	(f_levselcheat).w,a0
		move.w	(v_title_ccount).w,d1
		lsr.w	#1,d1
		andi.w	#3,d1
		beq.s	Tit_PlayRing
		tst.b	(v_megadrive).w
		bpl.s	Tit_PlayRing
		moveq	#1,d1
		move.b	d1,1(a0,d1.w)	; cheat depends on how many times C is pressed

Tit_PlayRing:
		move.b	#1,(a0,d1.w)	; activate cheat
		move.b	#sfx_Ring,d0
		bsr.w	PlaySound_Special	; play ring sound when code is entered
		bra.s	Tit_CountC
; ===========================================================================

Tit_ResetCheat:
		tst.b	d0
		beq.s	Tit_CountC
		cmpi.w	#9,(v_title_dcount).w
		beq.s	Tit_CountC
		move.w	#0,(v_title_dcount).w ; reset UDLR counter

Tit_CountC:
		move.b	(v_jpadpress1).w,d0
		andi.b	#btnC,d0	; is C button pressed?
		beq.s	loc_3230	; if not, branch
		addq.w	#1,(v_title_ccount).w ; increment C counter

loc_3230:
		tst.w	(v_demolength).w
		beq.w	GotoDemo
		andi.b	#btnStart,(v_jpadpress1).w ; check if Start is pressed
		beq.w	Tit_MainLoop	; if not, branch
        move.b  #id_Level,(v_gamemode).w     ; if not, play level		

Tit_ChkLevSel:
        tst.b    (f_levselcheat).w ; check if level select code is on
        beq.w    PlayLevel    ; -- Fixed an Issue with lifes displaying "0" by replacing GM_Level with PlayLevel // NaylenFresh
        btst    #bitA,(v_jpadhold1).w ; check if A is pressed
        beq.w    PlayLevel     ; -- Fixed an Issue with lifes displaying "0" by replacing GM_Level with PlayLevel // NaylenFresh
        jmp    (Level_Select_Menu).l    ; if yes, go to Sonic 2 level select
        moveq    #palid_LevelSel,d0
        bsr.w    PalLoad2    ; load level select palette
        lea    (v_hscrolltablebuffer).w,a1
        moveq    #0,d0
        move.w    #$DF,d1

Tit_ClrScroll1:
		move.l	d0,(a1)+
		dbf	d1,Tit_ClrScroll1 ; clear scroll data (in RAM)

		move.l	d0,(v_scrposy_dup).w
		disable_ints
		lea	(vdp_data_port).l,a6
		locVRAM	$E000
		move.w	#$3FF,d1

Tit_ClrScroll2:
		move.l	d0,(a6)
		dbf	d1,Tit_ClrScroll2 ; clear scroll data (in VRAM)

		bsr.w	LevSelTextLoad

PlayLevel:
		move.b	#id_Level,(v_gamemode).w ; set screen mode to $0C (level)
		move.b	#3,(v_lives).w	; set lives to 3
		moveq	#0,d0
		move.w	d0,(v_rings).w	; clear rings
		move.l	d0,(v_time).w	; clear time
		move.l	d0,(v_score).w	; clear score
		move.b	d0,(v_lastspecial).w ; clear special stage number
		move.b	d0,(v_emeralds).w ; clear emeralds
		move.l	d0,(v_emldlist).w ; clear emeralds
		move.l	d0,(v_emldlist+4).w ; clear emeralds
		move.b	d0,(v_continues).w ; clear continues
		if Revision<>0
			move.l	#5000,(v_scorelife).w ; extra life is awarded at 50000 points
		endif
		move.b	#bgm_Fade,d0
		bsr.w	PlaySound_Special ; fade out music
		rts	