; =============================================================================================
; Created by Flamewing, based on S1SMPS2ASM version 1.1 by Marc Gordon (AKA Cinossu)
; =============================================================================================
; This modification supports the Sonic 2 Clone Driver v2, and strips out support for all other drivers

SMPS2ASMVer	= 1

; PSG conversion to S3/S&K/S3D drivers require a tone shift of 12 semi-tones.
psgdelta	EQU 12
; ---------------------------------------------------------------------------------------------
; Standard Octave Pitch Equates
	enum smpsPitch10lo=$88,smpsPitch09lo=$94,smpsPitch08lo=$A0,smpsPitch07lo=$AC,smpsPitch06lo=$B8
	enum smpsPitch05lo=$C4,smpsPitch04lo=$D0,smpsPitch03lo=$DC,smpsPitch02lo=$E8,smpsPitch01lo=$F4
	enum smpsPitch00=$00,smpsPitch01hi=$0C,smpsPitch02hi=$18,smpsPitch03hi=$24,smpsPitch04hi=$30
	enum smpsPitch05hi=$3C,smpsPitch06hi=$48,smpsPitch07hi=$54,smpsPitch08hi=$60,smpsPitch09hi=$6C
	enum smpsPitch10hi=$78
; ---------------------------------------------------------------------------------------------
; Note Equates
	enum nRst=$80+0,nC0,nCs0,nD0,nEb0,nE0,nF0,nFs0,nG0,nAb0,nA0,nBb0,nB0,nC1,nCs1,nD1
	enum nEb1=nD1+1,nE1,nF1,nFs1,nG1,nAb1,nA1,nBb1,nB1,nC2,nCs2,nD2,nEb2,nE2,nF2,nFs2
	enum nG2=nFs2+1,nAb2,nA2,nBb2,nB2,nC3,nCs3,nD3,nEb3,nE3,nF3,nFs3,nG3,nAb3,nA3,nBb3
	enum nB3=nBb3+1,nC4,nCs4,nD4,nEb4,nE4,nF4,nFs4,nG4,nAb4,nA4,nBb4,nB4,nC5,nCs5,nD5
	enum nEb5=nD5+1,nE5,nF5,nFs5,nG5,nAb5,nA5,nBb5,nB5,nC6,nCs6,nD6,nEb6,nE6,nF6,nFs6
	enum nG6=nFs6+1,nAb6,nA6,nBb6,nB6,nC7,nCs7,nD7,nEb7,nE7,nF7,nFs7,nG7,nAb7,nA7,nBb7
; SMPS2ASM uses nMaxPSG for songs from S1/S2 drivers.
; nMaxPSG1 and nMaxPSG2 are used only for songs from S3/S&K/S3D drivers.
; The use of psgdelta is intended to undo the effects of PSGPitchConvert
; and ensure that the ending note is indeed the maximum PSG frequency.
nMaxPSG				EQU nBb6-psgdelta
nMaxPSG1			EQU nBb6
nMaxPSG2			EQU nB6
; ---------------------------------------------------------------------------------------------

	include "Sonic-2-Clone-Driver-v2/SMPS2ASM - PSG Volume Envelope Equates.asm"
	include "Sonic-2-Clone-Driver-v2/SMPS2ASM - DAC Sample Equates.asm"
    if SMPS_EnablePWM
	include "Sonic-2-Clone-Driver-v2/SMPS2ASM - PWM Sample Equates.asm"
    endif

; ---------------------------------------------------------------------------------------------
; Channel IDs for SFX
cPSG1				EQU $80
cPSG2				EQU $A0
cPSG3				EQU $C0
cNoise				EQU $E0	; Not for use in S3/S&K/S3D
cFM3				EQU $02
cFM4				EQU $04
cFM5				EQU $05
cFM6				EQU $06	; Only in S3/S&K/S3D, overrides DAC
; ---------------------------------------------------------------------------------------------
; Conversion macros and functions

conv0To256  function n,((n==0)<<8)|n
s2TempotoS1 function n,(((768-n)>>1)/(256-n))&$FF
s2TempotoS3 function n,($100-((n==0)|n))&$FF
s1TempotoS2 function n,((((conv0To256(n)-1)<<8)+(conv0To256(n)>>1))/conv0To256(n))&$FF
s1TempotoS3 function n,s2TempotoS3(s1TempotoS2(n))
s3TempotoS1 function n,s2TempotoS1(s2TempotoS3(n))
s3TempotoS2 function n,s2TempotoS3(n)

convertMainTempoMod macro mod
	if SourceDriver>=3
		dc.b	mod
	elseif SourceDriver==1
		if mod==1
			fatal "Invalid main tempo of 1 in song from Sonic 1"
		endif
		dc.b	s1TempotoS3(mod)
	elseif SourceDriver==2
		if mod==0
			fatal "Invalid main tempo of 0 in song from Sonic 2"
		endif
		dc.b	s2TempotoS3(mod)
	endif
	endm

; PSG conversion to S3/S&K/S3D drivers require a tone shift of 12 semi-tones.
PSGPitchConvert macro pitch
	if SourceDriver>=3
		dc.b	pitch
	else
		dc.b	(pitch+psgdelta)&$FF
	endif
	endm
; ---------------------------------------------------------------------------------------------
; Header Macros
smpsHeaderStartSong macro ver, sourcesmps2asmver

SourceDriver set ver

	if ("sourcesmps2asmver"<>"")
SourceSMPS2ASM set sourcesmps2asmver
	else
SourceSMPS2ASM set 0
	endif

songStart set *

	if MOMPASS==2
	if SMPS2ASMVer < SourceSMPS2ASM
	message "Song at 0x\{songStart} was made for a newer version of SMPS2ASM (this is version \{SMPS2ASMVer}, but song wants at least version \{SourceSMPS2ASM})."
	endif
	endif

	endm

smpsHeaderVoiceNull macro
	if songStart<>*
		fatal "Missing smpsHeaderStartSong"
	endif
	dc.w	$0000
	endm

; Header - Set up Voice Location
; Common to music and SFX
smpsHeaderVoice macro loc
	if songStart<>*
		fatal "Missing smpsHeaderStartSong"
	endif
	if MOMPASS==2
	if ((loc-songStart >= $8000) || (loc-songStart < -$8000))
		fatal "Voice bank too far away from song"
	endif
	endif
	dc.w	loc-songStart
	endm

; Header - Set up Voice Location as S3's Universal Voice Bank
; Common to music and SFX
smpsHeaderVoiceUVB macro
	if songStart<>*
		fatal "Missing smpsHeaderStartSong"
	endif
	if SMPS_EnableUniversalVoiceBank
		dc.w	$0000
	else
		fatal "Go set SMPS_EnableUniversalVoiceBank to 1."
	endif
	endm

; Header macros for music (not for SFX)
; Header - Set up Channel Usage
smpsHeaderChan macro fm,psg,pwm
	dc.b	fm,psg
	if ("pwm"<>"")
		dc.b	pwm
	else
		dc.b	$00
	endif
	dc.b	$00
	endm

; Header - Set up Tempo
smpsHeaderTempo macro div,mod
	dc.b	div
	convertMainTempoMod mod
	endm

; Header - Set up DAC Channel
smpsHeaderDAC macro loc,pitch,vol
	if MOMPASS==2
	if ((loc-songStart >= $8000) || (loc-songStart < -$8000))
		fatal "Track is too far away from its header"
	endif
	endif
	dc.w	loc-songStart
	if ("pitch"<>"")
		dc.b	pitch
		if ("vol"<>"")
			dc.b	vol
		else
			dc.b	$00
		endif
	else
		dc.w	$00
	endif
	endm

; Header - Set up FM Channel
smpsHeaderFM macro loc,pitch,vol
	if MOMPASS==2
	if ((loc-songStart >= $8000) || (loc-songStart < -$8000))
		fatal "Track is too far away from its header"
	endif
	endif
	dc.w	loc-songStart
	dc.b	pitch,vol
	endm

; Header - Set up PSG Channel
smpsHeaderPSG macro loc,pitch,vol,mod,voice
	if MOMPASS==2
	if ((loc-songStart >= $8000) || (loc-songStart < -$8000))
		fatal "Track is too far away from its header"
	endif
	endif
	dc.w	loc-songStart
	PSGPitchConvert pitch
	dc.b	(vol)<<3,mod,voice
	endm

; Header - Set up PWM Channel
smpsHeaderPWM macro loc,pitch,vol
    if SMPS_EnablePWM
	smpsHeaderFM loc,pitch,vol
    else
	fatal "Go set SMPS_EnablePWM to 1."
    endif
	endm

; Header macros for SFX (not for music)
; Header - Set up Tempo
smpsHeaderTempoSFX macro div
	dc.b	div
	endm

; Header - Set up Channel Usage
smpsHeaderChanSFX macro chan
	dc.b	chan
	endm

; Header - Set up FM Channel
smpsHeaderSFXChannel macro chanid,loc,pitch,vol
	if chanid==cFM6
		fatal "Using channel ID of FM6 ($06) in Sonic 1 or Sonic 2 drivers is unsupported. Change it to another channel."
	endif
	dc.b	$80,chanid
	if MOMPASS==2
	if ((loc-songStart >= $8000) || (loc-songStart < -$8000))
		fatal "Track is too far away from its header"
	endif
	endif
	dc.w	loc-songStart
	if (chanid&$80)<>0
		PSGPitchConvert pitch
	else
		dc.b	pitch
	endif
	if (chanid==cPSG1) || (chanid==cPSG2) || (chanid==cPSG3)
		dc.b	vol<<3
	else
		dc.b	vol
	endif
	endm
; ---------------------------------------------------------------------------------------------
; Co-ord Flag Macros and Equates
; E0xx - Panning, AMS, FMS
smpsPan macro direction,amsfms
panNone set $00
panRight set $40
panLeft set $80
panCentre set $C0
panCenter set $C0 ; silly Americans :U
	dc.b	$FF,$00,direction+amsfms
	endm

; E1xx - Set channel frequency displacement to xx
smpsDetune macro val
	dc.b	$FF,$01,val
	endm

; E2xx - Useless
smpsNop macro val
	dc.b	$FF,$02,val
	endm

; Return (used after smpsCall)
smpsReturn macro
	dc.b	$FF,$03
	endm

; Fade in previous song (ie. 1-Up)
smpsFade macro val
	if (SourceDriver>=3) && ("val"<>"") && ("val"<>"$FF")
		; This is one of those stupid S3+ "fades" that we don't need
	else
		dc.b	$FF,$04
	endif
	endm

; E5xx - Set channel tempo divider to xx
smpsChanTempoDiv macro val
	dc.b	$FF,$05,val
	endm

; E6xx - Alter Volume by xx
smpsAlterVol macro val
	dc.b	$FF,$06,val
	endm

; E7 - Prevent attack of next note
smpsNoAttack	EQU $FE

; E8xx - Set note fill to xx
smpsNoteFill macro val
	if SourceDriver>=3
		dc.b	$FF,$1D,val
	else
		dc.b	$FF,$08,val
	endif
	endm

; Add xx to channel pitch
smpsChangeTransposition macro val
	dc.b	$FF,$09,val
	endm

; Set music tempo modifier to xx
smpsSetTempoMod macro mod
	dc.b	$FF,$0A
	convertMainTempoMod mod
	endm

; Set music tempo divider to xx
smpsSetTempoDiv macro val
	dc.b	$FF,$0B,val
	endm

; ECxx - Set Volume to xx
smpsSetVol macro val
	dc.b	$FF,$1C,val
	endm

; Works on all drivers
smpsPSGAlterVol macro vol
	dc.b	$FF,$0C,(((vol)<<3)&$7F)|((vol)&$80)
	endm

; Clears pushing sound flag in S1
smpsClearPush macro
	if SMPS_PushSFXBehaviour
		dc.b	$FF,$1F
	else
		fatal "Go set SMPS_PushSFXBehaviour to 1."
	endif
	endm

; Stops special SFX (S1 only) and restarts overridden music track
smpsStopSpecial macro
	if SMPS_EnableSpecSFX
		dc.b	$FF,$07
	else
		fatal "Go set SMPS_EnableSpecSFX to 1."
	endif
	endm

; EFxx[yy] - Set Voice of FM channel to xx; xx < 0 means yy present
smpsFMvoice macro voice,songID
	dc.b	$FF,$0D,voice
	endm

; F0wwxxyyzz - Modulation - ww: wait time - xx: modulation speed - yy: change per step - zz: number of steps
smpsModSet macro wait,speed,change,step
	if SourceDriver>=3
		dc.b	$FF,$21	; SMPS Z80 modulation mode
	else
		dc.b	$FF,$0E	; SMPS 68k modulation mode
	endif
	dc.b	wait,speed,change,step
	endm

; Turn on Modulation
smpsModOn macro type
	if "type"<>""
		if SMPS_EnableModulationEnvelopes
			dc.b	$FF,$22,type
		else
			fatal "Go set SMPS_EnableModulationEnvelopes to 1"
		endif
	else
		dc.b	$FF,$0F
	endif
	endm

; F2 - End of channel
smpsStop macro
	dc.b	$FF,$10
	endm

; F3xx - PSG waveform to xx
smpsPSGform macro form
	dc.b	$FF,$11,form
	endm

; Turn off Modulation
smpsModOff macro
	dc.b	$FF,$12
	endm

; F5xx - PSG voice to xx
smpsPSGvoice macro voice
	dc.b	$FF,$13,voice
	endm

; F6xxxx - Jump to xxxx
smpsJump macro loc
	dc.b	$FF,$14
	dc.w	loc-(*+1)
	endm

; F7xxyyzzzz - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing
smpsLoop macro index,loops,loc
	dc.b	$FF,$15
	dc.b	index,loops
	dc.w	loc-(*+1)
	endm

; F8xxxx - Call pattern at xxxx, saving return point
smpsCall macro loc
	dc.b	$FF,$16
	dc.w	loc-(*+2)
	endm
; ---------------------------------------------------------------------------------------------
; Alter Volume
smpsFMAlterVol macro val1
	dc.b	$FF,$06,val1
	endm

; S3/S&K/S3D/Clone Driver v2-only coordination flags

; Silences FM channel then stops as per smpsStop
smpsStopFM macro
	dc.b	$FF,$18
	endm

smpsPlayDACSample macro sample
	dc.b	$FF,$19,sample
	endm

smpsPlaySound macro index
	dc.b	$FF,$1A,index
	endm

; Set note values to xx-$40
smpsSetNote macro val
	dc.b	$FF,$1B,(val-$40)&$FF
	endm

; Set Modulation
smpsModChange macro val
	if SMPS_EnableModulationEnvelopes
		dc.b	$FF,$22,val
	else
		fatal "Go set SMPS_EnableModulationEnvelopes to 1"
	endif
	endm

; FCxxxx - Jump to xxxx
smpsContinuousLoop macro loc
	if SMPS_EnableContSFX
		dc.b	$FF,$1E
		dc.w	loc-(*+1)
	else
		fatal "You're using a Continuous SFX, but don't have SMPS_EnableContSFX set"
	endif
	endm

smpsFMICommand macro reg,val
	dc.b	$FF,$20,reg,val
	endm

	; Flags ported from other drivers.
smpsChanFMCommand macro reg,val
	dc.b	$FF,$17,reg,val
	endm
; ---------------------------------------------------------------------------------------------
; S1/S2 only coordination flag
; Sets D1L to maximum volume (minimum attenuation) and RR to maximum for operators 3 and 4 of FM1
smpsMaxRelRate macro
	; Emulate it in S3/S&K/S3D/Clone Driver v2
	smpsFMICommand $88,$0F
	smpsFMICommand $8C,$0F
	endm
; ---------------------------------------------------------------------------
; Backwards compatibility
smpsAlterNote macro
	smpsDetune	ALLARGS
	endm

smpsAlterPitch macro
	smpsChangeTransposition	ALLARGS
	endm

smpsWeirdD1LRR macro
	smpsMaxRelRate ALLARGS
	endm

smpsSetvoice macro
	smpsFMvoice ALLARGS
	endm
; ---------------------------------------------------------------------------------------------
; Macros for FM instruments
; Voices - Feedback
smpsVcFeedback macro val
vcFeedback set val
	endm

; Voices - Algorithm
smpsVcAlgorithm macro val
vcAlgorithm set val
	endm

smpsVcUnusedBits macro val
vcUnusedBits set val
	endm

; Voices - Detune
smpsVcDetune macro op1,op2,op3,op4
vcDT1 set op1
vcDT2 set op2
vcDT3 set op3
vcDT4 set op4
	endm

; Voices - Coarse-Frequency
smpsVcCoarseFreq macro op1,op2,op3,op4
vcCF1 set op1
vcCF2 set op2
vcCF3 set op3
vcCF4 set op4
	endm

; Voices - Rate Scale
smpsVcRateScale macro op1,op2,op3,op4
vcRS1 set op1
vcRS2 set op2
vcRS3 set op3
vcRS4 set op4
	endm

; Voices - Attack Rate
smpsVcAttackRate macro op1,op2,op3,op4
vcAR1 set op1
vcAR2 set op2
vcAR3 set op3
vcAR4 set op4
	endm

; Voices - Amplitude Modulation
; The original SMPS2ASM erroneously assumed the 6th and 7th bits
; were the Amplitude Modulation.
; According to several docs, however, it's actually the high bit.
smpsVcAmpMod macro op1,op2,op3,op4
	if SMPS2ASMVer==0
vcAM1 set op1<<5
vcAM2 set op2<<5
vcAM3 set op3<<5
vcAM4 set op4<<5
	else
vcAM1 set op1<<7
vcAM2 set op2<<7
vcAM3 set op3<<7
vcAM4 set op4<<7
	endif
	endm

; Voices - First Decay Rate
smpsVcDecayRate1 macro op1,op2,op3,op4
vcD1R1 set op1
vcD1R2 set op2
vcD1R3 set op3
vcD1R4 set op4
	endm

; Voices - Second Decay Rate
smpsVcDecayRate2 macro op1,op2,op3,op4
vcD2R1 set op1
vcD2R2 set op2
vcD2R3 set op3
vcD2R4 set op4
	endm

; Voices - Decay Level
smpsVcDecayLevel macro op1,op2,op3,op4
vcDL1 set op1
vcDL2 set op2
vcDL3 set op3
vcDL4 set op4
	endm

; Voices - Release Rate
smpsVcReleaseRate macro op1,op2,op3,op4
vcRR1 set op1
vcRR2 set op2
vcRR3 set op3
vcRR4 set op4
	endm

; Voices - Total Level
; The original SMPS2ASM decides TL high bits automatically,
; but later versions leave it up to the user.
; Alternatively, if we're converting an SMPS 68k song to SMPS Z80,
; then we *want* the TL bits to match the algorithm, because SMPS 68k
; prefers the algorithm over the TL bits, ignoring the latter, while
; SMPS Z80 does the opposite.
; Unfortunately, there's nothing we can do if we're trying to convert
; an SMPS Z80 song to SMPS 68k. It will ignore the bits no matter
; what we do, so we just print a warning.
smpsVcTotalLevel macro op1,op2,op3,op4
vcTL1 set op1
vcTL2 set op2
vcTL3 set op3
vcTL4 set op4
	dc.b	(vcUnusedBits<<6)+(vcFeedback<<3)+vcAlgorithm
;   0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
	if SourceSMPS2ASM==0
vcTLMask4 set ((vcAlgorithm==7)<<7)
vcTLMask3 set ((vcAlgorithm>=4)<<7)
vcTLMask2 set ((vcAlgorithm>=5)<<7)
vcTLMask1 set $80
	else
vcTLMask4 set 0
vcTLMask3 set 0
vcTLMask2 set 0
vcTLMask1 set 0
	endif

	if SourceDriver<3
vcTLMask4 set ((vcAlgorithm==7)<<7)
vcTLMask3 set ((vcAlgorithm>=4)<<7)
vcTLMask2 set ((vcAlgorithm>=5)<<7)
vcTLMask1 set $80
vcTL1 set vcTL1&$7F
vcTL2 set vcTL2&$7F
vcTL3 set vcTL3&$7F
vcTL4 set vcTL4&$7F
	endif

	dc.b	(vcDT4<<4)+vcCF4 ,(vcDT2<<4)+vcCF2 ,(vcDT3<<4)+vcCF3 ,(vcDT1<<4)+vcCF1
	dc.b	vcTL4|vcTLMask4  ,vcTL2|vcTLMask2  ,vcTL3|vcTLMask3  ,vcTL1|vcTLMask1
	dc.b	(vcRS4<<6)+vcAR4 ,(vcRS2<<6)+vcAR2 ,(vcRS3<<6)+vcAR3 ,(vcRS1<<6)+vcAR1
	dc.b	vcAM4|vcD1R4     ,vcAM2|vcD1R2     ,vcAM3|vcD1R3     ,vcAM1|vcD1R1
	dc.b	vcD2R4           ,vcD2R2           ,vcD2R3           ,vcD2R1
	dc.b	(vcDL4<<4)+vcRR4 ,(vcDL2<<4)+vcRR2 ,(vcDL3<<4)+vcRR3 ,(vcDL1<<4)+vcRR1
	endm
	
; Header Macros
sHeaderInit	macro
sPointZero set	*
    endm

; Header - Set up Patches Location
; Common to music and SFX
sHeaderPatch	macro loc
	if sPointZero<>*
		; silently initialize song. Change this if behavior needs to be different
sPointZero set	*
;		message "Missing sHeaderInit"
	endif

	dc.w \loc-sPointZero
    endm

; Header macros
; Header - Set up Channel Usage
sHeaderCh	macro fm,psg
	dc.b fm

	if "psg"<>""
		dc.b psg
	endif
    endm

; Header - Set up Tempo and Tick Multiplier
sHeaderTempo	macro tmul,tempo
	dc.b tmul,tempo
    endm

; Header - Set up Tick Multiplier
sHeaderTick	macro tmul
	dc.b tmul
    endm

; Header - Set up DAC Channel
sHeaderDAC	macro loc,pitch,vol
	dc.w loc-sPointZero

	if "pitch"<>""
		dc.b pitch
		if "vol"<>""
			dc.b vol
		else
			dc.b $00
		endif
	else
		dc.w $00
	endif
    endm

; Header - Set up FM Channel
sHeaderFM	macro loc,pitch,vol
	dc.w loc-sPointZero
	dc.b pitch,vol
    endm

; Header - Set up PSG Channel
sHeaderPSG	macro loc,pitch,vol,null,volenv
	dc.w loc-sPointZero
	dc.b pitch,vol,null,volenv
    endm

; Header - Set up SFX Channel
sHeaderSFX	macro play,patch,loc,pitch,vol
	dc.b play,patch
	dc.w loc-sPointZero
	dc.b pitch,vol
    endm
; ---------------------------------------------------------------------------------------------
; Equates for different panning types
spNone =	$00
spRight =	$40
spLeft =	$80
spCentre =	$C0
spCenter =	$C0
; ---------------------------------------------------------------------------------------------
; SMPS commands

; E0xx - Panning, AMS, FMS (PANAFMS - PAFMS_PAN)
sPan	macro dir,amsfms
	if "amsfms"<>""
		dc.b $E0,dir|amsfms
	else
		dc.b $E0,dir
	endif
    endm

; E1xx - Set channel frequency displacement to xx (DETUNE)
ssDetune	macro val
	dc.b $E1,val
    endm

; E2xx - Set communications byte to xx (SET_COMM)
sComm		macro val
	dc.b $E2,val
    endm

; E3 - Stop FM (TRK_END - TEND_MUTE)
sMuteStopFM	macro
	dc.b $E3
    endm

sPanAni		macro v1, v2, v3, v4, v5
	dc.b $E4

	if v1==""
		dc.b 0
	else
		dc.b v1,v2,v3,v4,v5
	endif
    endm

; E5yyxx - For FM channels, add xx to channel volume. For PSG, add yy (VOLUME - VOL_CC_FMP)
saVolFMP	macro psg,fm
	dc.b $E5,psg,fm
    endm

; E6xx - Add xx to volume. (VOLUME - VOL_CC_FM)
saVolFM		macro vol
	dc.b $E6,vol
    endm

; E7 - Do not attack next note (HOLD)
sHold =		$E7

; E8xx - Stop note after xx ticks (NOTE_STOP - NSTOP_MULT)
sGate		macro val
	dc.b $E8,val
    endm

; E9xxyy - Set LFO speed to xx and amplitude vibrate to yy (SET_LFO - LFO_AMSEN)
ssLFO		macro speed,vibrate
	dc.b $E9,speed,vibrate
    endm

; EAxx - Set music tempo to xx (TEMPO - TEMPO_SET)
ssTempo		macro val
	dc.b $EA,val
    endm

; EBxx - Play sound xx (SND_CMD)
sPlaySound	macro val
	dc.b $EB,val
    endm

; ECxx - Add xx to PSG channel volume (VOLUME - VOL_NN_PSG)
saVolPSG	macro val
	dc.b $EC,val
    endm

; EDxxyy - Write yy to YM reg xx (FM_COMMAND - FMW_CHN)
sYMcmd		macro reg,val
	dc.b $ED,reg,val
    endm

; EExxyy - Write yy to YM port 1 reg xx (FM_COMMAND - FMW_FM1)
sYM1cmd		macro reg,val
	dc.b $EE,reg,val
    endm

; EFxx - Set patch id of FM channel to xx (INSTRUMENT - INS_N_FM)
sPatFM		macro pat
	dc.b $EF,pat
    endm

; F0wwxxyyzz - Modulation
;  ww: wait time
;  xx: modulation speed
;  yy: change per step
;  zz: number of steps
; (MOD_SETUP)
ssMod68k	macro wait,speed,change,step
	dc.b $F0,wait,speed,change,step
    endm

; F1yyxx - For FM channels, set channel modulation envelope to xx. For PSG, use yy (MOD_ENV - MENV_FMP)
; F4xx - Set channel modulation envelope to xx  (MOD_ENV - MENV_GEN)
sModEnv		macro psg,fm
	if fm==""
		dc.b $F4,psg
	else
		dc.b $F1,psg,fm
	endif
    endm

; F2 - End of channel (TRK_END - TEND_STD)
sStop		macro
	dc.b $F2
    endm

; F3xx - PSG waveform to xx (PSG_NOISE - PNOIS_SET)
sNoisePSG	macro val
	dc.b $F3,val
    endm

; F5xx - PSG volume envelope to xx (INSTRUMENT - INS_C_PSG)
sVolEnvPSG	macro env
	dc.b $F5,env
    endm

; F6xxxx - Jump to xxxx (GOTO)
sJump		macro loc
	dc.b $F6
	dc.w loc-*-1
    endm

; F7xxyyzzzz - Loop back to zzzz yy times, xx being the loop index for loop recursion fixing (LOOP)
sLoop		macro index,loops,loc
	dc.b $F7,index,loops
	dc.w loc-*-1
    endm

; F8xxxx - Call pattern at xxxx, saving return point (GOSUB)
sCall		macro loc
	dc.b $F8
	dc.w loc-*-1
    endm

; F9 - Return (RETURN)
sRet		macro
	dc.b $F9
    endm

; FAxx - Set channel tick multiplier to xx (TICK_MULT - TMULT_CUR)
ssTickMulCh	macro val
	dc.b $FA,val
    endm

; FBxx - Add xx to channel pitch (TRANSPOSE - TRNSP_ADD)
saTranspose	macro val
	dc.b $FB,val
    endm

; FC - Turn on Modulation (MOD_SET - MODS_ON)
sModOn		macro
	dc.b $FC
    endm

; FD - Turn off Modulation (MOD_SET - MODS_OFF)
sModOff		macro
	dc.b $FD
    endm

; FEwwxxyyzz - Enable special FM3 mode (broken?) (SPC_FM3)
sSpecFM3	macro ind1,ind2,ind3,ind4
	dc.b $FE,ind1,ind2,ind3,ind4
    endm

; FF00wwxxyyzz - Enable SSG-EG (SSG_EG - SEG_FULLATK)
sSSGEG		macro op1,op2,op3,op4
	dc.b $FF,$00,op1,op3,op2,op4
    endm

; FF01xx - Pause music (MUS_PAUSE - MUSP_68K)
sMusPause	macro val
	dc.b $FF,$01,val
    endm

; FF02xx - Set global tick multiplier to xx (TICK_MULT - TMULT_ALL)
ssTickMul	macro tmul
	dc.b $FF,$02,\mul
    endm

; FF03xxyy - Enable special fade (todo: Checkout what it does) (FADE_SPC - FDSPC_FMPSG)
; FF04 - Disable special fade (FADE_SPC - FDSPC_STOP)
sFadeSpec	macro val1, val2
	dc.b $FF

	if val1==""
		dc.b $04
	else
		dc.b $03,val1,val2
	endif
    endm
; ---------------------------------------------------------------------------------------------
; Macros for FM instruments

; Patches - Feedback
spFeedback macro val
spFe set	val
    endm

; Patches - Algorithm
spAlgorithm macro val
spAl set	val
    endm

; Patches - Detune
spDetune macro op1,op2,op3,op4
spDe1 set	op1
spDe2 set	op2
spDe3 set	op3
spDe4 set	op4
    endm

; Patches - Multiple
spMultiple macro op1,op2,op3,op4
spMu1 set	op1
spMu2 set	op2
spMu3 set	op3
spMu4 set	op4
    endm

; Patches - Rate Scale
spRateScale macro op1,op2,op3,op4
spRS1 set	op1
spRS2 set	op2
spRS3 set	op3
spRS4 set	op4
    endm

; Patches - Attack Rate
spAttackRt macro op1,op2,op3,op4
spAR1 set	op1
spAR2 set	op2
spAR3 set	op3
spAR4 set	op4
    endm

; Patches - Amplitude Modulation
spAmpMod macro op1,op2,op3,op4
spAM1 set	op1
spAM2 set	op2
spAM3 set	op3
spAM4 set	op4
    endm

; Patches - Sustain Rate
spSustainRt macro op1,op2,op3,op4
spSR1 set	op1
spSR2 set	op2
spSR3 set	op3
spSR4 set	op4
    endm

; Patches - Sustain Level
spSustainLv macro op1,op2,op3,op4
spSL1 set	op1
spSL2 set	op2
spSL3 set	op3
spSL4 set	op4
    endm

; Patches - Decay Rate
spDecayRt macro op1,op2,op3,op4
spDR1 set	op1
spDR2 set	op2
spDR3 set	op3
spDR4 set	op4
    endm

; Patches - Release Rate
spReleaseRt macro op1,op2,op3,op4
spRR1 set	op1
spRR2 set	op2
spRR3 set	op3
spRR4 set	op4
    endm

; Patches - Total Level
spTotalLv macro op1,op2,op3,op4
spTL1 set	op1
spTL2 set	op2
spTL3 set	op3
spTL4 set	op4

	dc.b (spFe<<3)|spAl
;   0     1     2     3     4     5     6     7
;%1000,%1000,%1000,%1000,%1010,%1110,%1110,%1111
spTLMask4 set $80
spTLMask3 set ((spAl>=4)<<7)
spTLMask2 set ((spAl>=5)<<7)
spTLMask1 set ((spAl=7)<<7)

	dc.b (spDe1<<4)|spMu1, (spDe3<<4)|spMu3, (spDe2<<4)|spMu2, (spDe4<<4)|spMu4
	dc.b (spRS1<<6)|spAR1, (spRS3<<6)|spAR3, (spRS2<<6)|spAR2, (spRS4<<6)|spAR4
	dc.b (spAM1<<7)|spSR1, (spAM3<<7)|spsR3, (spAM2<<7)|spSR2, (spAM4<<7)|spSR4
	dc.b spDR1,            spDR3,            spDR2,            spDR4
	dc.b (spSL1<<4)|spRR1, (spSL3<<4)|spRR3, (spSL2<<4)|spRR2, (spSL4<<4)|spRR4
	dc.b spTL1|spTLMask1,  spTL3|spTLMask3,  spTL2|spTLMask2,  spTL4|spTLMask4
    endm
	
