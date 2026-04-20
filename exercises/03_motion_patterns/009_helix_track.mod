MODULE Ex009_HelixTrack
! Exercise 9 - Track a Helix
! 3D spiral path: Circle in XY while ascending in Z
! Approximates using linear segments; parametric with Cos/Sin and linear Z

LOCAL CONST num segmentsPerTurn := 36;      ! 36 segments = 10° steps

LOCAL PERS num radius := 50;            ! Helix radius (mm)
LOCAL PERS num pitch := 20;
LOCAL PERS num numTurns :=5;

PROC Ex009_Run()
  VAR robtarget pCenterLocal;
  VAR robtarget pCurrent;
  VAR robtarget pNext;

  VAR num totalSegments;
  VAR num angleStepDeg;                 ! Angle increment
  VAR num angleDeg;
  VAR num i;

  VAR num centerX;
  VAR num centerY;
  VAR num startZ;
  VAR num currentZ;

  pCenterLocal := pStart;            ! Copying pStart to pStartLocal to avoid errors...

  centerX := pCenterLocal.trans.x;
  centerY := pCenterLocal.trans.y;
  startZ  := pCenterLocal.trans.z;

  totalSegments := numTurns * segmentsPerTurn;
  angleStepDeg := 360 / segmentsPerTurn;
  angleDeg := 0;

  Movej pHome, v500, z50, tool0;

  ! First point ON the circle (angle = 0°), using pStart as centre
  pCurrent := pCenterLocal;
  pCurrent.trans.x := centerX + radius * Cos(angleDeg);
  pCurrent.trans.y := centerY + radius * Sin(angleDeg);
  pCurrent.trans.z := startZ;

  MoveL pCurrent, v200, fine, tool0;

  FOR i FROM 1 TO totalSegments DO
    angleDeg := angleDeg + angleStepDeg;

    currentZ := startZ + (i / totalSegments) * (pitch * numTurns);

    pNext := pCenterLocal;
    pNext.trans.x := centerX + radius * Cos(angleDeg);
    PNext.trans.y := centerY + radius * Sin(angleDeg);
    pNext.trans.z := currentZ;

    MoveL pNext, v100, z1, tool0;

    pCurrent := pNext;
  ENDFOR

  MoveJ pHome, v500, z50, tool0;

  TPWrite "Helix tracking complete";
  TPWrite "Turns: " \Num:=numTurns;
  TPWrite "Pitch: " \Num:=pitch;
  ENDPROC

ENDMODULE