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
  VAR num totalHeight;
  VAR num radiusStep;
  VAR num currentRadius;

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

  angleStepDeg := 360 / segmentsPerTurn;
  angleDeg := 0;

  totalHeight := pitch * numTurns;         ! Total Z climb over the whole helix
  radiusStep := (endRadius - startRadius) / totalSegments;

  ! Approach home
  MoveJ pHome, v500, z50, tool0;

  ! Start point: angle=0°, radius=startRadius, Z=startZ
  pCurrent := pCenterLocal;
  pCurrent.trans.x := centerX + startRadius * Cos(angleDeg);
  pCurrent.trans.y := centerY + startRadius * Sin(angleDeg);
  pCurrent.trans.z := startZ;

  MoveL pCurrent, v200, fine, tool0;

  ! Conical helix: radius tapers linearly while Z rises
  FOR i FROM 1 TO totalSegments DO
    angleDeg := angleDeg + angleStepDeg;

    currentRadius := startRadius + i * radiusStep;
    currentZ := startZ + (i/totalSegments) * totalHeight;

    pNext := pCenterLocal;
    pNext.trans.x := centerX + currentRadius * Cos(angleDeg);
    pNext.trans.y := centerY + currentRadius * Sin(angleDeg);
    pNext.trans.z := currentZ;

    MoveL pNext, v100, z1, tool0;           ! Segment move

    pCurrent := pNext;
  ENDFOR

  ! Retract home
  MoveJ pHome, v500, z50, tool0;

  TPWrite "Conical helix complete";
  TPWrite "Turns: " \Num:=numTurns;
  TPWrite "Pitch (mm/turn): " \Num:=pitch;
  TPWrite "Radius start (mm): " \Num:=startRadius;
  TPWrite "Radius end (mm): " \Num:=endRadius;

ENDPROC
ENDMODULE