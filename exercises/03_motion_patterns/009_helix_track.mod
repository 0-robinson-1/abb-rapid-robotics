MODULE Ex009_HelixTrack
! Exercise 9 - Track a Helix
! 3D spiral path: Circle in XY while ascending in Z
! Approximates using linear segments; parametric with Cos/Sin and linear Z

LOCAL CONST num numSegments := 36;    ! 36 segments = 10° steps
LOCAL PERS num radius := 50;          ! Helix radius in mm

PROC Ex009_Run()
  VAR num angleStep;                    ! Angle increment
  VAR num currentAngle := 0;            ! Starting angle
  VAR robtarget pStartLocal;            ! Copying pStart to pStartLocal to avoid errors...
  VAR robtarget pNext;                ! Next point
  VAR num centerX
  VAR num centerY
  VAR num centerZ
  VAR num i;
  PERS num pitch := 20;                 ! Height increase per full turn (mm/turn)
  PERS num numTurns := 5;               ! Number of helical turns


    VAR robtarget pCurrent;             ! Dynamic current point


    ! Compute totals: Higher segments = smoother helix
    totalSegments := numTurns * segmentsPerTurn;
    angleStep := 2 * pi / segmentsPerTurn;  ! Per segment angle (fixed per turn)

    ! Safe approach to home 
    MoveJ pHome, v500, z50, tool0;

    ! Move to starting point: angle=0, Z=startZ
    pCurrent := [[centerX + radius * Cos(0), centerY + radius * Sin(0), startZ], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];
    MoveL pCurrent, v200, fine, tool0;

    ! Loop to trace the helix: Increment angle and Z proportionally
    FOR i FROM 1 TO totalSegments DO
      ! Update angle: Cumulative for full turns
      currentAngle := currentAngle + angleStep;

      ! Update Z: Linear ascent = (i/ totalSegments) * total height (pitch * turns)
      currentZ := startZ + (i/ totalSegments) * (pitch * numTurns);

      ! Compute next point: Parametric helix equations
      pNext := [[centerX + radius * Cos(currentAngle),
            centerY + radius * Sin(currentAngle),
            currentZ],
            [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];

      ! Move linearly to next point (small segments approximates curve)
      MoveL pNext, v100, z1, tool0; !Low speed, small fly-by for continuity

      ! Update current for next iteration
      pCurrent := pNext;
    ENDFOR

    ! Return to home after completing the helix
    MoveJ pHome, v500, z50, tool0;

    TPWrite "Helix tracking complete - " \Num:=numTurns \ " turns, pitch " \Num:=pitch \ " mm";
  ENDPROC

ENDMODULE