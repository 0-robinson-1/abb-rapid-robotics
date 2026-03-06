! Exercise 6 - Cladding Hatch Pattern
! 5 parallel lines with laser simulation (SetDO)

MODULE CladdingHatch

  !------------------------------------------------------------------------------
  ! Reuse the same points from Exercise 5
    PERS robtarget pHome  := [[400, 0, 500], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];
    PERS robtarget pStart := [[300, -150, 100], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];

  ! Speed for deposition (Change later to real values)
  COST speeddata vCladding := [200, 500, 5000, 1000]; ! 200 mm/s TCP speed

  PROC main()
    ! 1. Safe approach
    MoveJ pHome, v500, z50, tool0;

    ! 2. Go to start of first line
    MoveL pStart, v200, fine, tool0;

    ! 3. Draw 5 parallel cladding lines
    FOR i FROM 0 TO 4 DO
      ! Turn laser ON (digital output - replace doLaser with real signal)
      SetDO doLaser, 1;

      !MOVE forward 150 mm along the line at cladding speed
      MOVEL RelTool(pStart, 150, i*20, 0), vCladding, z5, tool0;

      ! Turn laser OFF at the end of the line
      Reset doLaser;

      ! Small step-over to next line (20 mm in Y direction)
      MoveL RelTool(pStart, 0, (i+1)*20, 0), v200, z5, tool0;
    ENDFOR

    ! 4. Return to safe home
    MoveJ pHome, v500, z50, tool0;

    TPWrite "Hatch pattern finished - 5 passes done";
  ENDPROC

ENDMODULE
