; ---------------------------------------------------------------------------
; Sonic	graphics loading subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_LoadGfx:            ; XREF: Obj01_Control; et al
        moveq    #0,d0
        move.b    $1A(a0),d0    ; load frame number
        cmp.b    ($FFFFF766).w,d0
        beq.s    locret_13C96
        move.b    d0,($FFFFF766).w
        lea    (SonicDynPLC).l,a2
        add.w    d0,d0
        adda.w    (a2,d0.w),a2
        moveq    #0,d5
        move.b    (a2)+,d5
        subq.w    #1,d5
        bmi.s    locret_13C96
        move.w    #$F000,d4
        move.l    #Art_Sonic,d6

SPLC_ReadEntry:
        moveq    #0,d1
        move.b    (a2)+,d1
        lsl.w    #8,d1
        move.b    (a2)+,d1
        move.w    d1,d3
        lsr.w    #8,d3
        andi.w    #$F0,d3
        addi.w    #$10,d3
        andi.w    #$FFF,d1
        lsl.l    #5,d1
        add.l    d6,d1
        move.w    d4,d2
        add.w    d3,d4
        add.w    d3,d4
        jsr    (QueueDMATransfer).l
        dbf    d5,SPLC_ReadEntry    ; repeat for number of entries

locret_13C96:
        rts    
; End of function Sonic_LoadGfx