MODULE BasicVars
    CONST num pi := 3.14159; ! Immutable constant
    PERS num radius := 5;    ! Persistent for reuse
    VAR num area;            ! Local mutable (initialized implicitly to 0)
    VAR bool isLarge;        ! Local flag

    PROC main()
        area := pi * Pow(radius, 2);   ! Use Pow for exponentiation

        isLarge := (area > 100);      ! Comparison (>), assignment to bool

        TPWrite "Circle area: "\Num:=area;
        TPWrite "Is large? "\Bool:=isLarge;   ! \Bool formats TRUE/FALSE as string
    ENDPROC
ENDMODULE
