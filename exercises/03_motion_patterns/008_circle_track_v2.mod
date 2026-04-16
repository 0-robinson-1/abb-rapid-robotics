MODULE Ex008_TrackCircle

! Exercise 8 - Track a circle with the robot
! Approximates a circle using small linear segments
! Uses sin/cos for point calculation (RAPID math functions)

  LOCAL CONST num pi := 3.14159;                   ! Pi constant
  LOCAL CONST num numSegments := 36;               ! 36 segments = 10° steps

  LOCAL PERS num radius := 50;                     ! Circle radius in mm

  ! These will be calculated from pStart
  LOCAL VAR num centerX;
  LOCAL VAR num centerY;
  LOCAL VAR num centerZ;
  
  PROC Ex008_Run()
    VAR num angleStep;                       ! Angle increment in radians
    VAR num currentAngle := 0;               ! Starting angle
    VAR robtarget pStartLocal;               ! Copying pStart to pStartLocal to avoid errors...
    VAR robtarget pNext;                     ! Next point in circle
    VAR num centerX;
    VAR num centerY;
    VAR num centerZ;
    VAR num i;
  
    ! Compute angle step: 2*pi / segments (full circle)
    angleStep := 2 * pi / numSegments;
  
    ! Safe approach to home (taught in CommonData)
    MoveJ CommonData\pHome, v500, z50, tool0 \WObj:=wobj0;
  
    ! Move to starting point of circle
    MoveL CommonData\pStart, v200, fine, tool0 \WObj:=wobj0;

    pStartLocal := CommonData\pStart;

    ! Define circle relative to pStart
    centerX := pStartLocal.trans.x - radius;
    centerY := pStartLocal.trans.y;
    centerZ := pStartLocal.trans.z;
  
    ! Trace the circle
    FOR i FROM 1 TO numSegments DO
      currentAngle := currentAngle + angleStep;

      pNext := pStartLocal;
  
      pNext.trans.x := centerX + radius * Cos(currentAngle);
      pNext.trans.y := centerY + radius * Sin(currentAngle);
      pNext.trans.z := centerZ;
  
      ! Move linearly to next point (small segment approximates arc)
      MoveL pNext, v100, z1, tool0 \WObj:=wobj0;
  
    ENDFOR
  
    ! Return to home after completing the circle
    MoveJ CommonData\pHome, v500, z50, tool0 \WObj:=wobj0;
  
    TPWrite "Circle tracking complete - radius " + NumToStr(radius, 1) + " mm";
  ENDPROC

ENDMODULE