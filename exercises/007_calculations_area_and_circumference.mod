! Exercise 7 - Calculate area and circumference

PROC main()
  ! Circumference calculation
  circumference := 2 * pi * radius;

  ! Area calculation
  area := pi * Pow(radius, 2);                  ! Pow function for exponentiation (RAPID kernel math)

  ! Output with formatting: \Num defaults to 6 decimals; use NumToStr for custom
  TPWrite "For radius " \Num:=radius\":";
  TPWrite "Circumference = "\Num:=circumference\"mm";
  TPWrite "Area = "\Num:=area\"mm^2";
ENDPROC
