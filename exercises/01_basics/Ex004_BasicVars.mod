MODULE Ex004_BasicVars
    CONST num pi := 3.14159; ! Immutable constant
    PERS num radius := 5;    ! Persistent for reuse
    VAR num areaLarge;            ! Local mutable (initialized implicitly to 0)
    VAR bool isLarge;        ! Local flag

    PROC Ex004_Run()
        areaLarge := 0;
        isLarge := FALSE;

        areaLarge := pi * Pow(radius, 2);   ! Use Pow for exponentiation

        isLarge := (areaLarge > 100);      ! Comparison (>), assignment to bool

        TPWrite "Circle area: "\Num:=areaLarge;
        TPWrite "Is large? "\Bool:=isLarge;   ! \Bool formats TRUE/FALSE as string
    ENDPROC
ENDMODULE
