MODULE Ex007_AreaCircumference
! Exercise 7 - Calculate area and circumference

  LOCAL CONST num pi := 3.14159;
  LOCAL PERS num radius := 5;
  LOCAL VAR num area;
  VAR num circumference;

  PROC Ex007_Run()

    ! Circumference calculation
    circumference := 2 * pi * radius;

    ! Area calculation
    area := pi * Pow(radius, 2);                  ! Pow function for exponentiation (RAPID kernel math)

    ! Output with formatting: \Num defaults to 6 decimals; use NumToStr for custom
    TPWrite "For radius " \Num:=radius;
    TPWrite "Circumference = " \Num:=circumference;
    TPWrite "Area = " \Num:=area;
    
  ENDPROC

ENDMODULE