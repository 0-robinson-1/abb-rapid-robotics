! Exercise 9 - Track a Helix with the robot
! 3D spiral path: Circle in XY while ascending in Z
! Approximates using linear segments; parametric with Cos/Sin and linear Z

CONST num pi := 3.14159;              ! Pi constant
PERS num radius := 50;                ! Helix radius in mm
PERS num centerX := 300;              ! Center X (base frame)
PERS num centerY := 0;                ! Center Y (base frame)
PERS num startZ := 100;               ! Starting Z height
PERS num pitch := 20;                 ! Height increase per full turn (mm/turn)
PERS num numTurns := 5;               ! Number of helical turns
PERS num segmentsPerTurn := 36;       ! Segments per turn (10° resolution)
PERS robtarget pHome := [[400,0,500], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9] ! Safe home
