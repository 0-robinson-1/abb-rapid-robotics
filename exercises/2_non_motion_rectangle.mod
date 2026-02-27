! First exercise
! Non motion calculation of a rectangle

MODULE CalculateRectangle
    ! Persistent variables (retain value across runs)
    PERS num length := 10;  ! Default value assignment
    PERS num width := 5;
    PERS num area := 0;     ! Initialized to 0

    PROC main()
        ! Compute area: Arithmetic operation
        area := length * width;

        ! Output to FlexPendant/console: Concat string with num
        TPWrite "The rectangle area is " \Num:=area;
    ENDPROC
ENDMODULE
