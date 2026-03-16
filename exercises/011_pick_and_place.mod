! Example 11 - Pick and Place with safety checks

MODULE pick_and_place_example
  ! Declarations
  PERS tooldata myTool := [TRUE, [[0,0,100], [1,0,0,0]], [1,0,0,0], [0,0,0]];
  PERS wobjdata wobj
