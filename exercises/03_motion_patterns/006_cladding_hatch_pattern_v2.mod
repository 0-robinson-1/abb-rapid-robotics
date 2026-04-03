MODULE Ex006_CladdingHatch
! Exercise 6 - Cladding Hatch Pattern
! 5 parallel lines with laser simulation (SetDO)

  ! Reuse the same points from Exercise 5
    PERS robtarget pHome;
    PERS robtarget pStart;

  ! Speed for deposition
  CONST speeddata vCladding := [200, 500, 5000, 1000]; ! 200 mm/s TCP speed
                ! speeddata := [v_tcp,v_ori,v_leax,v_reax];
                ! v_tcp = 200 mm/s for the Tool Center Point linear speed in XYZ
                ! v_ori = 500 deg/s allowed for orientation changes
                ! v_leax = 5000 mm/s allowed on linear external axes (e.g. rails)
                ! v_reax = 1000 deg/s allowed on rotational external axes (e.g. chuck)

  PROC Ex006_Run()
    VAR num i;

    ! 1. Safe approach
    MoveJ pHome, v500, z50, tool0;

    ! 2. Go to start of first line
    MoveL pStart, v200, fine, tool0;

    ! 3. Draw 5 parallel cladding lines
    FOR i FROM 0 TO 4 DO
      ! Turn laser ON
      SetDO doLaser, 1;

      !MOVE forward 150 mm along the line at cladding speed
      MoveL RelTool(pStart, 150, i*20, 0), vCladding, z5, tool0;

      ! Turn laser OFF at the end of the line
      SetDO doLaser, 0;

      ! Small step-over to next line (20 mm in Y direction)
      MoveL RelTool(pStart, 0, (i+1)*20, 0), v200, z5, tool0;
    ENDFOR

    ! 4. Return to safe home
    MoveJ pHome, v500, z50, tool0;

    TPWrite "Hatch pattern finished - 5 passes done";
  ENDPROC

ENDMODULE
