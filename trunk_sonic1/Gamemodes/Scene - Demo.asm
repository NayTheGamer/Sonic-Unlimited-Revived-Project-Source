; ---------------------------------------------------------------------------
; Demo mode
; ---------------------------------------------------------------------------

GotoDemo:
		move.w	#$1E,(v_demolength).w

loc_33B6:
		move.b	#4,(v_vbla_routine).w
		bsr.w	WaitForVBla
		bsr.w	DeformLayers
		bsr.w	PaletteCycle
		bsr.w	RunPLC
		move.w	(v_objspace+obX).w,d0
		addq.w	#2,d0
		move.w	d0,(v_objspace+obX).w
		cmpi.w	#$1C00,d0
		blo.s	loc_33E4
		move.b	#id_Sega,(v_gamemode).w
		rts	
; ===========================================================================

loc_33E4:
		andi.b	#btnStart,(v_jpadpress1).w ; is Start button pressed?
		bne.w	Tit_ChkLevSel	; if yes, branch
		tst.w	(v_demolength).w
		bne.w	loc_33B6
		move.b	#bgm_Fade,d0
		bsr.w	PlaySound_Special ; fade out music
		move.w	(v_demonum).w,d0 ; load	demo number
		andi.w	#7,d0
		add.w	d0,d0
		move.w	Demo_Levels(pc,d0.w),d0	; load level number for	demo
		move.w	d0,(v_zone).w
		addq.w	#1,(v_demonum).w ; add 1 to demo number
		cmpi.w	#4,(v_demonum).w ; is demo number less than 4?
		blo.s	loc_3422	; if yes, branch
		move.w	#0,(v_demonum).w ; reset demo number to	0

loc_3422:
		move.w	#1,(f_demo).w	; turn demo mode on
		move.b	#id_Demo,(v_gamemode).w ; set screen mode to 08 (demo)
		cmpi.w	#$600,d0	; is level number 0600 (special	stage)?
		bne.s	Demo_Level	; if not, branch
		move.b	#id_Special,(v_gamemode).w ; set screen mode to $10 (Special Stage)
		clr.w	(v_zone).w	; clear	level number
		clr.b	(v_lastspecial).w ; clear special stage number

Demo_Level:
		move.b	#3,(v_lives).w	; set lives to 3
		moveq	#0,d0
		move.w	d0,(v_rings).w	; clear rings
		move.l	d0,(v_time).w	; clear time
		move.l	d0,(v_score).w	; clear score
		if Revision<>0
			move.l	#5000,(v_scorelife).w ; extra life is awarded at 50000 points
		endif
		rts	
; ===========================================================================
; ---------------------------------------------------------------------------
; Levels used in demos
; ---------------------------------------------------------------------------
Demo_Levels:	binclude	"misc/Demo Level Order - Intro.bin"
		even
		
		