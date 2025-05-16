    ; BSCS 2-2 | Group 3
    ;   Spike Escape V2 (Enhanced)
    ; player0   -   Car
    ; player1-4 -   Spikes
    ; player5   -   Traffic Cone
    ; player6   -   Manhole
    ; player7   -   Coins
    ; player8   -   Score Multiplier
    ; player9   -   Invincibility

    ; This program uses the DPC+ kernel.
    set kernel DPC+
    set tv ntsc
    set kernel_options player1colors playercolors pfcolors
    set smartbranching on

    ; inlinerand to prevent bankswitching when calling rand
    set optimization inlinerand

    ;  Variable aliases go here (DIMs):

    dim _Background_Scroll_Counter = b       ;  Speed of background scroll.
    dim _Bit0_Reset_Restrainer = t           ;  Reset switch bit.
    dim _CarOption = a
    _CarOption = 0

    goto __Bank3_init bank3

    asm
minikernel
    ldx $00         ;  Score background color to prevent it from changing
    stx COLUBK
    rts
end

    bank 2
    temp1=temp1
    
__Game_init
    ; other game logic variable initializations
    
    dim _Delay = d
    _Delay = 100

    dim rand16 = z      ; Using 16-bit RNG instead of 8-bit

    score = 0

    ; Counters for timing when an obstacle can spawn
    dim _ObstaclePassCounter = g
    dim _CoinPassCounter = h
    dim _PowerupPassCounter = i

    ; RNG Values
    dim _ObstacleTypeRNG = o
    dim _ObstaclePositionRNG = p
    dim _PowerupTypeRNG = q
    dim _sizeVariation = u

    dim _CurrentActiveObstacle = s      ; 1 = Spikes, 2 = Cone, 3 = Hole

    dim _isCoin_Active = v
    dim _isInvulPickup_Active = w
    dim _isMultPickup_Active = x

    dim _ScoreMult = e
    dim _ScoreMultDuration = j
    dim _Invul = f
    dim _InvulDuration = l

    _ScoreMultDuration = 0
    _InvulDuration = 0

    _isCoin_Active = 0
    _isInvulPickup_Active = 0
    _isMultPickup_Active = 0

    _ScoreMult = 0
    _Invul = 0

    ; Sound Timers

    dim _Coin_SoundTimer = var0
    dim _CarSound = var4

    _Coin_SoundTimer = 0

    

    ; Initial Player Position
    player0x = 75
    player0y = 130

    ; (For Testing) Initial Obstacle Positions
    ;player1x = 46 : player1y = 1
    ;player2x = player1x + 13 : player2y = player1y + 14
    ;player3x = player2x + 13 : player3y = player2y + 14
    ;player4x = player3x + 13 : player4y = player3y + 14

    dim _8_8_Speed = m.n
    dim _Integer = m
    dim _Fraction = n
    dim _Fraction_Counter = k
    dim _Speed = _Integer

    dim _tempscore = temp2
    dim _fracmem = temp3

    _8_8_Speed = 1.5     ; Initial Obstacle Speed

    goto __Start_Restart
    
    
__Start_Restart     ; Game Start/Restart
    ;  Background color data.
    bkcolors:
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
    $04
    $06
    $06
    $06
    $06
    $06
    $04
    $04
end

    ;  RevEng trick to get 256 background colors. (Seamless Scrolling)
    pfscroll 255 6 6

    bkcolors:
    $04
end

    ;  Score colors.
    scorecolors:
    $3E
    $3C
    $3A
    $3A
    $38
    $38
    $36
    $36
end
    ;  Sets the background color scroll speed counter.
    _Background_Scroll_Counter = 2


   
    ;  Sets repetition restrainer for the reset switch.
    ;  (Holding it down won't make it keep resetting.)
    _Bit0_Reset_Restrainer{0} = 1


;   Player (Car) Graphics

    if _CarOption = 0 then player0:
    %00000000
    %10011001
    %10101101
    %10111101
    %11100111
    %10111101
    %10111101
    %10110101
    %00100100
    %00101100
    %10011001
    %10111101
    %11100111
    %10111101
    %10011001
    %00000000
end
    if _CarOption = 0 then player0color:
    $20
    $20
    $30
    $34
    $32
    $32
    $30
    $30
    $34
    $34
    $34
    $36
    $36
    $36
    $3C
    $0E
end

;   Player1-4 (Spike Obstacles) Graphic

    player1-4:
    %00001000
    %00011000
    %00011000
    %00111100
    %01111110
    %11111111
    %11111111
    %00000000
end

    player1-4color:
    $42
    $42
    $42
    $42
    $42
    $42
    $42
    $42
end

;   Player5 (Traffic Cone) Graphic
    player5:
    %00000000
    %00011000
    %00111100
    %00111100
    %01111110
    %01111110
    %11111111
    %00000000
end

    player5color:
    $0E
    $38
    $38
    $38
    $36
    $0E
    $36
    $36
end

;   Player6 (Manhole) Graphic
    player6:
    %01111110
    %11111111
    %11111111
    %11111111
    %11111111
    %11111111
    %01111110
    %00000000
end

    player6color:
    $02
    $02
    $00
    $00
    $00
    $00
    $00
    $00
end

;   Player7 (Coin) Graphic
    player7:
    %00011000
    %00111100
    %01111110
    %01111110
    %01111110
    %01111110
    %00111100
    %00011000
end

    player7color:
    $1E
    $1E
    $1E
    $1C
    $1C
    $1C
    $1A
    $1A
end

;   Player8 (Score Mult) Graphic
    player8:
    %01110000
    %00010000
    %00010101
    %00010010
    %01110101
    %01000000
    %01000000
    %01110000
end

    player8color:
    $42
    $44
    $46
    $46
    $48
    $46
    $44
    $42
end

;   Player9 (Invincibility)  Graphic
    player9:
    %00011000
    %00011000
    %00111100
    %11111111
    %01111110
    %00111100
    %01100110
    %01000010
end

    player9color:
    $1E;
    $1E;
    $1C;
    $1A;
    $18;
    $16;
    $16;
    $14;
end

 ; Traffic Cone Spawn Positions
__SpikePosLeft
    player1x = 46 : player1y = player1y
    player2x = player1x + 13 : player2y = player1y + 14
    player3x = player2x + 13 : player3y = player2y + 14
    player4x = player3x + 13 : player4y = player3y + 14
    goto __MoveSpikes

__SpikePosRight
    player1x = 106 : player1y = player1y
    player2x = player1x - 13 : player2y = player1y + 14
    player3x = player2x - 13 : player3y = player2y + 14
    player4x = player3x - 13 : player4y = player3y + 14
    goto __MoveSpikes

__SpikePosMid
    player1x = 70 : player1y = player1y
    player2x = player1x - 13 : player2y = player1y + 42
    player3x = player1x + 13 : player3y = player1y + 14
    player4x = player3x + 13 : player4y = player3y + 14
    goto __MoveSpikes

__ConePosLeft
    player5x = 75 - 20 : player5y = player5y
    goto __MoveCone

__ConePosRight
    player5x = 75 + 20 : player5y = player5y
    goto __MoveCone

__ConePosMid
    player5x = 75 : player5y = player5y
    goto __MoveCone

__HolePosLeft
    player6x = 75 - 20 : player6y = player6y
    goto __MoveHole

__HolePosRight
    player6x = 75 + 20 : player6y = player6y
    goto __MoveHole

__HolePosMid
    player6x = 75 : player6y = player6y
    goto __MoveHole

__Game_Loop

    playfield:
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
    XXXXXXX..................XXXXXXX
end


    ;***************************************************************
    ;
    ;  Playfield colors.
    ;
    if _Invul = 0 then pfcolors:
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
    $02
end

    if _Invul = 1 then pfcolors:
    $0E
    $0C
    $0A
    $08
    $06
    $1E
    $1C
    $1A
    $18
    $16
    $2E
    $2C
    $2A
    $28
    $26
    $3E
    $3C
    $3A
    $38
    $36
    $4E
    $4C
    $4A
    $48
    $46
    $5E
    $5C
    $5A
    $58
    $56
    $6E
    $6C
    $6A
    $68
    $66
    $7E
    $7C
    $7A
    $78
    $76
    $9E
    $9C
    $9A
    $98
    $96
    $AE
    $AC
    $AA
    $A8
    $A6
    $BE
    $BC
    $BA
    $B8
    $B6
    $CE
    $CC
    $CA
    $C8
    $C6
    $DE
    $DC
    $DA
    $D8
    $D6
    $EE
    $EC
    $EA
    $E8
    $E6
    $3E
    $3C
    $3A
    $38
    $36
    $4E
    $4C
    $4A
    $48
    $46
    $5E
    $5C
    $5A
    $58
    $56
    $6E
    $6C
    $6A
    $68
    $66
    $0E
    $0C
    $0A
    $08
    $06
    $1E
    $1C
    $1A
    $18
    $16
    $2E
    $2C
    $2A
    $28
    $26
    $3E
    $3C
    $3A
    $38
    $36
    $4E
    $4C
    $4A
    $48
    $46
    $5E
    $5C
    $5A
    $58
    $56
    $6E
    $6C
    $6A
    $68
    $66
    $7E
    $7C
    $7A
    $78
    $76
    $9E
    $9C
    $9A
    $98
    $96
    $AE
    $AC
    $AA
    $A8
    $A6
    $BE
    $BC
    $BA
    $B8
    $B6
    $CE
    $CC
    $CA
    $C8
    $C6
    $DE
    $DC
    $DA
    $D8
    $D6
    $EE
    $EC
    $EA
    $E8
    $E6
    $3E
    $3C
    $3A
    $38
    $36
    $4E
    $4C
    $4A
    $48
    $46
    $5E
    $5C
    $5A
    $58
    $56
    $6E
    $6C
    $6A
    $68
    $66
    $0E
    $0C
    $0A
    $08
    $06
    $1E
    $1C
    $1A
    $18
    $16
    $2E
    $2C
    $2A
    $28
    $26
    $3E
    $3C
    $3A
    $38
    $36
    $4E
    $4C
    $4A
    $48
    $46
    $5E
    $5C
    $5A
    $58
    $56
    $6E
    $6C
    $6A
    $68
    $66
    $7E
    $7C
    $7A
    $78
    $76
    $9E
    $9C
    $9A
    $98
    $96
    $0E
    $0C
    $0A
    $08
    $06
    $1E
    $1C
    $1A
    $18
    $16
    $2E
    $2C
    $2A
    $28
    $26
    $3E
    $3C
    $3A
    $38
    $36
    $4E
    $4C
    $4A
    $48
    $46
    $5E
    $5C
    $5A
    $58
    $56
end

    ;  RevEng trick to get 256 playfield colors. Read more here:
    ;  http://atariage.com/forums/topic/214909-bb-with-native-64k-cart-support-11dreveng/page-12#entry2910997
    pfscroll 255 4 4

    if _Invul = 0 then pfcolors:
    $02
end

    if _Invul = 1 then pfcolors:
    $54
end

    ;  Scrolls the foreground color.
    
    _CarSound = 1
    if _CarSound then AUDC0 = 1 : AUDV0 = 2 : AUDF0 = 31 else AUDC0 = 0

    _ObstaclePositionRNG = rand
    _ObstacleTypeRNG = rand

    ; Flips the Sprite
    if joy0right then REFP0 = 0
    if joy0left then REFP0 = 8

    ; Player Movement
    if joy0right then player0x = player0x + 2
    if joy0left then player0x = player0x - 2
    if joy0up then player0y = player0y - 1
    if joy0down then player0y = player0y + 2

    ; Collision Detection
        ; batari Basic only handles collision between player0 and player1 so this is a neat workaround using pixel position distances:
    ; Obstacles
    if !_Invul && (player0y + 7) >= player1y && player0y <= (player1y + 7) && (player0x + 8) >= player1x && player0x <= (player1x + 7) then goto __StopAfterBadCollision
    if !_Invul && (player0y + 7) >= player2y && player0y <= (player2y + 7) && (player0x + 8) >= player2x && player0x <= (player2x + 7) then goto __StopAfterBadCollision
    if !_Invul && (player0y + 7) >= player3y && player0y <= (player3y + 7) && (player0x + 8) >= player3x && player0x <= (player3x + 7) then goto __StopAfterBadCollision
    if !_Invul && (player0y + 7) >= player4y && player0y <= (player4y + 7) && (player0x + 8) >= player4x && player0x <= (player4x + 7) then goto __StopAfterBadCollision
    if !_Invul && (player0y + 7) >= player5y && player0y <= (player5y + 7) && (player0x + 8) >= player5x && player0x <= (player5x + 7) then goto __StopAfterBadCollision
    if !_Invul && (player0y + 7) >= player6y && player0y <= (player6y + 7) && (player0x + 8) >= player6x && player0x <= (player6x + 7) then goto __StopAfterBadCollision

    ; Coin
    if (player0y + 7) >= player7y && player0y <= (player7y + 7) && (player0x + 8) >= player7x && player0x <= (player7x + 7) then goto __CoinCollision else goto __Skip_CoinCollision

__CheckforMult
    ; Score Mult Powerup
    if (player0y + 7) >= player8y && player0y <= (player8y + 7) && (player0x + 8) >= player8x && player0x <= (player8x + 7) then goto __MultCollision else goto __Skip_MultCollision

__CheckforInvul
    ; Invincibility Powerup
    if (player0y + 7) >= player9y && player0y <= (player9y + 7) && (player0x + 8) >= player9x && player0x <= (player9x + 7) then goto __InvulCollision else goto __Skip_InvulCollision

__CoinCollision
    if _isCoin_Active then gosub __Sub_AddScore : _Coin_SoundTimer = 255
    _isCoin_Active = 0
    player7y = 184
    goto __Continue
__Skip_CoinCollision

    goto __CheckforMult

__MultCollision
    if _isMultPickup_Active then _ScoreMult = 1 : _ScoreMultDuration = 255
    _isMultPickup_Active = 0
    player8y = 184
    goto __Continue
__Skip_MultCollision

    goto __CheckforInvul

__InvulCollision
    if _isInvulPickup_Active then _Invul = 1 : _InvulDuration = 255
    _isInvulPickup_Active = 0
    player9y = 184
    goto __Continue
__Skip_InvulCollision

__Continue

    ; Restrains player to the road
    if player0x < 44 then player0x = 44
    if player0x > 108 then player0x = 108
    if player0y < 1 then player0y = 1
    if player0y > 160 then player0y = 160

    if _CurrentActiveObstacle = 1 then goto __MoveSpikes
    if _CurrentActiveObstacle = 2 then goto __MoveCone
    if _CurrentActiveObstacle = 3 then goto __MoveHole

    ; Obstacle Movement

__MoveSpikes
    player1y = player1y + _Speed
    player2y = player2y + _Speed
    player3y = player3y + _Speed
    player4y = player4y + _Speed
    goto __SkipOtherObstacleMovement

__MoveCone
    player5y = player5y + _Speed + 1
    goto __SkipOtherObstacleMovement

__MoveHole
    player6y = player6y + _Speed + 1
    goto __SkipOtherObstacleMovement

__SkipOtherObstacleMovement

__MoveCoin
    if !_isCoin_Active then goto __Skip_MoveCoin
    player7y = player7y + _Speed - 1
    if player7y >= 180 && player7y <= 182 then _isCoin_Active = 0 : goto __CoinCollision
    goto __Skip_Spawn_Coin
__Skip_MoveCoin

__MoveMult
    if !_isMultPickup_Active then goto __Skip_MoveMult
    player8y = player8y + _Speed
    if player8y >= 180 && player8y <= 182 && _isMultPickup_Active then _isMultPickup_Active = 0 : goto __MultCollision
    goto __Skip_Spawn_Mult
__Skip_MoveMult

__MoveInvul
    if !_isInvulPickup_Active then goto __Skip_MoveInvul
    player9y = player9y + _Speed - 1
    if player9y >= 180 && player9y <= 182 then _isInvulPickup_Active = 0 : goto __InvulCollision
    goto __Skip_Spawn_Invul
__Skip_MoveInvul

    ; chance for a powerup type to spawn
    _PowerupTypeRNG = rand
    if _PowerupTypeRNG < 154 && !_isCoin_Active && !_isMultPickup_Active && !_isInvulPickup_Active then goto __Spawn_Coin
    if _PowerupTypeRNG >= 154 && _PowerupTypeRNG < 204 && !_isMultPickup_Active && !_isCoin_Active && _isInvulPickup_Active then goto __Spawn_Mult
    if _PowerupTypeRNG >= 204 && !_isMultPickup_Active && !_isCoin_Active && _isInvulPickup_Active then goto __Spawn_Invul
    

__Spawn_Coin
    player7x = (rand&127) : player7y = 184
    if player7x < 50 then player7x = 50
    if player7x > 100 then player7x = 100
    _isCoin_Active = 1
    goto __MoveCoin
__Skip_Spawn_Coin

__Spawn_Mult
    if _ScoreMult = 1 then goto __Skip_Spawn_Mult
    player8x = (rand&127) : player8y = 184
    if player8x < 50 then player8x = 50
    if player8x > 100 then player8x = 100
    _isMultPickup_Active = 1
    goto __MoveMult
__Skip_Spawn_Mult

__Spawn_Invul
    if _Invul = 1 then goto __Skip_Spawn_Invul
    player9x = (rand&127) : player9y = 184
    if player9x < 50 then player9x = 50
    if player9x > 100 then player9x = 100
    _isInvulPickup_Active = 1
    goto __MoveInvul
__Skip_Spawn_Invul

    ; Obstacle Speed increases based on score
    ; Fraction Computation
    _fracmem = _Fraction_Counter
    _Fraction_Counter = _Fraction_Counter + _Fraction

    _Speed = _Integer : if _Fraction_Counter < _fracmem then _Speed = _Speed + 1
    if _Speed >= 3 then _Speed = 3

    ; Obstacle Scroll Timing Loop
    ; randomize next Obstacle Position
    if player1y >= 180 && player1y <= 182 then goto __Get_New_Obstacle
    if player5y >= 179 && player5y <= 182 then goto __Get_New_Obstacle
    if player6y >= 179 && player6y <= 182 then goto __Get_New_Obstacle
    goto __Skip_ObstacleCheck

__Get_New_Obstacle
    player1y = 183 : player5y = 183 : player6y = 183     ;resets y positions
    gosub __Sub_AddScore
    _tempscore = score - 1
    _8_8_Speed = _8_8_Speed + 0.05
    _ObstacleTypeRNG = rand

    ; 40% to spawn either a cone or a hole, 60% to spawn spikes
    if _ObstacleTypeRNG <= 51 then goto __SpawnCone
    if _ObstacleTypeRNG > 51 && _ObstacleTypeRNG <= 102 then goto __SpawnHole
    if _ObstacleTypeRNG > 102 then goto __SpawnSpike

__SpawnCone
    _ObstaclePositionRNG = rand
    _sizeVariation = rand

    ; 25% chance for cone to spawn 2x wider, 10% chance to spawn 4x wider
    if _sizeVariation < 64 then NUSIZ5 = $05 else NUSIZ5 = $00
    if _sizeVariation < 26 then NUSIZ5 = $07

    _CurrentActiveObstacle = 2
    if _ObstaclePositionRNG <= 90 then goto __ConePosLeft
    if _ObstaclePositionRNG > 90 && _ObstaclePositionRNG <= 180 then goto __ConePosRight
    if _ObstaclePositionRNG > 180 then goto __ConePosMid

__SpawnHole
    _ObstaclePositionRNG = rand
    _sizeVariation = rand

    ; same size chances as the cone
    if _sizeVariation < 64 then NUSIZ6 = $05 else NUSIZ6 = $00
    if _sizeVariation < 26 then NUSIZ6 = $07

    _CurrentActiveObstacle = 3
    if _ObstaclePositionRNG <= 90 then goto __HolePosLeft
    if _ObstaclePositionRNG > 90 && _ObstaclePositionRNG <= 180 then goto __HolePosRight
    if _ObstaclePositionRNG > 180 then goto __HolePosMid

__SpawnSpike
    _ObstaclePositionRNG = rand
    _CurrentActiveObstacle = 1
    if _ObstaclePositionRNG <= 90 then goto __SpikePosLeft
    if _ObstaclePositionRNG > 90 && _ObstaclePositionRNG <= 180 then goto __SpikePosRight
    if _ObstaclePositionRNG > 180 then goto __SpikePosMid

__Skip_ObstacleCheck

    ; Timers
    if _ScoreMultDuration > 1 then _ScoreMultDuration = _ScoreMultDuration - 1
    if _Coin_SoundTimer > 1 then _Coin_SoundTimer = _Coin_SoundTimer - 1
    if _InvulDuration > 1 then _InvulDuration = _InvulDuration - 1
    if _ScoreMultDuration <= 1 then _ScoreMult = 0
    if _InvulDuration <= 1 then _Invul = 0
    
    ; Sounds
    ; Coin & ScoreMult
    if _Coin_SoundTimer > 230 || _ScoreMultDuration > 230 then AUDC0 = 5 : AUDV0 = 4 : AUDF0 = 10 else AUDC0 = 0

    ; Invul
    if _InvulDuration > 230 then AUDC0 = 7 : AUDV0 = 4 : AUDF0 = 10 else AUDC0 = 0
    
    ; Scrolls the foreground color
    if _Invul = 1 then pfscroll _InvulDuration 4 4

    ;***************************************************************
    ;
    ;  Scrolls the background color at a slower speed than the
    ;  foreground color.
    ;
    _Background_Scroll_Counter = _Background_Scroll_Counter - 1

    if !_Background_Scroll_Counter then _Background_Scroll_Counter = 1 : pfscroll 255 6 6

    ;  Sets DFxFRACINC registers.
    DF6FRACINC = 255 ; Background colors.
    DF4FRACINC = 255 ; Playfield colors.

    DF0FRACINC = 128 ; Column 0.
    DF1FRACINC = 128 ; Column 1.
    DF2FRACINC = 128 ; Column 2.
    DF3FRACINC = 128 ; Column 3.
 
    ;  Displays the screen.
    drawscreen




    ;  Reset switch check and end of main loop.
    ;  Any Atari 2600 program should restart when the reset  
    ;  switch is pressed. It is part of the usual standards
    ;  and procedures.
    ;```````````````````````````````````````````````````````````````
    ;  Turns off reset restrainer bit and jumps to beginning of
    ;  main loop if the reset switch is not pressed.
    if !switchreset then _Bit0_Reset_Restrainer{0} = 0 : goto __Game_Loop

    ;  Jumps to beginning of main loop if the reset switch hasn't
    ;  been released after being pressed.
    if _Bit0_Reset_Restrainer{0} then goto __Game_Loop

    ;  Restarts the program.
    goto __Start_Restart


    ;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    ;```````````````````````````````````````````````````````````````
    ;
    ;  END OF MAIN LOOP
    ;
    ;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
    ;```````````````````````````````````````````````````````````````

__StopAfterBadCollision
    ; Plays audio when car hits an obstacle
    _CarSound = 0
    if _Delay <= 100 && _Delay > 75 then AUDC0 = 3 : AUDV0 = 10 : AUDF0 = 31 else AUDC0 = 0

    COLUP0 = $0E
    player0color:
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
end

    ; Pauses all movement on player death
    player0x = player0x : player0y = player0y
    player1x = player1x : player1y = player1y
    player2x = player2x : player2y = player2y
    player3x = player3x : player3y = player3y
    player4x = player4x : player4y = player4y
    player5x = player5x : player5y = player5y
    player6x = player6x : player6y = player6y
    player7x = player7x : player7y = player7y
    player8x = player8x : player8y = player8y
    player9x = player9x : player9y = player9y

    drawscreen

    if _Delay > 1 then _Delay = _Delay - 1 else goto __GameOver_Screen
    goto __StopAfterBadCollision

__GameOver_Screen
    ; Hide all player sprites
    player0y = 200
    player1y = 200
    player2y = 200
    player3y = 200
    player4y = 200
    player5y = 200
    player6y = 200
    player7y = 200
    player8y = 200
    player9y = 200

    playfield:
    ................................
    ................................
    ................................
    ................................
    ....XXXX...XX...X...X...XXX.....
    ....XXXXX.XXXX.XXX.XXX..XXX.....
    ...XXXXXX.XXXX.XXX.XXX.XXX......
    ...XX...X.X.XX.XXX.XXX.XX.......
    ...X....X.X..X.X.X.X.X.XX.......
    ...X....X.X..X.X.XXX.X.X........
    ...X....X.X..X.X.XXX.X.X........
    ...X....X.X..X.X..X..X.X........
    ...X....X.X..X.X..X..X.X........
    ...X....X.X..X.X..X..X.X........
    ...X....X.XX.X.X..X..X.X........
    ...X....X.XX.X.X.....X.X........
    ...X......XXXX.X.....X.X........
    ...X......XXXX.X.....X.XXX......
    ...X......XXXX.X.....X.XXX......
    ...X......XXXX.X.....X.XXX......
    ...X......X..X.X.....X.X........
    ...X......X..X.X.....X.X........
    ...X.XXXX.X..X.X.....X.X........
    ...X..XXX.X..X.X.....X.X........
    ...X...XX.X..X.X.....X.X........
    ...X....X.X..X.X.....X.X........
    ...X....X.X..X.X.....X.X........
    ...X....X.X..X.X.....X.X........
    ...X....X.X..X.X.....X.X........
    ...X....X.X..X.X.....X.X........
    ...XX...X.X..X.X.....X.XX.......
    ...XX...X.X..X.X.....X.XX.......
    ...XXXXXX.X..X.X.....X.XXX......
    ....XXXX..X..X.X.....X..XXX.....
    ....XXXX..X..X.X.....X..XXX.....
    ................................
    ................................
    ................................
    ................................
    ................................
    ................XXX..XXXX.......
    ....XXXX..X..X..XXX..XXXX.......
    ....XXXX..X..X.XXX..XXXXXX......
    ...XXXXXX.X..X.XX...XX..XX......
    ...XX..XX.X..X.X....XX...X......
    ...XX..XX.X..X.X....X....X......
    ...X....X.X..X.X....X....X......
    ...X....X.X..X.X....X....X......
    ...X....X.X..X.X....X....X......
    ...X....X.X..X.X....X....X......
    ...X....X.X..X.X....X....X......
    ...X....X.X..X.X....XX..XX......
    ...X....X.X..X.X....XXXXXX......
    ...X....X.X..X.X....XXXXX.......
    ...X....X.X..X.X....XXXXX.......
    ...X....X.X..X.XXX..XX..........
    ...X....X.X..X.XXX..XX..........
    ...X....X.X..X.XXX..XXX.........
    ...X....X.X..X.XXX..X.X.........
    ...X....X.X..X.X....X.X.........
    ...X....X.X..X.X....X.XX........
    ...X....X.X..X.X....X.XX........
    ...X....X.X..X.X....X..XX.......
    ...X....X.XX.X.X....X..XX.......
    ...X....X.XXXX.X....X...X.......
    ...X....X..XX..X....X...XX......
    ...X....X..XX..X....X...XX......
    ...X....X..XX..X....X....X......
    ...X....X..XX..X....X....X......
    ...XX..XX..XX..XX...X....X......
    ...XX..XX..XX..XX...X....X......
    ...XXXXXX..XX..XXX..X....X......
    ....XXXX...X....XXX.X....X......
    ....XXXX........XXX.X....X......
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
end


    pfcolors:
    $0E
    $0E
    $0E
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $36
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
end


    bkcolors:
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
end

    drawscreen
    if joy0fire then goto __Game_init                         ; Spacebar - Restart Game
    if joy0left then goto __Bank3_init bank3        ; Left Arrow - Go Back to Main Menu 
    
    goto __GameOver_Screen

__Sub_AddScore
    if !_ScoreMult then score = score + 1 else score = score + 2
    return

    bank 3
    temp1=temp1

__Bank3_init
    playfield:
    ................................
    ................................
    ................................
    ................................
    ...XX.XX..X.X.X..X....X..XX..X..
    ..XX..XXX.X.X.X.XX...XX.XX..XX..
    ..X...X.X.X.X.X.XX...XX.X...X...
    ..X...X.X.X.X.X.X....X..X...X...
    ..X...X.X.X.X.X.X....X..X...X...
    ..XX..XXX.X.XX..XX...XX.XX..X...
    ...XX.XX..X.XX..X....X...XX.X...
    ....X.X...X.X.X.X....X....X.X...
    ....X.X...X.X.X.X....X....X.X...
    ....X.X...X.X.X.X....X....X.X...
    ...XX.X...X.X.X.XX...XX..XX.XX..
    ..XX..X...X.X.X..X....X.XX...X..
    ................................
    ................................
    ........................X.X.XX..
    ........................X.X.XX..
    ........................X.X..X..
    ........................X.X..X..
    ........................X.X..X..
    ........................XXX.XX..
    ........................XXX.X...
    .........................X..XX..
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ..XX........XX..................
    ..X..........X..................
    ..X..........X..................
    ..X.X.X.XXXX.X.XXX.X..XXX.X.X...
    ..X.X.X.X.X..X.X.X.X..X.X.X.X...
    ..X.X.X.X.X..X.X.X.X..X.X.X.X...
    ..X.XXX.X.X..X.XXX.X..X.X.XXX...
    ..X.XXX.X.X..X.X...X..XXX..X....
    ..X.XXX.X.X..X.X...X..X.X..X....
    ..X.X.X.X.X..X.X...X..X.X..X....
    ..X.X.X.X.X..X.X...XX.X.X..X....
    ..X..........X..................
    ..X..........X..................
    ..XX........XX..................
    ................................
    ................................
    ....................XX..X..XX...
    ....................X..XXX.X.X..
    ................X...X..XXX.X.X..
    .................X..X..X.X.XXX..
    ..................X.X..XXX.XX...
    ................X.X.X..X.X.XXX..
    ...XXXXXXX........X.X..X.X.X.X..
    ...X.....X.......X..XX.X.X.X.X..
    ..XX.....XX.....X...............
    ..X.......X.....................
    ..X.....X.X.....................
    .XX.....X.XX.XX.................
    XX......X..X.XX.................
    XX......XX.XXXX.................
    X........X.XXXX.................
    X......X.X..XXX.................
    X......X....XXX.................
    X...........X.X.................
    X...........X...................
    XXXXXXXXXXXXXX..................
    XXXXXXXXXXXXXX..................
    XXXXXXXXXXXXXXX.................
    X....XXX....XXX.................
    X....XXX....XXX..X...X...X...X..
    X....XXX....XXX.XXX.XXX.XXX.XXX.
    XXXXXXXXXXXXXXX.XXXXXXXXXXXXXXXX
    XXXXXXXXXXXXXX..................
    XXXXXXXXXXXXXX..................
    .XXXXXXXXXXXX...................
    .XXXXXXXXXXXX...................
    .XXXXXXXXXXXX...................
    .XXX......XXX...................
    .XXX......XXX...................
    .XXX......XXX...................
    .XXX......XXX...................
    .XXX......XXX...................
    .XXX......XXX...................
    ................................
end

    pfcolors:
    $0E
    $0E
    $0E
    $0E
    $0C
    $0C
    $0E
    $0E
    $0E
    $0C
    $0E
    $18
    $18
    $18
    $0E
    $0E
    $0E
    $0E
    $36
    $36
    $0E
    $36
    $36
    $36
    $36
    $36
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0C
    $0E
    $0E
    $1E
    $1E
    $1E
    $1E
    $0E
    $0E
    $0C
    $0A
    $0A
    $00
    $00
    $00
    $00
    $00
    $00
    $00
end

    bkcolors:
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
end

__MainMenu_Screen

    ;  88 rows that are 2 scanlines high.
    DF6FRACINC = 255 ; Background colors.
    DF4FRACINC = 255 ; Playfield colors.

    DF0FRACINC = 128 ; Column 0.
    DF1FRACINC = 128 ; Column 1.
    DF2FRACINC = 128 ; Column 2.
    DF3FRACINC = 128 ; Column 3.

    ;  Simple fix for the top two lines having the same color.
    asm
    lda DF6FRACDATA
    lda DF4FRACDATA
end

    drawscreen
    
    dim _Screen_Tracker = var3
    dim _ButtonDelayOffset = var2
    _ButtonDelayOffset = 30

    if joy0fire then goto __Game_init bank2
    if joy0right then goto __Car_Select

    goto __MainMenu_Screen

__Car_Select

    playfield:
    ................................
    ................................
    ................................
    .XX.X.X.XXX.XXX.XXX.XX..X.X.XXX.
    .XX.X.X.XXX.XXX.XXX.XX..X.X.XXX.
    .X..X.X.XXX.X.X.X...X...X.X.X.X.
    .X..X.X.X.X.X.X.X...XX..X.X.X.X.
    .X..XXX.X.X.X.X.XXX.XX..X.X.X.X.
    .X..XXX.X.X.X.X.XXX.X...X.X.XXX.
    .X..XXX.X.X.X.X...X.X...X.X.XXX.
    .X..X.X.X.X.X.X...X.X...X.X.XX..
    .X..X.X.XXX.XXX...X.XX..XXX.X.X.
    .XX.X.X.XXX.XXX.XXX.XX..XXX.X.X.
    .XX.X.X.XXX.XXX.XXX.XX..XXX.X.X.
    ................................
    ................................
    ................................
    ................................
    ..........XX.XXX.XXX............
    ..........XX.XXX.XXX............
    ..........X..X.X.X.X............
    ..........X..X.X.X.X............
    ..........X..X.X.X.X............
    ..........X..XXX.XXX............
    ..........X..XXX.XXX............
    ..........X..X.X.XX.............
    ..........X..X.X.XX.............
    ..........X..X.X.X.X............
    ..........XX.X.X.X.X............
    ..........XX.X.X.X.X............
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ........X.............X.........
    ........X.............XX........
    .......XX..............X........
    .......X...............XX.......
    ......XX................X.......
    ......X.................X.......
    .....XX..................X......
    .....X...................X......
    .....X...................X......
    .....XX.................XX......
    ......X.................X.......
    ......XX...............XX.......
    .......X...............X........
    .......XX.............XX........
    ........X.............X.........
    ........X.............X.........
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ..XXX.XXX.X...XXX.XXX.XXX.......
    ..X.X.X...X...X...X....X........
    ..X...X...X...X...X....X........
    ..X...X...X...X...X....X........
    ..X...X...X...X...X....X..X...X.
    ..XXX.XXX.X...XXX.X....X..X...X.
    ....X.X...X...X...X....X..XXXXX.
    ....X.X...X...X...X....X........
    ....X.X...X...X...X....X........
    ..X.X.X...X...X...X....X........
    ..XXX.XXX.XXX.XXX.XXX..X........
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
    ................................
end

    pfcolors:
    $0E
    $0E
    $0E
    $08
    $0C
    $0E
    $0E
    $0E
    $3A
    $0C
    $0E
    $0A
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0A
    $0C
    $0E
    $0E
    $0E
    $3A
    $3A
    $0E
    $0E
    $0E
    $0A
    $08
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1C
    $1A
    $1A
    $1A
    $0C
    $1A
    $1A
    $1A
    $1A
    $1A
    $1A
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
    $0E
end


    bkcolors:
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
    $96
end
    _CarOption = _CarOption

    player0x = 75
    player0y = 90

    if _CarOption = 0 then player0:
    %00000000
    %10011001
    %10101101
    %10111101
    %11100111
    %10111101
    %10111101
    %10110101
    %00100100
    %00101100
    %10011001
    %10111101
    %11100111
    %10111101
    %10011001
    %00000000
end
    if _CarOption = 0 then player0color:
    $20
    $20
    $30
    $34
    $32
    $32
    $30
    $30
    $34
    $34
    $34
    $36
    $36
    $36
    $3C
    $0E
end

    if _CarOption = 1 then player0:
    %00000000
    %10011001
    %10111101
    %11100111
    %10111101
    %10111101
    %10101101
    %00100100
    %00110100
    %00111100
    %10111101
    %10100101
    %11111111
    %10101101
    %10011001
    %00000000
end
    if _CarOption = 1 then player0color:
    $46
    $4A
    $4A
    $4A
    $4A
    $4A
    $4A
    $4A
    $4A
    $C8
    $C8
    $C8
    $C8
    $4A
    $4A
    $46
end

    if _CarOption = 2 then player0:
    %00011000
    %00011000
    %00011000
    %00011000
    %00011000
    %00111100
    %01111110
    %01111110
    %01111110
    %01111110
    %01111110
    %01111110
    %01111110
    %01111110
    %00111100
    %00000000
end
    if _CarOption = 2 then player0color:
    $C2
    $C2
    $C2
    $C2
    $C2
    $C2
    $C4
    $C8
    $C4
    $C6
    $C6
    $C8
    $C6
    $C4
    $C4
    $C4
end

    if _CarOption = 3 then player0:
    %00000000
    %00011000
    %00111100
    %00111100
    %01111110
    %01111110
    %01111110
    %01111110
    %00111100
    %00111100
    %01111110
    %01111110
    %01111110
    %01111110
    %00111100
    %00000000
end
    if _CarOption = 3 then player0color:
    $0E
    $80
    $82
    $82
    $80
    $62
    $84
    $84
    $62
    $62
    $86
    $86
    $62
    $94
    $80
    $B0
end

    if _CarOption = 4 then player0:
    %00000000
    %00111000
    %01111100
    %11111110
    %11111110
    %11111110
    %11111110
    %11111110
    %11111111
    %11111111
    %11111111
    %11111111
    %01111111
    %01101100
    %01101100
    %00000000
end
    if _CarOption = 4 then player0color:
    $02
    $06
    $08
    $0A
    $0A
    $0A
    $0A
    $0A
    $0A
    $F0
    $F0
    $F0
    $F0
    $1A
    $1A
    $46
end

    if _CarOption = 5 then player0:
    %00000000
    %00111100
    %00111100
    %00111100
    %00111100
    %01111110
    %01111110
    %01111110
    %01111110
    %01111110
    %00111100
    %00111100
    %00111100
    %00111100
    %00111100
    %00111100
end
    if _CarOption = 5 then player0color:
    $F0
    $F0
    $F0
    $F0
    $BA
    $BA
    $BA
    $BA
    $BA
    $BA
    $86
    $86
    $86
    $86
    $04
    $04
end 

    drawscreen

    dim _OptionCounter = var1

    if joy0fire then goto __MainMenu_Screen
    if joy0left then _OptionCounter = _OptionCounter - 1
    if joy0right then _OptionCounter = _OptionCounter + 1

    if _OptionCounter < _ButtonDelayOffset then _CarOption = 0
    if _OptionCounter >= _ButtonDelayOffset*1 && _OptionCounter < _ButtonDelayOffset*2 then _CarOption = 1
    if _OptionCounter >= _ButtonDelayOffset*2 && _OptionCounter < _ButtonDelayOffset*3 then _CarOption = 2
    if _OptionCounter >= _ButtonDelayOffset*3 && _OptionCounter < _ButtonDelayOffset*4 then _CarOption = 3
    if _OptionCounter >= _ButtonDelayOffset*4 && _OptionCounter < _ButtonDelayOffset*5 then _CarOption = 4
    if _OptionCounter >= _ButtonDelayOffset*5 && _OptionCounter < _ButtonDelayOffset*6 then _CarOption = 5

    if _OptionCounter > _ButtonDelayOffset*6 then _OptionCounter = 2
    if _OptionCounter < 1 then _OptionCounter = _ButtonDelayOffset*6

    

    goto __Car_Select

    bank 4
    temp1=temp1

    bank 5
    temp1=temp1




    bank 6
    temp1=temp1