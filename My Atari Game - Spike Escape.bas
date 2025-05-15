    ; GROUP 4 - BLOCK 2-3 BSCS
    
    x = 60 ; player0 x pos
    y = 60 ; player0 y pos
    a = 50 ; player1 (obstacle) x pos
    b = 71 ; player1 (obstacle) y pos
    r = 10 ; obstacle counter    
    scorecolor = $0E
    COLUBK=$00 ; background color 

    goto MainMenuScreen


MainMenuScreen ; displays the title screen before game starts 
        COLUPF = $0E
        playfield:
 .....XXXX.XXXXX.X.X..X.XXXX.....
 ....X.....X...X.X.X.X..X........
 ....XXXXX.XXXXX.X.XX...XXXX.....
 ........X.X.....X.X.X..X........
 ....XXXX..X.....X.X..X.XXXX.....
 XXXX..XXXX.XXXX...X...XXXXX.XXXX
 X....X.....X.....X.X..X...X.X...
 XXXX..XXXX.X....XXXXX.XXXXX.XXXX
 X........X.X....X...X.X.....X...
 XXXX.XXXX..XXXX.X...X.X.....XXXX
end

  drawscreen
 ; g = difficulty flag  
 if joy0fire then g = 2 : goto DifficultySettings  ; if fire button is pressed, it proceeds to gamestart
 goto MainMenuScreen

DifficultySettings 
 
 
  
 if joy0up || g = 2 then g = 2 : COLUPF = $0E : playfield:
 XXXXX....X....XXXXX.X...X.......
 X.......X.X...X.....X...X.......
 XXXXX..XXXXX...XXX...X.X........
 X.....X.....X.....X...X.........
 XXXXX.X.....X.XXXXX...X.........
 ................................
 ................................
 ................................
 ................................
 ................................
end

 if joy0down || g = 3 then g = 3 : COLUPF = $0E : playfield:
 ................................
 ................................
 ................................
 ................................
 ................................
 .....X...X....X....XXXX...XXXX..
 .....X...X...X.X...X...X..X...X.
 .....XXXXX..XXXXX..X....X.X....X
 .....X...X.X.....X.X...X..X...X.
 .....X...X.X.....X.X....X.XXXX..
end

 

 drawscreen

 if joy0right && g = 2 then goto gamestart 
 if joy0right && g = 3 then goto gamestart      

 goto DifficultySettings

gamestart
    
        ;road
        playfield:  
 ..XXXX..........................
 ...............XXXX.............
 ................................
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
 ................................
 ................................
 ................................
 ................................
 ................................
 XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
end
 

main
    d = 100 ; delay variable 
    
    COLUPF=$0E ; color of the playfield 
    COLUP0=$0E ; color of the car
    COLUP1=$1A ; color of the obstacle

    ; player0 is the car
    ; player1 is the obstacle 

    player0: ; Car
        %01000010
        %11111111
        %11111111
        %10100010
        %10100010
        %01100100
        %00111000
end
 ; obstacle sprites
 if r < 50 then   player1:       
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000       
end
 if r > 50 && r < 100 then   player1:
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
end
  if r > 100 && r < 150 then  player1:
        %00100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %00100000
end
    if r > 150 && r < 200 then  player1:
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
        %00100000
        %01100000
        %11100000
        %01100000
end

    if r > 200 && r < 255 then  player1:
        %00010000
        %00110000
        %01110000
        %00110000
        %00010000
        %00110000
        %01110000
        %00110000
        %00010000
        %00110000
        %01110000
        %00110000
        %00010000
        %00110000
        %01110000
        %00110000
        %00010000
        %00110000
        %01110000
        %00110000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00000000
        %00010000
        %00110000
        %01110000
        %00110000
        %00010000
        %00110000
        %01110000
        %00110000
end

   ; sets player0 and player1 starting position 
   player0x = x  
   player0y = y
   player1x = a 
   player1y = b
   

   c = c + 1 ; makes an endless loop for the road to scroll 
   if c>50 then pfscroll left : c = 0 ; makes the road move by scrolling it, creating an illusion that the car is moving forward
   
   a =  a - g ; makes the obstacle move from right to left by repeatingly decrements 'a' which is the x position of player1(obstacle)
   if a < 50 then AUDC1 = 4 : AUDF1 = 31 : AUDV1 = 2 else AUDC1 = 0 ; score sound 
   if a < 20 then a = 160:score = score + 1: r = rand ; resets the obstacle's position to the start
                                                        ; increments the score, and randomizes the occurence of each obstacle
   
   if joy0up then y = y-1 ; controls the up and down movement of the car by changing the y position of the car
   if joy0down then y = y+1 

   if !collision(player0,player1) then AUDC0 = 1: AUDV0 = 2 : AUDF0 = 31 ; the background sound will not stop until there is a collision 
 
   ; restrains the car to not move past the road 
   if y<39 then y=39 
   if y>72 then y=72

   if collision(player0,player1) then goto stopaftercollision   ; collision detection 
   drawscreen 

   goto main

stopaftercollision
   if d <= 100 && d > 75 then AUDC0 = 3 : AUDV0 = 10 : AUDF0 = 31 else AUDC0 = 0 ; boom sound when car hits the obstacle
   COLUP0 = $0E
   COLUP1 = $1A
   player0: ; animation sprite after collision 
    %00000000
    %00000000
    %00000000
    %00000000
    %00000000
    %01111111
    %01010101
    %11000001
    %10010001
    %10000001
    %11101101
    %11101101
    %10000001
    %11000011
    %01100110
    %00111100
end  
   player0x = x - 3
   player0y = y + 4
   player1x = a + 6 ; makes the screen freeze by setting the x and y pos of the car and the obstacle to it's current position
   player1y = b
   drawscreen
    
   if d > 1 then d = d - 1 else goto gameover ; delay before displaying the gameover screen  
   goto stopaftercollision
    

gameover 
   ; hides the car and the obstacle and the score is reset to 0
   player0x = 0
   player0y = 0
   player1x = 0 
   player1y = 0
   score = 0
 playfield:
 .XXX.XXX.XX.XX.XXXXX............
 .X...X.X.X.X.X.X................
 .X.X.XXX.X.X.X.XXXXX..X.X.X.X.X.
 .X.X.X.X.X.X.X.X................
 .XXX.X.X.X.X.X.XXXXX............
 ............XXXX.X.X.XXXXX.XX...
 ............X..X.X.X.X.....X.X..
 .X.X.X.X.X..X..X.X.X.X.XXX.XX...
 ............X..X.X.X.X.....X.X..
 ............XXXX..X..XXXXX.X.X..
 ................................
end
 
 drawscreen
 if joy0fire then player0x = 60 : player0y = 60 : a = 160 : b = 71 : goto gamestart ; if fire button is pressed, the game restarts
 if joy0left then player0x = 0 : player0y = 0 : a = 160 : b = 71 : goto MainMenuScreen 
 goto gameover