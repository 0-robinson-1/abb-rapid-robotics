! Exercise 6 - Cladding Hatch Pattern
! 5 parallel lines with laser simulation (SetDO)

MODULE CladdingHatch

  !------------------------------------------------------------------------------
  ! Reuse the same points from Exercise 5
    PERS robtarget pHome  := [[400, 0, 500], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];
    PERS robtarget pStart := [[300, -150, 100], [1,0,0,0], [0,0,0,0], [9E9,9E9,9E9,9E9,9E9,9E9]];

  ! Speed for deposition (Change later to real values)
  COST speeddata vCladding := [200, 500, 5000, 1000]; ! 200 mm/s TCP speed

  PROC main()
    ! 1. Safe approach
    MoveJ pHome, v500, z50, tool0;
