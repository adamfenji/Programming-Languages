PROGRAM exprAddSub;

VAR i,j,k,l : LONGINT;

BEGIN
	i := 1; k := 3; l := 4;
	j := i + l + k;
	WRITE('j = 1+3+4 =':15);
	WRITELN(j:4);
	l := j - 8 - k;
	WRITE('j - 8 - 3 =':15);
	WRITELN(l:4)
END.
