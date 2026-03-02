! Exercise 5 - Home corner square
! Move to a safe home position then draw a 100 x 100 square using RelTool offsets

PROC main()
  ! Starting at a safe home position
  MoveJ pHome, v500, z50, tool1;

  ! Move to the first corner of the square
  MoveL pStart, v100, fine, tool1;

  ! Trace the square using RelTool (X, Y, Z)
  MoveL RelTool(pStart, 100, 0, 0), v100, z1, tool1;    ! Move along X
  MoveL RelTool(pStart, 100, 100, 0), v100, z1, tool1;  ! Move along Y
  MoveL RelTool(pStart, 0, 100, 0), 