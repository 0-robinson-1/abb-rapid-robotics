MODULE Ex008_TrackCircle

! Exercise 8 - Track a circle with the robot
! Approximates a circle using small linear segments
! Uses sin/cos for point calculation (RAPID math functions)

  LOCAL CONST num numSegments := 36;               ! 36 segments = 10° steps
  LOCAL PERS num radius := 50;                    ! Circle radius in mm

  PROC Ex008_Run()
    VAR num angleStep;                       ! Angle increment
    VAR num currentAngle := 0;               ! Starting angle
    VAR robtarget pStartLocal;               ! Copying pStart to pStartLocal to avoid errors...
    VAR robtarget pNext;                     ! Next point in circle
    VAR num centerX;
    VAR num centerY;
    VAR num centerZ;
    VAR num i;
  
    ! Compute angle step using degrees
    angleStep := 360 / numSegments;
  
    ! Safe approach to home (taught in CommonData)
    MoveJ pHome, v500, z50, tool0 \WObj:=wobj0;
  
    ! Move to starting point of circle
    pStartLocal := pStart;
    MoveL pStartLocal, v200, fine, tool0 \WObj:=wobj0;

    ! Define circle relative to pStart (so it starts exactly at pStart)
    centerX := pStartLocal.trans.x - radius;
    centerY := pStartLocal.trans.y;
    centerZ := pStartLocal.trans.z;
  
    ! Trace the circle
    FOR i FROM 1 TO numSegments DO
      currentAngle := currentAngle + angleStep;

      pNext := pStartLocal;         ! keep rot + robconf stable
  
      pNext.trans.x := centerX + radius * Cos(currentAngle);
      pNext.trans.y := centerY + radius * Sin(currentAngle);
      pNext.trans.z := centerZ;
  
      ! Move linearly to next point (small segment approximates arc)
      MoveL pNext, v100, fine, tool0 \WObj:=wobj0;
    ENDFOR
  
    ! Return to home after completing the circle
    MoveJ pHome, v500, z50, tool0 \WObj:=wobj0;
  
    TPWrite "Circle tracking complete - radius " + NumToStr(radius, 1) + " mm";
  ENDPROC

ENDMODULE