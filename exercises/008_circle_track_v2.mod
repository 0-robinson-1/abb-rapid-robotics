MODULE Ex008_TrackCircle

! Exercise 8 - Track a circle with the robot
! Approximates a circle using small linear segments
! Uses sin/cos for point calculation ( RAPID math functions)

  LOCAL CONST num pi := 3.14159                    ! Pi constant
  LOCAL PERS num radius := 50;                     ! Circle radius in mm
  PERS num centerX := 300;                   ! Circle center (base frame X)
  PERS num centerY := 0;                     ! Circle center (base frame Y)
  PERS num centerZ := 100;                   ! Fixed Z height for planar circle
  CONST num numSegments := 36;                ! Number of segments (higher = smoother; 36 for 10 degree steps)
  PERS robtarget pHome := [[400, 0, 500], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]]; ! Safe home
  
  PROC Ex008_Run()
    VAR num angleStep;                       ! Angle increment in radians
    VAR num currentAngle := 0;               ! Starting angle
    VAR robtarget pCurrent;                  ! Dynamic target point
    VAR robtarget pNext;                     ! Next point in circle
    VAR num i;
  
    ! Compute angle step: 2*pi / segments (full circle)
    angleStep := 2 * pi / numSegments;
  
    ! Safe approach to home
    MoveJ pHome, v500, z50, tool0;
  
    ! Move to starting point of circle (angle 0: centerX + radius, centerY)
    pCurrent := [[centerX + radius, centerY, centerZ], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];
    MoveL pCurrent, v200, fine, tool0;
  
    ! Loop to trace the circle: Calculate points using polar coordinates
    FOR i FROM 1 TO numSegments DO
      ! Increment angle (radians)
      currentAngle := currentAngle + angleStep;
  
      ! Compute next point: x = centerX + radius * Cos(angle), y = centerY + radius * Sin(angle)
      pNext := [[centerX + radius * Cos(currentAngle),
                 centerY + radius * Sin(currentAngle),
                 centerZ],
                [1,0,0,0],
                [0,0,0,0],
                [9E9,9E9,9E9,9E9,9E9,9E9]];
  
      ! Move linearly to next point (small segment approximates arc)
      MoveL pNext, v100, z1, tool0; ! Low speed, small zone for smooth path
  
      ! Update current for next iteration (optional, for clarity)
      pCurrent := pNext;
    ENDFOR
  
    ! Return to home after completing the circle
    MoveJ pHome, v500, z50, tool0;
  
    TPWrite "Circle tracking complete - radius " + NumToStr(radius, 1) + " mm";
  ENDPROC

ENDMODULE
