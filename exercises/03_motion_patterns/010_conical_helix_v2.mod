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

  !!!!! Continue refactoring below
  VAR num totalSegments;                 ! turns * segmentsPerTurn
  VAR num angleStep;                     ! Delta theta/segment (rad)

  VAR num currentAngle := 0;             ! Cumulative angle
  VAR num currentZ := startZ;            ! Progressive Z
  VAR num currentRadius := startradius;  ! Interpolated radius
  VAR num radiusStep;                    ! Delta radius per segment
  VAR robtarget pCurrent;                ! Current pose
  VAR robtarget pNext;                   ! Next pose

  ! Derive params: radiusStep = (end - start) / totalSegments for linear taper
  totalSegments := numTurns * segmentsPerTurn;
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
