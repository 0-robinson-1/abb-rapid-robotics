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

PROC main()
  VAR num totalSegments;              ! Total points: turns 36 segmentsPerTurn
  VAR num angleStep;                  ! Angle increment per segment (radians)
  VAR num currentAngle := 0;          ! Starting angle
  VAR num currentZ := startZ;         ! Starting Z
  VAR robtarget pCurrent;             ! Dynamic current point
  VAR robtarget pNext;                ! Next point

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
