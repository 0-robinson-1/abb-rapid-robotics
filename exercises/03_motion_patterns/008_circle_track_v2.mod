MODULE Ex008_TrackCircle

! Exercise 8 - Track a circle with the robot
! Approximates a circle using small linear segments
! Uses sin/cos for point calculation ( RAPID math functions)

  LOCAL CONST num pi := 3.14159;                   ! Pi constant
  LOCAL CONST int numSegments := 36;               ! 36 segments = 10 ° steps

  LOCAL PERS num radius := 50;                     ! Circle radius in mm

  ! These will be calculated from pStart
  LOCAL VAR num centerX;
  LOCAL VAR num centerY;
  LOCAL VAR num centerZ;
  
  PROC Ex008_Run()
    VAR num angleStep;                       ! Angle increment in radians
    VAR num currentAngle := 0;               ! Starting angle
    VAR robtarget pNext;                     ! Next point in circle
    VAR num i;
  
    ! Compute angle step: 2*pi / segments (full circle)
    angleStep := 2 * pi / numSegments;
  
    ! Safe approach to home (taught in CommonData)
    MoveJ pHome, v500, z50, tool0;
  
    ! Move to starting point of circle
    MoveL CommonData\pStart, v200, fine, tool0 \WObj:wobj0;

    !------------------Fix code below
  
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