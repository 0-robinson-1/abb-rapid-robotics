MODULE Ex005_HomeCornerSquare
! Exercise 5 - Home corner square
! Move to a safe home position then draw a 100 x 100 square using RelTool offsets

  PERS robtarget pHome  := [[600, 0, 600], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];
  PERS robtarget pStart := [[600, -500, 300], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];

  PROC Ex005_Run()
      ! 1. Safe approach to home position (joint motion, fast)
      MoveJ pHome, v500, z50, tool0;        ! tool0 = default tool 

      ! 2. Move linearly to the first corner of the square (precise stop)
      MoveL pStart, v100, fine, tool0;

      ! 3. Trace the square from pStart using RelTool (X, Y, Z)
      MoveL RelTool(pStart, 400, 0, 0), v100, z1, tool0;    ! Move along X (right, corner 2)
      MoveL RelTool(pStart, 400, 400, 0), v100, z1, tool0;  ! Move along Y (forward, corner 3)
      MoveL RelTool(pStart, 0, 400, 0), v100, z1, tool0;    ! Move along X (Left, corner 4)
      MoveL pStart, v100, fine, tool0;    ! Move along Y (Back to pStart, corner 1)

      ! 4. Return to safe home position
      MoveJ pHome, v500, z50, tool0;

  ENDPROC

ENDMODULE