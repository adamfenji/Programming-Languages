PROGRAM MatrixMul;
VAR  a : ARRAY[1..20, 1..8] OF LONGINT;
     b : ARRAY[2..9] OF LONGINT;
     c : ARRAY[1..20] OF LONGINT;    
     i, j, k, s : LONGINT; 

BEGIN 
  i := 1;
  WHILE (i <= 20) DO
  BEGIN
    j := 1;
    WHILE (j <= 8) DO
    BEGIN
      a[i, j] := i*8+j;
      WRITE(a[i, j]);
      WRITE('  ');
      j := j+1
    END;
    WRITELN('|');
    i := i+1
  END;

  WRITELN('*');
 
  j := 2;
  WHILE (j <= 9) DO
    BEGIN
      b[j] := j*j;
      WRITE(b[j]);
      WRITE('  ');
      j := j+1
  END;

  WRITELN('|');
  WRITELN('='); 

  i := 1;
  WHILE (i <= 20) DO
  BEGIN
    j := 1;
    s := 0;
    WHILE (j <= 8) DO
    BEGIN
      s := s + a[i, j] * b[j+1];
      j := j+1
    END;
    c[i] := s;
    i := i+1
  END;

  k := 1;
  WHILE (k <= 20) DO
    BEGIN
      WRITE(c[k]);
      WRITE('  ');
      k := k+1
  END;
  WRITELN('|')
END.