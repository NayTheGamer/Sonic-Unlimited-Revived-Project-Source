    LEA     VDP_CTRL, A0          ; Address of VDP control port
    LEA     VDP_DATA, A1          ; Address of VDP data port

    ; Initialize the VDP (basic setup for screen mode, omitted here for brevity)

    ; Load the font into VRAM
    MOVE.L  #0x40000000, D0       ; Write to VRAM starting at 0x0000
    MOVE.L  D0, (A0)              ; Set VRAM write address
    LEA     FONT_DATA, A2         ; Address of the font data
    MOVE.W  #FONT_SIZE, D1        ; Number of bytes in the font data

LoadFontLoop:
    MOVE.W  (A2)+, (A1)           ; Write font data to VRAM
    SUBQ.W  #2, D1
    BNE.S   LoadFontLoop

    ; Write a string to the tilemap
    MOVE.L  #0xC0000000, D0       ; Write to Plane A starting at 0xC000
    MOVE.L  D0, (A0)              ; Set VRAM write address
    LEA     STRING_DATA, A2       ; Address of string data
    MOVE.W  #STRING_LENGTH, D1    ; Number of characters in the string

WriteStringLoop:
    MOVE.W  (A2)+, D0             ; Read character
    ADD.W   #TILE_OFFSET, D0      ; Map ASCII to tile index
    MOVE.W  D0, (A1)              ; Write tile index to tilemap
    SUBQ.W  #1, D1
    BNE.S   WriteStringLoop

    ; Main loop
MainLoop:
    BRA.S   MainLoop

; Data
FONT_DATA:  ; Your font binary data (e.g., 8x8 tiles)
    INCBIN "font.bin"

STRING_DATA:  ; Example string "HELLO"
    DC.B    'H', 'E', 'L', 'L', 'O'
    STRING_LENGTH = ($ - STRING_DATA)

FONT_SIZE    = (number_of_tiles * 32)  ; Each tile is 32 bytes
TILE_OFFSET  = 0x20  ; Offset of first tile for ASCII in VRAM