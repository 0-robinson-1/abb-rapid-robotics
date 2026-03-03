! Exercise 5 - Home corner square
! Move to a safe home position then draw a 100 x 100 square using RelTool offsets

! --------------------------------------------------------------------------------
! These two robtargets must exist (taught on the real robot or defined here, I defined them here)
PERS robtarget pHome  := [[400, 0, 500], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];
PERS robtarget pStart := [[300, -100, 100], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9];

PROC main()
  ! 1. Safe approach to home position (joint motion, fast)
  MoveJ pHome, v500, z50, tool0;        ! tool0 = default tool 

  ! Move to the first corner of the square
  MoveL pStart, v100, fine, tool1;

  ! Trace the square using RelTool (X, Y, Z)
  MoveL RelTool(pStart, 100, 0, 0), v100, z1, tool1;    ! Move along X
  MoveL RelTool(pStart, 100, 100, 0), v100, z1, tool1;  ! Move along Y
  MoveL RelTool(pStart, 0, 100, 0), 
