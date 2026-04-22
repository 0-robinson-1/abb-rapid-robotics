MODULE Ex010_conical_helix
! Exercise 10 - Track a Conical Helix

LOCAL CONST num segmentsPerTurn := 36;   ! 36 segments = 10° steps

LOCAL PERS num startRadius := 100;       ! Initial radius (mm)
LOCAL PERS num endRadius := 50;          ! Final radius (mm)
LOCAL PERS num pitch := 20;              ! Z rise per turn (mm/turn)
LOCAL PERS num numTurns := 15;           ! Numbers of revolutions

PROC Ex010_Run()
  VAR robtarget pCenterLocal;
  VAR robtarget pCurrent;
  VAR robtarget pNext;

  VAR num totalSegments;                 ! turns * segmentsPerTurn
  VAR num angleStepDeg;
  VAR num angleDeg;
  VAR num i;

  VAR num centerX;
  VAR num centerY;
  VAR num startZ;
  VAR num currentZ;

  pCenterLocal := pStart;                 ! Copying pStart to pStartLocal to avoid errors...

  centerX := pCenterLocal.trans.x;
  centerY := pCenterLocal.trans.y;
  startZ := pCenterLocal.trans.z;

  totalSegments := numTurns * segmentsPerTurn;
  IF totalSegments <= 0 THEN
    TPWrite "Conical helix: totalSegments <=0 (check numTurns/segmentsPerTurn)";
    RETURN;
  ENDIF
  
  angleStep := 2 * pi/segmentsPerTurn;
  radiusStep := (endRadius - startRadius)/totalSegments;    ! Positive for outward, negative for inward

  ! Approach home
  MoveJ pHome, v500, z50, tool0;

  ! Start point: θ=0, r=startRadius, Z=startZ
  pCurrent := [[centerX + startRadius * Cos(0), centerY + startRadius * Sin(0), startZ],[1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];
  MoveL pCurrent, v200, fine, tool0;

  ! Conical helix loop: Update r, θ, Z per segment
  FOR i FROM 1 TO totalSegments DO
    currentAngle := currentAngle + angleStep;    ! Cumulative

    ! Radius interpolation: Linear change = start + i * step
    currentRadius := startRadius + i * radiusStep;

    ! Z interpolation: As before, fractional * total height
    currentZ := startZ + (i/totalSegments) * (pitch * numTurns);

    ! Parametric pose: Variable r in Cos/Sin
    pNext := [[centerX + currentRadius * Cos(currentAngle),
          centerY + currentRadius * Sin(currentAngle),
          currentZ],
          [1,0,0,0}, [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];

    MoveL pNext, v100, z1, tool0;  ! Segment move

    pCurrent := pNext;
  ENDFOR

  ! Retract home
  MoveJ pHome, v500, z50, tool0;
  TPWrite "Conical helix complete: Taper from " \Num:=startRadius \ "to "\Num:=endRadius \ " mm";
ENDPROC

ENDMODULE