GotThroughCard_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     GotThroughCard_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $02, $07

	smpsHeaderDAC       GotThroughCard_DAC
	smpsHeaderFM        GotThroughCard_FM1,	$02, $08
	smpsHeaderFM        GotThroughCard_FM2,	$02, $0C
	smpsHeaderFM        GotThroughCard_FM3,	$02, $13
	smpsHeaderFM        GotThroughCard_FM4,	$02, $12
	smpsHeaderFM        GotThroughCard_FM5,	$02, $12
	smpsHeaderPSG       GotThroughCard_PSG1,	$DE, $03, $00, $00
	smpsHeaderPSG       GotThroughCard_PSG2,	$DE, $04, $00, $00
	smpsHeaderPSG       GotThroughCard_PSG3,	$00, $00, $00, fTone_04

; FM1 Data
GotThroughCard_FM1:
	smpsSetvoice        $03
	smpsPSGvoice        fTone_01
	smpsModSet          $03, $01, $14, $05
	smpsPan             panCenter, $00
	dc.b	nC2, $09, nC3, nD3, nBb2, nF2, $06, nF3, nAb2, $09, nAb3, nAb2
	dc.b	$06, nBb2, $03, nBb3, nBb3, nBb2, nBb3, nF3, nBb2, nBb3, nC3, nC2
	dc.b	nC2, nC2, nRst, nRst, nC3, nC2, nC2, nC3, nRst, nRst
	smpsSetvoice        $00
	dc.b	nC2, $48, nRst
	smpsStop

; FM2 Data
GotThroughCard_FM2:
	smpsModSet          $2E, $01, $10, $03
	smpsSetvoice        $01
	smpsPSGvoice        fTone_01
	smpsPan             panCenter, $00
	dc.b	nC5, $09, nG5, nBb5, nA5, nF5, $06, nC5, nG5, $09, nF5, nEb5
	dc.b	nD5, nRst, $03, nD5, nEb5, nF5
	smpsSetvoice        $09
	dc.b	nC5, nC5, nC5, nC5, nRst, nRst, nC5, nC5, nC5, nC5

GotThroughCard_Loop02:
	smpsAlterVol        $08
	dc.b	nC5, nC5
	smpsLoop            $00, $0A, GotThroughCard_Loop02
	dc.b	nRst
	smpsStop

; FM3 Data
GotThroughCard_FM3:
	smpsSetvoice        $08
	smpsAlterPitch      $0C
	dc.b	nC4, $03, nF4, nG4, nF5, nG5, nC6, nF6, nG6, nC6, nG6, nF6
	dc.b	nC5, nG4, nF4, nC4, nG3, nC3, nEb3, nAb3, nC4, nEb4, nAb4, nC5
	dc.b	nAb4, nF5, nD5, nBb4, nF4, nD4, nF4, nBb3, nF4
	smpsAlterVol        $FD
	dc.b	nG4, nG4, nG4, nG4, nG4, nRst, nG4, nG4, nG4, nG4, nRst, nRst
	smpsAlterPitch      $F4
	smpsModSet          $03, $01, $14, $05
	smpsSetvoice        $00
	dc.b	nRst, $02
	smpsAlterNote       $02
	dc.b	nC2, $48, nRst
	smpsStop

; FM4 Data
GotThroughCard_FM4:
	smpsModSet          $2E, $01, $10, $03
	smpsSetvoice        $06
	smpsPSGvoice        fTone_01
	dc.b	nRst, $01, nG4, $09, nC5, nD5, nBb4, nA4, $06, nF4, nAb4, $09
	dc.b	nEb4, nAb4, nBb4, nF4, $06, nD5, nE5, $03, nE5, nE5, nE5, nRst
	dc.b	nRst, nE5, nE5, nE5, nE5

GotThroughCard_Loop01:
	smpsAlterVol        $09
	dc.b	nE5, nE5
	smpsLoop            $00, $0A, GotThroughCard_Loop01
	dc.b	nRst
	smpsStop

; FM5 Data
GotThroughCard_FM5:
	smpsModSet          $2E, $01, $10, $03
	smpsSetvoice        $07
	smpsPSGvoice        fTone_01
	dc.b	nRst, $01
	smpsAlterNote       $01
	smpsAlterVol        $F4
	smpsPan             panCenter, $00
	dc.b	nC4, $09, nG4, nBb4, nA4, nF4, $06, nC4, nG4, $09, nF4, nEb4
	dc.b	nD4, nRst, $03, nD4, nEb4, nF4
	smpsAlterVol        $0C
	smpsSetvoice        $05
	smpsPan             panRight, $00
	smpsAlterVol        $08
	dc.b	nC6, nC6, nC6, nC6, nRst, nRst, nC6, nC6, nC6, nC6

GotThroughCard_Loop00:
	smpsAlterVol        $09
	dc.b	nG5, nG5
	smpsLoop            $00, $0A, GotThroughCard_Loop00
	dc.b	nRst
	smpsStop

; DAC Data
GotThroughCard_DAC:
	smpsPan             panCenter, $00
	dc.b	dKick, $03, dSnare, dSnare, dKick, dLowTimpani, dVLowTimpani, dKick, dSnare, dLowTimpani, dVLowTimpani, dKick
	dc.b	dMidTimpani, dLowTimpani, dVLowTimpani, dKick, dSnare, dSnare, dKick, dKick, dSnare, dKick, dSnare, dSnare
	dc.b	dKick, dKick, $02, dMidTimpani, dLowTimpani, dLowTimpani, dVLowTimpani, dVLowTimpani, dSnare, $03, dSnare, dKick
	dc.b	dSnare, dKick, $03, dLowTimpani, dClap, $02, dVLowTimpani, dKick, dKick, $03, dKick, dClap
	dc.b	dClap, dKick, dClap, nRst, nRst, dKick, $0C
	smpsStop

; PSG1 Data
GotThroughCard_PSG1:
	dc.b	nC5, $09, nG5, nBb5, nA5, nF5, $06, nC5, nG5, $09, nF5, nEb5
	dc.b	nD5, nRst, $03, nD5, nEb5, nF5
	smpsPSGAlterVol     $02
	dc.b	nC6, nC6, nC6, nC6, nRst, nRst, nC6, nC6, nC6, nC6, nRst, $06
	smpsStop

; PSG2 Data
GotThroughCard_PSG2:
	smpsAlterNote       $02
	dc.b	nRst, $04
	smpsJump            GotThroughCard_PSG1

; PSG3 Data
GotThroughCard_PSG3:
	smpsPSGform         $E7
	dc.b	nMaxPSG, $0C, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, $0C, nMaxPSG, nMaxPSG, nMaxPSG, nMaxPSG, $0C
	dc.b	nMaxPSG, nMaxPSG, $06, nMaxPSG, $02, nMaxPSG, nMaxPSG, nRst, $30
	smpsStop

GotThroughCard_Voices:
;	Voice $00
;	$4D
;	$70, $31, $54, $71, 	$8F, $1F, $1F, $7F, 	$1F, $15, $16, $16
;	$07, $07, $08, $08, 	$1F, $1F, $0F, $1F, 	$00, $03, $03, $03
	smpsVcAlgorithm     $05
	smpsVcFeedback      $01
	smpsVcUnusedBits    $01
	smpsVcDetune        $07, $05, $03, $07
	smpsVcCoarseFreq    $01, $04, $01, $00
	smpsVcRateScale     $01, $00, $00, $02
	smpsVcAttackRate    $3F, $1F, $1F, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $16, $16, $15, $1F
	smpsVcDecayRate2    $08, $08, $07, $07
	smpsVcDecayLevel    $01, $00, $01, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $03, $03, $03, $00

;	Voice $01
;	$6C
;	$71, $33, $35, $7F, 	$1E, $1F, $1F, $1F, 	$0C, $0A, $07, $0E
;	$0C, $01, $07, $01, 	$FF, $FF, $FF, $FF, 	$02, $00, $0F, $01
	smpsVcAlgorithm     $04
	smpsVcFeedback      $05
	smpsVcUnusedBits    $01
	smpsVcDetune        $07, $03, $03, $07
	smpsVcCoarseFreq    $0F, $05, $03, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0E, $07, $0A, $0C
	smpsVcDecayRate2    $01, $07, $01, $0C
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $01, $0F, $00, $02

;	Voice $02
;	$58
;	$71, $37, $70, $30, 	$48, $D5, $1F, $1F, 	$0C, $08, $0E, $02
;	$17, $09, $06, $06, 	$28, $57, $17, $57, 	$1F, $15, $22, $06
	smpsVcAlgorithm     $00
	smpsVcFeedback      $03
	smpsVcUnusedBits    $01
	smpsVcDetune        $03, $07, $03, $07
	smpsVcCoarseFreq    $00, $00, $07, $01
	smpsVcRateScale     $00, $00, $03, $01
	smpsVcAttackRate    $1F, $1F, $15, $08
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $02, $0E, $08, $0C
	smpsVcDecayRate2    $06, $06, $09, $17
	smpsVcDecayLevel    $05, $01, $05, $02
	smpsVcReleaseRate   $07, $07, $07, $08
	smpsVcTotalLevel    $06, $22, $15, $1F

;	Voice $03
;	$78
;	$73, $3A, $30, $71, 	$18, $D5, $1F, $1F, 	$0C, $0E, $0E, $07
;	$0F, $09, $04, $0C, 	$58, $57, $17, $1C, 	$29, $1D, $18, $04
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $01
	smpsVcDetune        $07, $03, $03, $07
	smpsVcCoarseFreq    $01, $00, $0A, $03
	smpsVcRateScale     $00, $00, $03, $00
	smpsVcAttackRate    $1F, $1F, $15, $18
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $07, $0E, $0E, $0C
	smpsVcDecayRate2    $0C, $04, $09, $0F
	smpsVcDecayLevel    $01, $01, $05, $05
	smpsVcReleaseRate   $0C, $07, $07, $08
	smpsVcTotalLevel    $04, $18, $1D, $29

;	Voice $04
;	$3D
;	$70, $51, $61, $70, 	$7F, $1F, $1F, $71, 	$1F, $06, $06, $06
;	$06, $06, $01, $01, 	$18, $18, $08, $18, 	$13, $74, $73, $73
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $06, $05, $07
	smpsVcCoarseFreq    $00, $01, $01, $00
	smpsVcRateScale     $01, $00, $00, $01
	smpsVcAttackRate    $31, $1F, $1F, $3F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $1F
	smpsVcDecayRate2    $01, $01, $06, $06
	smpsVcDecayLevel    $01, $00, $01, $01
	smpsVcReleaseRate   $08, $08, $08, $08
	smpsVcTotalLevel    $73, $73, $74, $13

;	Voice $05
;	$7D
;	$31, $72, $72, $72, 	$8F, $14, $17, $7C, 	$11, $18, $18, $18
;	$08, $00, $00, $00, 	$01, $18, $18, $18, 	$15, $01, $01, $01
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $01
	smpsVcDetune        $07, $07, $07, $03
	smpsVcCoarseFreq    $02, $02, $02, $01
	smpsVcRateScale     $01, $00, $00, $02
	smpsVcAttackRate    $3C, $17, $14, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $18, $18, $18, $11
	smpsVcDecayRate2    $00, $00, $00, $08
	smpsVcDecayLevel    $01, $01, $01, $00
	smpsVcReleaseRate   $08, $08, $08, $01
	smpsVcTotalLevel    $01, $01, $01, $15

;	Voice $06
;	$A5
;	$70, $76, $73, $73, 	$1F, $5E, $6E, $6E, 	$0A, $10, $00, $0F
;	$00, $16, $00, $00, 	$AA, $1A, $0A, $1A, 	$01, $00, $04, $0A
	smpsVcAlgorithm     $05
	smpsVcFeedback      $04
	smpsVcUnusedBits    $02
	smpsVcDetune        $07, $07, $07, $07
	smpsVcCoarseFreq    $03, $03, $06, $00
	smpsVcRateScale     $01, $01, $01, $00
	smpsVcAttackRate    $2E, $2E, $1E, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0F, $00, $10, $0A
	smpsVcDecayRate2    $00, $00, $16, $00
	smpsVcDecayLevel    $01, $00, $01, $0A
	smpsVcReleaseRate   $0A, $0A, $0A, $0A
	smpsVcTotalLevel    $0A, $04, $00, $01

;	Voice $07
;	$36
;	$71, $32, $30, $71, 	$1F, $1F, $1F, $1F, 	$07, $07, $17, $17
;	$02, $08, $02, $1F, 	$1F, $0F, $1F, $1F, 	$0B, $00, $00, $00
	smpsVcAlgorithm     $06
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $07, $03, $03, $07
	smpsVcCoarseFreq    $01, $00, $02, $01
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $17, $17, $07, $07
	smpsVcDecayRate2    $1F, $02, $08, $02
	smpsVcDecayLevel    $01, $01, $00, $01
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $0B

;	Voice $08
;	$7D
;	$30, $7F, $71, $30, 	$7F, $1F, $1F, $71, 	$1F, $06, $06, $06
;	$06, $01, $01, $01, 	$1F, $18, $18, $18, 	$0A, $00, $00, $00
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $01
	smpsVcDetune        $03, $07, $07, $03
	smpsVcCoarseFreq    $00, $01, $0F, $00
	smpsVcRateScale     $01, $00, $00, $01
	smpsVcAttackRate    $31, $1F, $1F, $3F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $06, $06, $06, $1F
	smpsVcDecayRate2    $01, $01, $01, $06
	smpsVcDecayLevel    $01, $01, $01, $01
	smpsVcReleaseRate   $08, $08, $08, $0F
	smpsVcTotalLevel    $00, $00, $00, $0A

;	Voice $09
;	$7D
;	$31, $72, $72, $72, 	$8F, $14, $17, $7C, 	$11, $18, $18, $18
;	$08, $00, $00, $00, 	$01, $18, $18, $18, 	$10, $01, $01, $01
	smpsVcAlgorithm     $05
	smpsVcFeedback      $07
	smpsVcUnusedBits    $01
	smpsVcDetune        $07, $07, $07, $03
	smpsVcCoarseFreq    $02, $02, $02, $01
	smpsVcRateScale     $01, $00, $00, $02
	smpsVcAttackRate    $3C, $17, $14, $0F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $18, $18, $18, $11
	smpsVcDecayRate2    $00, $00, $00, $08
	smpsVcDecayLevel    $01, $01, $01, $00
	smpsVcReleaseRate   $08, $08, $08, $01
	smpsVcTotalLevel    $01, $01, $01, $10

