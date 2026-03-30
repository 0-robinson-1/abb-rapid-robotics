MODULE Ex002_CalculateRectangle
    ! Non motion calculation of a rectangle
    ! Configuration parameters
    PERS num length := 10;  ! Default value assignment
    PERS num width := 5;
    VAR num area := 0;     ! Initialized to 0

    PROC Ex002_Run()
        ! Compute area: Arithmetic operation
        area := length * width;

        ! Output to Console: Concat string with num
        TPWrite "The rectangle area is " \Num:=area;
    ENDPROC
ENDMODULE