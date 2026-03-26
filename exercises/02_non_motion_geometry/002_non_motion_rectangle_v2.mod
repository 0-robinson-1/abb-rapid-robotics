! Non motion calculation of a rectangle

MODULE Ex002CalculateRectangle
    ! Configuration parameters
    PERS num length := 10;  ! Default value assignment
    PERS num width := 5;
    VAR num area := 0;     ! Initialized to 0

    PROC main()
        ! Compute area: Arithmetic operation
        area := length * width;

        ! Output to Console: Concat string with num
        TPWrite "The rectangle area is " \Num:=area;
    ENDPROC
ENDMODULE
