! Exercise 8 - Track a circle with the robot
! Approximates a circle using small linear segments ( for full 360 degrees path)
! Uses sin/cos for point calculation ( RAPID math functions)

CONST num pi := 3.14159                    ! Pi constant
PERS num radius := 50;                     ! Circle radius in mm
PERS num centerX := 300;                   ! Circle center (base frame X)
PERS num centerY := 0;                     ! Circle center (base frame Y)
PERS num centerZ := 100;                   ! Fixed Z height for planar circle
PERS num numSegments := 36;                ! Number of segments (higher = smoother; 36 for 10 degree steps)
PERS robtarget pHome := [[400, 0, 500], [1,0,0,0], [0,0,0,0], [9E9,
