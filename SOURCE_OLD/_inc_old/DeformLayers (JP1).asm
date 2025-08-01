; ---------------------------------------------------------------------------
; Background layer deformation subroutines
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


DeformLayers:
		tst.b	(f_nobgscroll).w
		beq.s	.bgscroll
		rts	
; ===========================================================================

	.bgscroll:
		clr.w	(v_fg_scroll_flags).w
		clr.w	(v_bg1_scroll_flags).w
		clr.w	(v_bg2_scroll_flags).w
		clr.w	(v_bg3_scroll_flags).w
		bsr.w	ScrollHoriz
		bsr.w	ScrollVertical
		bsr.w	DynamicLevelEvents
		move.w	(v_screenposx).w,(v_scrposx_dup).w		
		move.w	(v_screenposy).w,(v_scrposy_dup).w
		move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w
		move.w	(v_bgscreenposx).w,(v_bgscreenposx_dup_unused).w
		move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w
		move.w	(v_bg3screenposx).w,(v_bg3screenposx_dup_unused).w
		move.w	(v_bg3screenposy).w,(v_bg3screenposy_dup_unused).w		
		moveq	#0,d0
		move.b	(v_zone).w,d0
		add.w	d0,d0
		move.w	Deform_Index(pc,d0.w),d0
		jmp	Deform_Index(pc,d0.w)
; End of function DeformLayers

; ===========================================================================
; ---------------------------------------------------------------------------
; Offset index for background layer deformation	code
; ---------------------------------------------------------------------------
Deform_Index:	dc.w Deform_GHZ-Deform_Index, Deform_LZ-Deform_Index
		dc.w Deform_MZ-Deform_Index, Deform_SLZ-Deform_Index
		dc.w Deform_SYZ-Deform_Index, Deform_SBZ-Deform_Index
		zonewarning Deform_Index,2
		dc.w Deform_GHZ-Deform_Index
; ---------------------------------------------------------------------------
; Green	Hill Zone background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

; ===========================================================================
; ---------------------------------------------------------------------------
; Deform scanlines correctly using a list
; ---------------------------------------------------------------------------

; ===========================================================================
; ---------------------------------------------------------------------------
; Deform scanlines correctly using a list
; ---------------------------------------------------------------------------

DeformScroll:
		lea	($FFFFCC00).w,a2			; load H-scroll buffer
		move.w	#$00E0,d7				; prepare number of scanlines
		move.w	($FFFFF70C).w,d6			; load Y position
		move.l	($FFFFF700).w,d1			; prepare FG X position
		neg.l	d1					; reverse position

DS_FindStart:
		move.w	(a0)+,d0				; load scroll speed address
		beq.s	DS_Last					; if the list is finished, branch
		movea.w	d0,a1					; set scroll speed address
		sub.w	(a0)+,d6				; subtract size
		bpl.s	DS_FindStart				; if we haven't reached the start, branch
		neg.w	d6					; get remaining size
		sub.w	d6,d7					; subtract from total screen size
		bmi.s	DS_EndSection				; if the screen is finished, branch

DS_NextSection:
		subq.w	#$01,d6					; convert for dbf
		move.w	(a1),d1					; load X position

DS_NextScanline:
		move.l	d1,(a2)+				; save scroll position
		dbf	d6,DS_NextScanline			; repeat for all scanlines
		move.w	(a0)+,d0				; load scroll speed address
		beq.s	DS_Last					; if the list is finished, branch
		movea.w	d0,a1					; set scroll speed address
		move.w	(a0)+,d6				; load size

DS_CheckSection:
		sub.w	d6,d7					; subtract from total screen size
		bpl.s	DS_NextSection				; if the screen is not finished, branch

DS_EndSection:
		add.w	d6,d7					; get remaining screen size and use that instead

DS_Last:
		subq.w	#$01,d7					; convert for dbf
		bmi.s	DS_Finish				; if finished, branch
		move.w	(a1),d1					; load X position

DS_LastScanlines:
		move.l	d1,(a2)+				; save scroll position
		dbf	d7,DS_LastScanlines			; repeat for all scanlines

DS_Finish:
		rts						; return

; ===========================================================================

; ===========================================================================


Deform_GHZ:
        cmpi.b    #id_Title,(v_gamemode).w
        beq.w    Deform_Title

Deform_GHZ_Stage:
  lea       ParallaxScriptGHZ, a1
   jmp       ExecuteParallaxScript

ParallaxScriptGHZ:

_normalGHZ = $0000
_movingGHZ = $0200
_linearGHZ = $0400

   ;        Mode           Speed/dist       Number of lines
   dc.w   _movingGHZ,       $0040,           48               ; ''
   dc.w   _movingGHZ|$1,       $0030,           23               ; ''  
   dc.w   _movingGHZ|$2,       $0025,           10               ; ''    
   dc.w   _normalGHZ,       $0010,           69               ; '' 
   dc.w   _linearGHZ,       $0003,           74               ; ''    
   dc.w   -1
; End of function Deform_GHZ

; ---------------------------------------------------------------------------
; Labyrinth Zone background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

DeformScrollTitle:
		lea	($FFFFCC00).w,a2			; load H-scroll buffer
		move.w	#$00E0,d7				; prepare number of scanlines
		move.w	($FFFFF70C).w,d6			; load Y position
;		move.l	($FFFFF700).w,d1			; prepare FG X position
		neg.l	d1					; reverse position

DS_FindStartTitle:
		move.w	(a0)+,d0				; load scroll speed address
		beq.s	DS_LastTitle					; if the list is finished, branch
		movea.w	d0,a1					; set scroll speed address
		sub.w	(a0)+,d6				; subtract size
		bpl.s	DS_FindStartTitle				; if we haven't reached the start, branch
		neg.w	d6					; get remaining size
		sub.w	d6,d7					; subtract from total screen size
		bmi.s	DS_EndSectionTitle				; if the screen is finished, branch

DS_NextSectionTitle:
		subq.w	#$01,d6					; convert for dbf
		move.w	(a1),d1					; load X position

DS_NextScanlineTitle:
		move.l	d1,(a2)+				; save scroll position
		dbf	d6,DS_NextScanlineTitle			; repeat for all scanlines
		move.w	(a0)+,d0				; load scroll speed address
		beq.s	DS_Last					; if the list is finished, branch
		movea.w	d0,a1					; set scroll speed address
		move.w	(a0)+,d6				; load size

DS_CheckSectionTitle:
		sub.w	d6,d7					; subtract from total screen size
		bpl.s	DS_NextSectionTitle				; if the screen is not finished, branch

DS_EndSectionTitle:
		add.w	d6,d7					; get remaining screen size and use that instead

DS_LastTitle:
		subq.w	#$01,d7					; convert for dbf
		bmi.s	DS_FinishTitle				; if finished, branch
		move.w	(a1),d1					; load X position

DS_LastScanlinesTitle:
		move.l	d1,(a2)+				; save scroll position
		dbf	d7,DS_LastScanlinesTitle			; repeat for all scanlines

DS_FinishTitle:
		rts						; return

Deform_Title:

;		cmpi.b	#id_Title,(v_gamemode).w
;		moveq	#0,d0	; reset foreground position in title screen

;		moveq	#$00,d4					; set no X movement redraw
		move.w	($FFFFF73C).w,d5			; load Y movement
		ext.l	d5					; extend to long-word
;		asl.l	#$01,d5					; multiply by 100, then divide by 2
		bsr.w	ScrollBlock2				; perform redraw for Y
        move.w #0,($FFFFF70C).w ; lock the background vertically in place		
		move.w	($FFFFF70C).w,($FFFFF618).w		; save as VSRAM BG scroll position

		move.w	($FFFFF708).w,d0			; load X position
		neg.w	d0					; reverse direction
		move.w	($FFFFFE0E).w,d0			; load X position			
		muls.w	#$01,d0					; divide by 8
		move.w	d0,($FFFFC800).w			; set speed 1

		move.w	($FFFFF708).w,d0			; load X position
		neg.w	d0					; reverse direction
		move.w	($FFFFFE0E).w,d0			; load X position		
		muls.w	#$02,d0					; divide by 4
		move.w	d0,($FFFFC802).w			; set speed 2
		
		move.w	($FFFFF708).w,d0			; load X position
		neg.w	d0					; reverse direction
		move.w	($FFFFFE0E).w,d0			; load X position		
		muls.w	#$03,d0					; divide by 4
		move.w	d0,($FFFFC804).w			; set speed 2		

		lea	DTITLESCREEN(pc),a0			; load scroll data to use
		bra.w	DeformScrollTitle				; continue

; ---------------------------------------------------------------------------
; Scroll data
; ---------------------------------------------------------------------------

DTITLESCREEN:	dc.w	$C804,  $40				; top 70 scroll
		dc.w	$C802,  $10				; bottom 70 scroll
        dc.w	$C800,  $10				; top 70 scroll		
		dc.w	$C802,  $10				; bottom 70 scroll
        dc.w	$C800,  $10				; top 70 scroll		
		dc.w	$C802,  $10				; bottom 70 scroll
        dc.w	$C800,  $10				; top 70 scroll		
		dc.w	$C802,  $10				; bottom 70 scroll	
	    dc.w	$C804,  $40				; top 70 scroll		
		dc.w	$0000

Deform_LZ:
  lea       ParallaxScript, a1
   jmp       ExecuteParallaxScript

ParallaxScript:

_normal = $0000
_moving = $0200
_linear = $0400

   ;        Mode           Speed/dist       Number of lines
   dc.w   _normal,       $0040,           48               ; ''
   dc.w   _normal,       $0030,           23               ; ''  
   dc.w   _normal,       $0020,           10               ; ''    
   dc.w   _normal,       $0005,           60               ; '' 
   dc.w   _normal,       $0020,           11               ; ''  
   dc.w   _normal,       $0030,           24               ; '' 
   dc.w   _normal,       $0040,           48               ; ''    
   dc.w   -1
; End of function Deform_LZ

; ---------------------------------------------------------------------------
; Marble Zone background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

; ===========================================================================

Deform_MZ:
  lea       ParallaxScriptMZ, a1
   jmp       ExecuteParallaxScript
   
ParallaxScriptMZ:

   ;        Mode           Speed/dist       Number of lines
   dc.w   _moving,       $0060,           32               ; ''
   dc.w   _moving|$1,       $0030,           9               ; ''  
   dc.w   _normal,       $0015,           19              ; ''    
   dc.w   _normal,       $0020,           23               ; '' 
   dc.w   _normal,       $0030,           22               ; ''  
   dc.w   _normal,       $0040,           32               ; '' 
   dc.w   _normal,       $0050,           90               ; ''    
   dc.w   -1   


; End of function Deform_MZ

; ---------------------------------------------------------------------------
; Star Light Zone background layer deformation code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_SLZ:
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#5,d4
		move.w	(v_scrshifty).w,d5
		ext.l	d5
		asl.l	#5,d5
		bsr.w	BGScroll_XY
		move.w	(v_bgscreenposy).w,(v_bgscrposy_dup).w
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#223,d1
		move.w	(v_screenposx).w,d0
		neg.w	d0
		swap	d0
		move.w	(v_bgscreenposx).w,d0
		neg.w	d0

loc_63C6A:
		move.l	d0,(a1)+
		dbf	d1,loc_63C6A
		move.w	(v_waterpos1).w,d0
		sub.w	(v_screenposy).w,d0
		rts	
;-------------------------------------------------------------------------------
;-------------------------------------------------------------------------------
Bg_Scroll_X:
		lea	(v_hscrolltablebuffer).w,a1
		move.w	#$E,d1
		move.w	(v_screenposx).w,d0
		neg.w	d0
		swap	d0
		andi.w	#$F,d2
		add.w	d2,d2
		move.w	(a2)+,d0
		jmp	.pixelJump(pc,d2.w)		; skip pixels for first row
	.blockLoop:
		move.w	(a2)+,d0
	.pixelJump:		
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		move.l	d0,(a1)+
		dbf	d1,.blockLoop
		rts

; ---------------------------------------------------------------------------
; Spring Yard Zone background layer deformation	code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_SYZ:
  lea       ParallaxScriptSYZ, a1
   jmp       ExecuteParallaxScript

ParallaxScriptSYZ:

_normalSYZ = $0000
_movingSYZ = $0200
_linearSYZ = $0400

   ;        Mode           Speed/dist       Number of lines
   dc.w   _movingSYZ,       $0040,           48               ; ''
   dc.w   _movingSYZ|$1,       $0030,           23               ; ''  
   dc.w   _movingSYZ|$2,       $0025,           10               ; ''    
   dc.w   _normalSYZ,       $0025,           69               ; '' 
   dc.w   _normalSYZ,       $0035,           24               ; '' 
   dc.w   _normalSYZ,       $0045,           18               ; ''  
   dc.w   _normalSYZ,       $0055,           23               ; ''
   dc.w   _normalSYZ,       $0065,           10               ; ''     
   dc.w   -1

; ===========================================================================

		
; End of function Deform_SYZ

; ---------------------------------------------------------------------------
; Scrap	Brain Zone background layer deformation	code
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Deform_SBZ:
		tst.b	(v_act).w
		bne.w	Deform_SBZ2
	; block 1 - lower black buildings
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#7,d4
		moveq	#2,d6
		bsr.w	BGScroll_Block1
	; block 3 - distant brown buildings
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#6,d4
		moveq	#6,d6
		bsr.w	BGScroll_Block3
	; block 2 - upper black buildings
		move.w	(v_scrshiftx).w,d4
		ext.l	d4
		asl.l	#5,d4
		move.l	d4,d1
		asl.l	#1,d4
		add.l	d1,d4
		moveq	#4,d6
		bsr.w	BGScroll_Block2
	; vertical scrolling
		moveq	#0,d4
		move.w	(v_scrshifty).w,d5
		ext.l	d5
		asl.l	#5,d5
		bsr.w	BGScroll_YRelative

		move.w	(v_bgscreenposy).w,d0
		move.w	d0,(v_bg2screenposy).w
		move.w	d0,(v_bg3screenposy).w
		move.w	d0,(v_bgscrposy_dup).w
		move.b	(v_bg1_scroll_flags).w,d0
		or.b	(v_bg3_scroll_flags).w,d0
		or.b	d0,(v_bg2_scroll_flags).w
		clr.b	(v_bg1_scroll_flags).w
		clr.b	(v_bg3_scroll_flags).w
	; calculate background scroll buffer
		lea	(v_bgscroll_buffer).w,a1
		move.w	(v_screenposx).w,d2
		neg.w	d2
		asr.w	#2,d2
		move.w	d2,d0
		asr.w	#1,d0
		sub.w	d2,d0
		ext.l	d0
		asl.l	#3,d0
		divs.w	#4,d0
		ext.l	d0
		asl.l	#4,d0
		asl.l	#8,d0
		moveq	#0,d3
		move.w	d2,d3
		move.w	#3,d1
	.cloudLoop:		
		move.w	d3,(a1)+
		swap	d3
		add.l	d0,d3
		swap	d3
		dbf	d1,.cloudLoop

		move.w	(v_bg3screenposx).w,d0
		neg.w	d0
		move.w	#9,d1
	.buildingLoop1:		; distant brown buildings
		move.w	d0,(a1)+
		dbf	d1,.buildingLoop1

		move.w	(v_bg2screenposx).w,d0
		neg.w	d0
		move.w	#6,d1
	.buildingLoop2:		; upper black buildings
		move.w	d0,(a1)+
		dbf	d1,.buildingLoop2

		move.w	(v_bgscreenposx).w,d0
		neg.w	d0
		move.w	#$A,d1
	.buildingLoop3:		; lower black buildings
		move.w	d0,(a1)+
		dbf	d1,.buildingLoop3
		lea	(v_bgscroll_buffer).w,a2
		move.w	(v_bgscreenposy).w,d0
		move.w	d0,d2
		andi.w	#$1F0,d0
		lsr.w	#3,d0
		lea	(a2,d0.w),a2
		bra.w	Bg_Scroll_X
;-------------------------------------------------------------------------------
Deform_SBZ2:;loc_68A2:
   lea       ParallaxScript_SBZ2, a1
   jmp       ExecuteParallaxScript

ParallaxScript_SBZ2:

_normal3 = $0000
_moving3 = $0200
_linear3 = $0400

   ;        Mode           Speed/dist       Number of lines	   
   dc.w   _moving3,       $0000,           10                ; Stars (6 layers)
   dc.w   _moving3|$0,       $0000,           10                ; Stars (6 layers)
   dc.w   _moving3|$1,       $0000,           10                ; Stars (6 layers)   
   dc.w   _moving3|$0,       $0000,           10                ; Stars (6 layers)   
   dc.w   _moving3|$1,       $0000,           10                ; Stars (6 layers)   
   dc.w   _moving3|$0,       $0000,           10                ; Stars (6 layers)   
   dc.w   _moving3|$1,       $0000,           10                ; Stars (6 layers)   
   dc.w   _moving3|$1,       $0000,           10                ; Stars (6 layers)   
   dc.w   _moving3|$0,       $0000,           10                ; Stars (6 layers)   
   dc.w   _moving3|$1,       $0000,           10                ; Stars (6 layers)   
   dc.w   _moving3|$0,       $0000,           10                ; Stars (6 layers)      
   dc.w   _moving3|$1,       $0000,           30                ; Stars (6 layers)     
   dc.w   _normal3,       $0025,           28                ; Stars (6 layers)   
   dc.w   _normal3,       $0020,           66                ; Stars (6 layers)     
   dc.w   -1
; End of function Deform_SBZ

; ---------------------------------------------------------------------------
; Subroutine to	scroll the level horizontally as Sonic moves
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollHoriz:
		move.w	(v_screenposx).w,d4 ; save old screen position
		bsr.s	MoveScreenHoriz
		move.w	(v_screenposx).w,d0
		andi.w	#$10,d0
		move.b	(v_fg_xblock).w,d1
		eor.b	d1,d0
		bne.s	.return
		eori.b	#$10,(v_fg_xblock).w
		move.w	(v_screenposx).w,d0
		sub.w	d4,d0		; compare new with old screen position
		bpl.s	.scrollRight

		bset	#2,(v_fg_scroll_flags).w ; screen moves backward
		rts	

	.scrollRight:
		bset	#3,(v_fg_scroll_flags).w ; screen moves forward

	.return:
		rts	
; End of function ScrollHoriz


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


MoveScreenHoriz:
		move.w	(v_player+obX).w,d0
		sub.w	(v_screenposx).w,d0 ; Sonic's distance from left edge of screen
		subi.w	#144,d0		; is distance less than 144px?
		bcs.s	SH_BehindMid	; if yes, branch
		subi.w	#16,d0		; is distance more than 160px?
		bcc.s	SH_AheadOfMid	; if yes, branch
		clr.w	(v_scrshiftx).w
		rts	
; ===========================================================================

SH_AheadOfMid:
		cmpi.w	#16,d0		; is Sonic within 16px of middle area?
		bcs.s	SH_Ahead16	; if yes, branch
		move.w	#16,d0		; set to 16 if greater

SH_Ahead16:
		add.w	(v_screenposx).w,d0
		cmp.w	(v_limitright2).w,d0
		blt.s	SH_SetScreen
		move.w	(v_limitright2).w,d0

SH_SetScreen:
		move.w	d0,d1
		sub.w	(v_screenposx).w,d1
		asl.w	#8,d1
		move.w	d0,(v_screenposx).w ; set new screen position
		move.w	d1,(v_scrshiftx).w ; set distance for screen movement
		rts	
; ===========================================================================

SH_BehindMid:
		add.w	(v_screenposx).w,d0
		cmp.w	(v_limitleft2).w,d0
		bgt.s	SH_SetScreen
		move.w	(v_limitleft2).w,d0
		bra.s	SH_SetScreen
; End of function MoveScreenHoriz

; ===========================================================================
		tst.w	d0
		bpl.s	loc_6610
		move.w	#-2,d0
		bra.s	SH_BehindMid

loc_6610:
		move.w	#2,d0
		bra.s	SH_AheadOfMid

; ---------------------------------------------------------------------------
; Subroutine to	scroll the level vertically as Sonic moves
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollVertical:
		moveq	#0,d1
		move.w	(v_player+obY).w,d0
		sub.w	(v_screenposy).w,d0 ; Sonic's distance from top of screen
		btst	#2,(v_player+obStatus).w ; is Sonic rolling?
		beq.s	SV_NotRolling	; if not, branch
		subq.w	#5,d0

SV_NotRolling:
		btst	#1,(v_player+obStatus).w ; is Sonic jumping?
		beq.s	loc_664A	; if not, branch

		addi.w	#32,d0
		sub.w	(v_lookshift).w,d0
		bcs.s	loc_6696
		subi.w	#64,d0
		bcc.s	loc_6696
		tst.b	(f_bgscrollvert).w
		bne.s	loc_66A8
		bra.s	loc_6656
; ===========================================================================

loc_664A:
		sub.w	(v_lookshift).w,d0
		bne.s	loc_665C
		tst.b	(f_bgscrollvert).w
		bne.s	loc_66A8

loc_6656:
		clr.w	(v_scrshifty).w
		rts	
; ===========================================================================

loc_665C:
		cmpi.w	#$60,(v_lookshift).w
		bne.s	loc_6684
		move.w	(v_player+obInertia).w,d1
		bpl.s	loc_666C
		neg.w	d1

loc_666C:
		cmpi.w	#$800,d1
		bcc.s	loc_6696
		move.w	#$600,d1
		cmpi.w	#6,d0
		bgt.s	loc_66F6
		cmpi.w	#-6,d0
		blt.s	loc_66C0
		bra.s	loc_66AE
; ===========================================================================

loc_6684:
		move.w	#$200,d1
		cmpi.w	#2,d0
		bgt.s	loc_66F6
		cmpi.w	#-2,d0
		blt.s	loc_66C0
		bra.s	loc_66AE
; ===========================================================================

loc_6696:
		move.w	#$1000,d1
		cmpi.w	#$10,d0
		bgt.s	loc_66F6
		cmpi.w	#-$10,d0
		blt.s	loc_66C0
		bra.s	loc_66AE
; ===========================================================================

loc_66A8:
		moveq	#0,d0
		move.b	d0,(f_bgscrollvert).w

loc_66AE:
		moveq	#0,d1
		move.w	d0,d1
		add.w	(v_screenposy).w,d1
		tst.w	d0
		bpl.w	loc_6700
		bra.w	loc_66CC
; ===========================================================================

loc_66C0:
		neg.w	d1
		ext.l	d1
		asl.l	#8,d1
		add.l	(v_screenposy).w,d1
		swap	d1

loc_66CC:
		cmp.w	(v_limittop2).w,d1
		bgt.s	loc_6724
		cmpi.w	#-$100,d1
		bgt.s	loc_66F0
		andi.w	#$7FF,d1
		andi.w	#$7FF,(v_player+obY).w
		andi.w	#$7FF,(v_screenposy).w
		andi.w	#$3FF,(v_bgscreenposy).w
		bra.s	loc_6724
; ===========================================================================

loc_66F0:
		move.w	(v_limittop2).w,d1
		bra.s	loc_6724
; ===========================================================================

loc_66F6:
		ext.l	d1
		asl.l	#8,d1
		add.l	(v_screenposy).w,d1
		swap	d1

loc_6700:
		cmp.w	(v_limitbtm2).w,d1
		blt.s	loc_6724
		subi.w	#$800,d1
		bcs.s	loc_6720
		andi.w	#$7FF,(v_player+obY).w
		subi.w	#$800,(v_screenposy).w
		andi.w	#$3FF,(v_bgscreenposy).w
		bra.s	loc_6724
; ===========================================================================

loc_6720:
		move.w	(v_limitbtm2).w,d1

loc_6724:
		move.w	(v_screenposy).w,d4
		swap	d1
		move.l	d1,d3
		sub.l	(v_screenposy).w,d3
		ror.l	#8,d3
		move.w	d3,(v_scrshifty).w
		move.l	d1,(v_screenposy).w
		move.w	(v_screenposy).w,d0
		andi.w	#$10,d0
		move.b	(v_fg_yblock).w,d1
		eor.b	d1,d0
		bne.s	.return
		eori.b	#$10,(v_fg_yblock).w
		move.w	(v_screenposy).w,d0
		sub.w	d4,d0
		bpl.s	.scrollBottom
		bset	#0,(v_fg_scroll_flags).w
		rts	
; ===========================================================================

	.scrollBottom:
		bset	#1,(v_fg_scroll_flags).w

	.return:
		rts	
; End of function ScrollVertical


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||
; Scrolls background and sets redraw flags.
; d4 - background x offset * $10000
; d5 - background y offset * $10000

BGScroll_XY:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bgscreenposx).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg1_xblock).w,d3
		eor.b	d3,d1
		bne.s	BGScroll_YRelative	; no change in Y
		eori.b	#$10,(v_bg1_xblock).w
		sub.l	d2,d0	; new - old
		bpl.s	.scrollRight
		bset	#2,(v_bg1_scroll_flags).w
		bra.s	BGScroll_YRelative
	.scrollRight:
		bset	#3,(v_bg1_scroll_flags).w
BGScroll_YRelative:
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg1_yblock).w,d2
		eor.b	d2,d1
		bne.s	.return
		eori.b	#$10,(v_bg1_yblock).w
		sub.l	d3,d0
		bpl.s	.scrollBottom
		bset	#0,(v_bg1_scroll_flags).w
		rts
	.scrollBottom:
		bset	#1,(v_bg1_scroll_flags).w
	.return:
		rts
; End of function BGScroll_XY

Bg_Scroll_Y:
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg1_yblock).w,d2
		eor.b	d2,d1
		bne.s	.return
		eori.b	#$10,(v_bg1_yblock).w
		sub.l	d3,d0
		bpl.s	.scrollBottom
		bset	#4,(v_bg1_scroll_flags).w
		rts
	.scrollBottom:
		bset	#5,(v_bg1_scroll_flags).w
	.return:
		rts


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BGScroll_YAbsolute:
		move.w	(v_bgscreenposy).w,d3
		move.w	d0,(v_bgscreenposy).w
		move.w	d0,d1
		andi.w	#$10,d1
		move.b	(v_bg1_yblock).w,d2
		eor.b	d2,d1
		bne.s	.return
		eori.b	#$10,(v_bg1_yblock).w
		sub.w	d3,d0
		bpl.s	.scrollBottom
		bset	#0,(v_bg1_scroll_flags).w
		rts
	.scrollBottom:
		bset	#1,(v_bg1_scroll_flags).w
	.return:
		rts
; End of function BGScroll_YAbsolute


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||
; d6 - bit to set for redraw

BGScroll_Block1:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bgscreenposx).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg1_xblock).w,d3
		eor.b	d3,d1
		bne.s	.return
		eori.b	#$10,(v_bg1_xblock).w
		sub.l	d2,d0
		bpl.s	.scrollRight
		bset	d6,(v_bg1_scroll_flags).w
		bra.s	.return
	.scrollRight:
		addq.b	#1,d6
		bset	d6,(v_bg1_scroll_flags).w
	.return:
		rts
; End of function BGScroll_Block1


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


BGScroll_Block2:
		move.l	(v_bg2screenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bg2screenposx).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg2_xblock).w,d3
		eor.b	d3,d1
		bne.s	.return
		eori.b	#$10,(v_bg2_xblock).w
		sub.l	d2,d0
		bpl.s	.scrollRight
		bset	d6,(v_bg2_scroll_flags).w
		bra.s	.return
	.scrollRight:
		addq.b	#1,d6
		bset	d6,(v_bg2_scroll_flags).w
	.return:
		rts
;-------------------------------------------------------------------------------
BGScroll_Block3:
		move.l	(v_bg3screenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bg3screenposx).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	(v_bg3_xblock).w,d3
		eor.b	d3,d1
		bne.s	.return
		eori.b	#$10,(v_bg3_xblock).w
		sub.l	d2,d0
		bpl.s	.scrollRight
		bset	d6,(v_bg3_scroll_flags).w
		bra.s	.return
	.scrollRight:
		addq.b	#1,d6
		bset	d6,(v_bg3_scroll_flags).w
	.return:
		rts

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock1:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bgscreenposx).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	($FFFFF74C).w,d3
		eor.b	d3,d1
		bne.s	loc_679C
		eori.b	#$10,($FFFFF74C).w
		sub.l	d2,d0
		bpl.s	loc_6796
		bset	#2,(v_bg1_scroll_flags).w
		bra.s	loc_679C
; ===========================================================================

loc_6796:
		bset	#3,(v_bg1_scroll_flags).w

loc_679C:
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	($FFFFF74D).w,d2
		eor.b	d2,d1
		bne.s	locret_67D0
		eori.b	#$10,($FFFFF74D).w
		sub.l	d3,d0
		bpl.s	loc_67CA
		bset	#0,(v_bg1_scroll_flags).w
		rts	
; ===========================================================================

loc_67CA:
		bset	#1,(v_bg1_scroll_flags).w

locret_67D0:
		rts	
; End of function ScrollBlock1


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock2:
		move.l	(v_bgscreenposx).w,d2
		move.l	d2,d0
		add.l	d4,d0
		move.l	d0,(v_bgscreenposx).w
		move.l	(v_bgscreenposy).w,d3
		move.l	d3,d0
		add.l	d5,d0
		move.l	d0,(v_bgscreenposy).w
		move.l	d0,d1
		swap	d1
		andi.w	#$10,d1
		move.b	($FFFFF74D).w,d2
		eor.b	d2,d1
		bne.s	locret_6812
		eori.b	#$10,($FFFFF74D).w
		sub.l	d3,d0
		bpl.s	loc_680C
		bset	#0,(v_bg1_scroll_flags).w
		rts	
; ===========================================================================

loc_680C:
		bset	#1,(v_bg1_scroll_flags).w

locret_6812:
		rts	
; End of function ScrollBlock2


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock3:
		move.w	(v_bgscreenposy).w,d3
		move.w	d0,(v_bgscreenposy).w
		move.w	d0,d1
		andi.w	#$10,d1
		move.b	($FFFFF74D).w,d2
		eor.b	d2,d1
		bne.s	locret_6842
		eori.b	#$10,($FFFFF74D).w
		sub.w	d3,d0
		bpl.s	loc_683C
		bset	#0,(v_bg1_scroll_flags).w
		rts	
; ===========================================================================

loc_683C:
		bset	#1,(v_bg1_scroll_flags).w

locret_6842:
		rts	
; End of function ScrollBlock3


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ScrollBlock4:
		move.w	(v_bg2screenposx).w,d2
		move.w	(v_bg2screenposy).w,d3
		move.w	(v_scrshiftx).w,d0
		ext.l	d0
		asl.l	#7,d0
		add.l	d0,(v_bg2screenposx).w
		move.w	(v_bg2screenposx).w,d0
		andi.w	#$10,d0
		move.b	($FFFFF74E).w,d1
		eor.b	d1,d0
		bne.s	locret_6884
		eori.b	#$10,($FFFFF74E).w
		move.w	(v_bg2screenposx).w,d0
		sub.w	d2,d0
		bpl.s	loc_687E
		bset	#2,(v_bg2_scroll_flags).w
		bra.s	locret_6884
; ===========================================================================

loc_687E:
		bset	#3,(v_bg2_scroll_flags).w

locret_6884:
		rts	
; End of function ScrollBlock4

