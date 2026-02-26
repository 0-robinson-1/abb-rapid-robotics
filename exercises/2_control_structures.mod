! Exercise 2 Control structures with conditional branching
MODULE SumCalculator
  ! Persistent variables for input and results
  PERS num inputNum := 5;   ! Default positive integer, change to test
  PERS num totalSum := 0;    ! Accumulater, initialized to 0
  PERS bool isEven := FALSE; ! Flag for even/odd result

  PROC main()
    ! Reset sum for each run (optional, since PERS retains but we recompute)
    totalSum := 0;

    ! Check if even or odd: Modulo operation
    IF inputNum MOD 2 = 0 THEN
      isEven := TRUE;
      TPWrite "Input " \Num:=inputNum \ " is even.";
    ELSE
      isEven := FALSE;
      TPWRITE "Input " \Num:=inputNum \ " is odd.";
    ENDIF

    ! Compute sum from 1  to inputNum: FOR loop with accumulation
    FOR i FROM 1 TO inputNUM DO
      totalSum := totalSum + i; !Arithmetic addition and assignmwent
    ENDFOR

    ! Output results in a conditional way
    TPWrite "Sum from 1 to " \Num:=inputNum \ " is " \Num:=totalSum;
  ENDPROC
ENDMODULE
