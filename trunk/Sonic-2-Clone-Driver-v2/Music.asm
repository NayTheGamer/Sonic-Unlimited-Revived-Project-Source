; ---------------------------------------------------------------------------
; Music metadata (pointers, speed shoes tempos, flags)
; ---------------------------------------------------------------------------
; byte_71A94: SpeedUpIndex:
MusicIndex:
ptr_mus01:	SMPS_MUSIC_METADATA	Music01, s1TempotoS3($FF), 0	; GHZ
ptr_mus02:	SMPS_MUSIC_METADATA	Music02, s1TempotoS3($72), 0	; LZ
ptr_mus03:	SMPS_MUSIC_METADATA	Music03, s1TempotoS3($73), 0	; MZ
ptr_mus04:	SMPS_MUSIC_METADATA	Music04, s1TempotoS3($26), 0	; SLZ
ptr_mus05:	SMPS_MUSIC_METADATA	Music05, s1TempotoS3($04), 0	; SYZ
ptr_mus06:	SMPS_MUSIC_METADATA	Music06, s1TempotoS3($08), 0	; SBZ
ptr_mus07:	SMPS_MUSIC_METADATA	Music07, s1TempotoS3($50), 0	; Invincible
ptr_mus08:	SMPS_MUSIC_METADATA	Music08, s1TempotoS3($25), 0	; Extra Life
ptr_mus09:	SMPS_MUSIC_METADATA	Music09, s1TempotoS3($08), 0	; Special Stage
ptr_mus0A:	SMPS_MUSIC_METADATA	Music0A, s1TempotoS3($05), 0	; Title Screen
ptr_mus0B:	SMPS_MUSIC_METADATA	Music0B, s1TempotoS3($05), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Ending
ptr_mus0C:	SMPS_MUSIC_METADATA	Music0C, s1TempotoS3($07)-$20, 0	; Boss
ptr_mus0D:	SMPS_MUSIC_METADATA	Music0D, s1TempotoS3($03), 0	; Final Zone
ptr_mus0E:	SMPS_MUSIC_METADATA	Music0E, s1TempotoS3($14), 0	; End of Act
ptr_mus0F:	SMPS_MUSIC_METADATA	Music0F, s1TempotoS3($13), 0	; Game Over
ptr_mus10:	SMPS_MUSIC_METADATA	Music10, s1TempotoS3($07), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Continue
ptr_mus11:	SMPS_MUSIC_METADATA	Music11, s1TempotoS3($33), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Credits
ptr_mus12:	SMPS_MUSIC_METADATA	Music12, s1TempotoS3($02), SMPS_MUSIC_METADATA_FORCE_PAL_SPEED	; Drowning
ptr_mus13:	SMPS_MUSIC_METADATA	Music13, s1TempotoS3($06), 0	; Emerald
ptr_mus14:	SMPS_MUSIC_METADATA	Music14, s1TempotoS3($08), 0	; Level Select
ptr_mus15:	SMPS_MUSIC_METADATA	Music15, s1TempotoS3($15), 0	; Knuckles Chaotix
ptr_musend

; ---------------------------------------------------------------------------
; Music data
; ---------------------------------------------------------------------------
Music01:	include		"Sonic-2-Clone-Driver-v2/music/Mus81 - GHZ.asm"
		even
Music02:	include		"Sonic-2-Clone-Driver-v2/music/Mus82 - LZ.asm"
		even
Music03:	include		"Sonic-2-Clone-Driver-v2/music/Mus83 - MZ.asm"
		even
Music04:	include		"Sonic-2-Clone-Driver-v2/music/Mus84 - SLZ.asm"
		even
Music05:	include		"Sonic-2-Clone-Driver-v2/music/Mus85 - SYZ.asm"
		even
Music06:	include		"Sonic-2-Clone-Driver-v2/music/Mus86 - SBZ.asm"
		even
Music07:	include		"Sonic-2-Clone-Driver-v2/music/Mus87 - Invincibility.asm"
		even
Music08:	include		"Sonic-2-Clone-Driver-v2/music/Mus88 - Extra Life.asm"
		even
Music09:	include		"Sonic-2-Clone-Driver-v2/music/Mus89 - Special Stage.asm"
		even
Music0A:	include		"Sonic-2-Clone-Driver-v2/music/Mus8A - Title Screen.asm"
		even
Music0B:	include		"Sonic-2-Clone-Driver-v2/music/Mus8B - Ending.asm"
		even
Music0C:	include		"Sonic-2-Clone-Driver-v2/music/Mus8C - Boss.asm"
		even
Music0D:	include		"Sonic-2-Clone-Driver-v2/music/Mus8D - FZ.asm"
		even
Music0E:	include		"Sonic-2-Clone-Driver-v2/music/Mus8E - Sonic Got Through.asm"
		even
Music0F:	include		"Sonic-2-Clone-Driver-v2/music/Mus8F - Game Over.asm"
		even
Music10:	include		"Sonic-2-Clone-Driver-v2/music/Mus90 - Continue Screen.asm"
		even
Music11:	include		"Sonic-2-Clone-Driver-v2/music/Mus91 - Credits.asm"
		even
Music12:	include		"Sonic-2-Clone-Driver-v2/music/Mus92 - Drowning.asm"
		even
Music13:	include		"Sonic-2-Clone-Driver-v2/music/Mus93 - Get Emerald.asm"
		even
Music14:	include		"Sonic-2-Clone-Driver-v2/music/Mus94 - LevelSelect.asm"
		even
Music15:	include		"Sonic-2-Clone-Driver-v2/music/Options Music.asm"
		even		