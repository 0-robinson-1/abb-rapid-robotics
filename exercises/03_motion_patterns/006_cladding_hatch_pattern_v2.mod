MODULE Ex006_CladdingHatch
! Exercise 6 - Cladding Hatch Pattern
! 5 parallel lines with laser simulation (SetDO)

  ! Speed for deposition
  CONST speeddata vCladding := [200, 500, 5000, 1000]; ! 200 mm/s TCP speed
                ! speeddata := [v_tcp,v_ori,v_leax,v_reax];
                ! v_tcp = 200 mm/s for the Tool Center Point linear speed in XYZ
                ! v_ori = 500 deg/s allowed for orientation changes
                ! v_leax = 5000 mm/s allowed on linear external axes (e.g. rails)
                ! v_reax = 1000 deg/s allowed on rotational external axes (e.g. chuck)

  PROC Ex006_Run()
    VAR num i;
    VAR robtarget pLineStart;
    VAR robtarget pLineEnd;

    ! 1. Safe approach Home
    MoveJ pHome, v500, z50, tool0;

    ! 3. Draw 5 parallel cladding lines
    FOR i FROM 0 TO 25 DO
      ! Build each line in the SAME reference frame as pStart
      pLineStart := Offs(pStart, 0, i*20, 0);
      pLineEnd := Offs(pStart, 150, i*20, 0);

      MoveL pLineStart, v200, z5, tool0;

      ! Turn laser OFF at the end of the line
      SetDO doLaser0, 1;
      MoveL pLineEnd, vCladding, z5, tool0;
      SetDO doLaser0, 0;
    ENDFOR

    ! 4. Return to safe home
    MoveJ pHome, v500, z50, tool0;

    TPWrite "Hatch pattern finished - 5 passes done";
  ENDPROC

ENDMODULE