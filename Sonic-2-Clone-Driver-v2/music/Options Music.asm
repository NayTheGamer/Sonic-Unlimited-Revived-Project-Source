CrackersEveningStar_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     CrackersEveningStar_Voices
	smpsHeaderChan      $06, $03
	smpsHeaderTempo     $01, $04

	smpsHeaderDAC       CrackersEveningStar_DAC
	smpsHeaderFM        CrackersEveningStar_FM1,	$00, $10
	smpsHeaderFM        CrackersEveningStar_FM2,	$00, $12
	smpsHeaderFM        CrackersEveningStar_FM3,	$00, $12
	smpsHeaderFM        CrackersEveningStar_FM4,	$00, $12
	smpsHeaderFM        CrackersEveningStar_FM5,	$00, $1C
	smpsHeaderPSG       CrackersEveningStar_PSG1,	$E8, $00, $00, $00
	smpsHeaderPSG       CrackersEveningStar_PSG2,	$E8, $00, $00, $00
	smpsHeaderPSG       CrackersEveningStar_PSG3,	$17, $00, $00, $00

; FM1 Data
CrackersEveningStar_FM1:
	smpsSetvoice        $00
	dc.b	nEb2, $60, nD2, $60, nG1, $60, smpsNoAttack, $30, nG1, $08, nG2, $0C
	dc.b	nG1, $04, nBb1, $08, nA1, $04, nG1, $08, nF1, $04

CrackersEveningStar_Jump01:
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $FF
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $F9
	smpsCall            CrackersEveningStar_Call0A
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $08
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $FF
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $F9
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $08
	smpsCall            CrackersEveningStar_Call0B
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $FF
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $F9
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $08
	dc.b	nG1, $0C, nG1, nRst, $38, nG2, $04, nG1, $08, nF1, $04
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $FF
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $F9
	smpsCall            CrackersEveningStar_Call0A
	smpsAlterPitch      $08
	smpsCall            CrackersEveningStar_Call0B
	smpsJump            CrackersEveningStar_Jump01

CrackersEveningStar_Call0A:
	dc.b	nEb2, $0C, nEb2, nRst, $24, nEb2, $0C, nRst, $08, nEb2, $10
	smpsReturn

CrackersEveningStar_Call0B:
	dc.b	nG1, $08, nG2, $0C, $04, nA1, $08, nA2, $0C, $04, nBb1, $08
	dc.b	nBb2, $0C, $04, nC2, $08, nC3, $0C, $04
	smpsReturn

; FM2 Data
CrackersEveningStar_FM2:
	smpsSetvoice        $01
	smpsAlterPitch      $F9
	smpsCall            CrackersEveningStar_Call06
	smpsAlterPitch      $04
	smpsCall            CrackersEveningStar_Call07
	smpsAlterPitch      $FF
	smpsCall            CrackersEveningStar_Call06
	smpsCall            CrackersEveningStar_Call08
	smpsAlterPitch      $04
	smpsSetvoice        $02
	smpsAlterVol        $02

CrackersEveningStar_Loop05:
	smpsCall            CrackersEveningStar_Call01
	dc.b	nRst, $60
	smpsLoop            $00, $02, CrackersEveningStar_Loop05
	smpsJump            CrackersEveningStar_Loop05

CrackersEveningStar_Call06:
	dc.b	nD4, $08
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$04
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$08, $04, $08, $04
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$0C
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, nD4, $08, $04
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsReturn

CrackersEveningStar_Call07:
	dc.b	nRst, $0C, nC4, $08, $04
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04, $08, $04
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$0C
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$08, $04
	smpsReturn

CrackersEveningStar_Call08:
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	nD4, $08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsLoop            $00, $08, CrackersEveningStar_Call08
	smpsReturn

CrackersEveningStar_Call01:
	dc.b	nF4, $0C, nRst, nG4, nRst, nA4, $03, smpsNoAttack, nBb4, $11, nG4, $04
	dc.b	nRst, $0C, nC5, smpsNoAttack, $08, nRst, $04, nC5, $08, nRst, $04, nC5
	dc.b	$08, nRst, $04, nD5, $08, nRst, $04, nBb4, $03, smpsNoAttack, nC5, $05
	dc.b	nBb4, $04, nRst, $08, nG4, $1C, nF4, $0C, nRst, nG4, nRst, nBb4
	dc.b	$14, nG4, $04, nRst, $0C, nF5, smpsNoAttack, $08, nRst, $04, nG5, $08
	dc.b	nRst, $04, nF5, $08, nE5, $04, nRst, $08, nD5, $34, nRst, $0C
	dc.b	nBb4, $14, nRst, $04, nG4, $08, nRst, $04, nBb4, $14, nC5, $04
	dc.b	nRst, $0C, nF5, smpsNoAttack, $0C, nEb5, nD5, $08, nEb5, $04, nRst, $08
	dc.b	nC5, $03, smpsNoAttack, nD5, $09, nRst, $04, nC5, $0C, nBb4, $08, nC5
	dc.b	$0C, nG4, $04, smpsNoAttack, $14, nD5, $4C
	smpsReturn

; FM3 Data
CrackersEveningStar_FM3:
	smpsSetvoice        $01
	smpsCall            CrackersEveningStar_Call06
	smpsCall            CrackersEveningStar_Call07
	smpsCall            CrackersEveningStar_Call06
	smpsCall            CrackersEveningStar_Call08
	smpsAlterVol        $FB

CrackersEveningStar_Loop04:
	smpsCall            CrackersEveningStar_Call06
	smpsCall            CrackersEveningStar_Call07
	smpsCall            CrackersEveningStar_Call06
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	nD4, $0C
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$08, $04
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsAlterVol        $0A
	smpsPan             panLeft, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsCall            CrackersEveningStar_Call09
	smpsCall            CrackersEveningStar_Call06
	smpsCall            CrackersEveningStar_Call07
	smpsCall            CrackersEveningStar_Call06
	smpsCall            CrackersEveningStar_Call08
	smpsLoop            $01, $02, CrackersEveningStar_Loop04
	smpsJump            CrackersEveningStar_Loop04

CrackersEveningStar_Call09:
	smpsAlterVol        $FE
	dc.b	nRst, $08, nF3, $04, nG3, $08, nBb3, $0C, nG3, $04, nBb3, $08
	dc.b	nC4, $04
	smpsAlterVol        $02
	smpsReturn

; FM4 Data
CrackersEveningStar_FM4:
	smpsSetvoice        $01
	smpsAlterPitch      $FC
	smpsCall            CrackersEveningStar_Call02
	smpsAlterPitch      $FE
	smpsCall            CrackersEveningStar_Call03
	smpsAlterPitch      $FD
	smpsCall            CrackersEveningStar_Call02
	smpsCall            CrackersEveningStar_Call04
	smpsAlterPitch      $09
	smpsAlterVol        $FB

CrackersEveningStar_Loop03:
	smpsAlterPitch      $FC
	smpsCall            CrackersEveningStar_Call02
	smpsAlterPitch      $FE
	smpsCall            CrackersEveningStar_Call03
	smpsAlterPitch      $FD
	smpsCall            CrackersEveningStar_Call02
	smpsAlterPitch      $09
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	nF3, $0C
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$08, $04
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsCall            CrackersEveningStar_Call05
	smpsAlterPitch      $FC
	smpsCall            CrackersEveningStar_Call02
	smpsAlterPitch      $FE
	smpsCall            CrackersEveningStar_Call03
	smpsAlterPitch      $FD
	smpsCall            CrackersEveningStar_Call02
	smpsCall            CrackersEveningStar_Call04
	smpsAlterPitch      $09
	smpsLoop            $01, $02, CrackersEveningStar_Loop03
	smpsJump            CrackersEveningStar_Loop03

CrackersEveningStar_Call02:
	dc.b	nD4, $08
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$04
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$08, $04, $08, $04
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$0C
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	nRst, $0C, nD4, $08, $04
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsReturn

CrackersEveningStar_Call03:
	dc.b	nRst, $0C, nC4, $08, $04
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04, $08, $04
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	$0C
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$08, $04
	smpsReturn

CrackersEveningStar_Call04:
	smpsAlterVol        $0A
	smpsPan             panRight, $00
	dc.b	nD4, $08
	smpsAlterVol        $F6
	smpsPan             panCenter, $00
	dc.b	$04
	smpsLoop            $00, $08, CrackersEveningStar_Call04
	smpsReturn

CrackersEveningStar_Call05:
	smpsPan             panRight, $00
	smpsAlterVol        $08
	dc.b	nRst, $0B, nF3, $04, nG3, $08, nBb3, $0C, nG3, $04, nBb3, $08
	dc.b	nC4, $01
	smpsPan             panCenter, $00
	smpsAlterVol        $F8
	smpsReturn

; FM5 Data
CrackersEveningStar_FM5:
	smpsSetvoice        $02
	dc.b	nRst, $60, nRst, nRst, nRst
	smpsPan             panRight, $00
	smpsModSet          $04, $01, $03, $01

CrackersEveningStar_Jump00:
	dc.b	nRst, $04
	smpsCall            CrackersEveningStar_Call01
	dc.b	nRst, $60
	smpsCall            CrackersEveningStar_Call01
	dc.b	nRst, $5C
	smpsJump            CrackersEveningStar_Jump00

; PSG1 Data
CrackersEveningStar_PSG1:
	smpsPSGvoice        sTone_04
	dc.b	nRst, $60, nRst, nRst, nRst, $30, nG3, $0C, nA3, nBb3, $08, nC4
	dc.b	$04, nD4, $08, nEb4, $04

CrackersEveningStar_Jump03:
	dc.b	nF4, $60, smpsNoAttack, $18, nEb4, nD4, nEb4, nD4, $60, smpsNoAttack, $18, nC4
	dc.b	nBb3, nC4, nG3, $60, nFs3, $30, nD3, nG3, $60, nG3, $18, nA3
	dc.b	nBb3, nC4, nF4, $60, smpsNoAttack, $18, nEb4, nD4, nEb4, nD4, $60, smpsNoAttack
	dc.b	$30, nRst, $20, nBb3, $04, nC4, $08, nD4, $04, nG3, $60, nFs3
	dc.b	$30, nD3, nG3, $60, nG3, $18, nA3, nBb3, $0C, nC4, nD4, nEb4
	smpsJump            CrackersEveningStar_Jump03

; PSG2 Data
CrackersEveningStar_PSG2:
	smpsPSGvoice        sTone_04
	smpsModSet          $03, $01, $01, $02
	dc.b	nRst, $04, nRst, $60, nRst, nRst, nRst, $30, nG3, $0C, nA3, nBb3
	dc.b	$08, nC4, $04, nD4, $08, nEb4, $04

CrackersEveningStar_Jump02:
	dc.b	nF4, $60, smpsNoAttack, $18, nEb4, nD4, nEb4, nD4, $60, smpsNoAttack, $18, nC4
	dc.b	nBb3, nC4, nG3, $60, nFs3, $30, nD3, nG3, $60, nG3, $18, nA3
	dc.b	nBb3, nC4, nF4, $60, smpsNoAttack, $18, nEb4, nD4, nEb4, nD4, $60, smpsNoAttack
	dc.b	$30, nRst, $20, nBb3, $04, nC4, $08, nD4, $04, nG3, $60, nFs3
	dc.b	$30, nD3, nG3, $60, nG3, $18, nA3, nBb3, $0C, nC4, nD4, nEb4
	smpsJump            CrackersEveningStar_Jump02

; PSG3 Data
CrackersEveningStar_PSG3:
	smpsPSGform         $E7

CrackersEveningStar_Loop06:
	smpsPSGvoice        sTone_02
	dc.b	(nMaxPSG-$17)&$FF, $08, $04
	smpsLoop            $00, $1F, CrackersEveningStar_Loop06
	smpsPSGvoice        sTone_05
	dc.b	$0C

CrackersEveningStar_Loop07:
	smpsCall            CrackersEveningStar_Call0C
	smpsCall            CrackersEveningStar_Call0D
	smpsLoop            $01, $04, CrackersEveningStar_Loop07
	smpsCall            CrackersEveningStar_Call0C
	smpsCall            CrackersEveningStar_Call0D
	smpsCall            CrackersEveningStar_Call0C
	smpsPSGvoice        sTone_02
	dc.b	(nMaxPSG-$17)&$FF, $08, $04, $08, $04, $08, $04
	smpsPSGvoice        sTone_05
	dc.b	$08
	smpsPSGvoice        sTone_02
	dc.b	$04, nRst, $18, nRst, $08, (nMaxPSG-$17)&$FF, $04
	smpsPSGvoice        sTone_05
	dc.b	$08
	smpsPSGvoice        sTone_02
	dc.b	$04
	smpsCall            CrackersEveningStar_Call0C
	smpsCall            CrackersEveningStar_Call0D
	smpsCall            CrackersEveningStar_Call0C
	smpsCall            CrackersEveningStar_Call0D
	smpsJump            CrackersEveningStar_Loop07

CrackersEveningStar_Call0C:
	smpsPSGvoice        sTone_02
	dc.b	nC4, $08, $04
	smpsLoop            $00, $08, CrackersEveningStar_Call0C
	smpsReturn

CrackersEveningStar_Call0D:
	smpsPSGvoice        sTone_02
	dc.b	nC4, $08, $04
	smpsLoop            $00, $07, CrackersEveningStar_Call0D
	smpsPSGvoice        sTone_05
	dc.b	$0C
	smpsReturn

; DAC Data
CrackersEveningStar_DAC:
	dc.b	nRst, $18, pwmAcousticKick
	smpsLoop            $00, $07, CrackersEveningStar_DAC
	dc.b	pwmAcousticKick, $0C, pwmElectricSnare, $08, $04, pwmHighTom, $08, pwmMidTom, $04, pwmLowTom, $08, $04

CrackersEveningStar_Loop00:
	smpsCall            CrackersEveningStar_Call00
	smpsLoop            $00, $08, CrackersEveningStar_Loop00

CrackersEveningStar_Loop01:
	smpsCall            CrackersEveningStar_Call00
	smpsLoop            $00, $03, CrackersEveningStar_Loop01
	dc.b	pwmAcousticKick, $0C, pwmAcousticKick, pwmElectricSnare, $14, $04, nRst, $18, nRst, $08, pwmElectricSnare, $04
	dc.b	$08, $04

CrackersEveningStar_Loop02:
	smpsCall            CrackersEveningStar_Call00
	smpsLoop            $00, $04, CrackersEveningStar_Loop02
	smpsJump            CrackersEveningStar_Loop00

CrackersEveningStar_Call00:
	dc.b	pwmAcousticKick, $0C, pwmAcousticKick, pwmElectricSnare, $24, pwmAcousticKick, $0C, pwmElectricSnare, $08, pwmHighTom, $04, pwmMidTom
	dc.b	$08, pwmLowTom, $04
	smpsReturn

CrackersEveningStar_Voices:
;	Voice $00
;	$29
;	$59, $54, $01, $02, 	$DF, $DF, $9F, $9F, 	$10, $0C, $03, $05
;	$12, $0F, $04, $07, 	$7F, $2F, $4F, $9F, 	$15, $1E, $1C, $00
	smpsVcAlgorithm     $01
	smpsVcFeedback      $05
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $05, $05
	smpsVcCoarseFreq    $02, $01, $04, $09
	smpsVcRateScale     $02, $02, $03, $03
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $03, $0C, $10
	smpsVcDecayRate2    $07, $04, $0F, $12
	smpsVcDecayLevel    $09, $04, $02, $07
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1C, $1E, $15

;	Voice $01
;	$01
;	$75, $75, $71, $31, 	$D5, $55, $96, $94, 	$02, $0B, $05, $0D
;	$0A, $0A, $0F, $06, 	$FF, $2F, $3F, $6F, 	$25, $2B, $0F, $00
	smpsVcAlgorithm     $01
	smpsVcFeedback      $00
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $07, $07, $07
	smpsVcCoarseFreq    $01, $01, $05, $05
	smpsVcRateScale     $02, $02, $01, $03
	smpsVcAttackRate    $14, $16, $15, $15
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0D, $05, $0B, $02
	smpsVcDecayRate2    $06, $0F, $0A, $0A
	smpsVcDecayLevel    $06, $03, $02, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $0F, $2B, $25

;	Voice $02
;	$0D
;	$77, $65, $05, $15, 	$1F, $5F, $5F, $5F, 	$00, $10, $08, $10
;	$00, $03, $05, $04, 	$0F, $FC, $8C, $CC, 	$1F, $00, $00, $00
	smpsVcAlgorithm     $05
	smpsVcFeedback      $01
	smpsVcUnusedBits    $00
	smpsVcDetune        $01, $00, $06, $07
	smpsVcCoarseFreq    $05, $05, $05, $07
	smpsVcRateScale     $01, $01, $01, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $10, $08, $10, $00
	smpsVcDecayRate2    $04, $05, $03, $00
	smpsVcDecayLevel    $0C, $08, $0F, $00
	smpsVcReleaseRate   $0C, $0C, $0C, $0F
	smpsVcTotalLevel    $00, $00, $00, $1F

