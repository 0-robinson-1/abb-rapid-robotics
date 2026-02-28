! Exercise 3 Control structures with conditional branching
MODULE SumCalculator
  ! Persistent variables for input and results
  PERS num inputNum := 10;   ! Default positive integer, change to test
  PERS num totalSum := 0;    ! Accumulator, initialized to 0
  PERS bool isEven := FALSE; ! Flag for even/odd result

  PROC main()
    ! Local string variables for output building
    VAR string evenOddMsg;
    VAR string sumMsg;

    ! Reset sum for each run (optional, since PERS retains but we recompute)
    totalSum := 0;

    ! Check if even or odd: Modulo operation
    IF inputNum MOD 2 = 0 THEN
      isEven := TRUE;
      evenOddMsg := "Input " + NumToStr(inputNum, 0) + " is even.";
      TPWrite evenOddMsg;
    ELSE
      isEven := FALSE;
      evenOddMsg := "Input " + NumToStr(inputNum, 0) + " is odd.";
      TPWrite evenOddMsg;
    ENDIF

    ! Compute sum from 1 to inputNum: FOR loop with accumulation
    FOR i FROM 1 TO inputNum DO
      totalSum := totalSum + i; ! Arithmetic addition and assignment
    ENDFOR

    ! Output results with multiple insertions via concatenation
    sumMsg := "Sum from 1 to " + NumToStr(inputNum, 0) + " is " + NumToStr(totalSum, 0);
    TPWrite sumMsg;
  ENDPROC
ENDMODULE