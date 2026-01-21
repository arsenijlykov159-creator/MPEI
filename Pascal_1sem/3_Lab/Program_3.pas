program SerieSum;
var
  x, e: real;
  a: real;
  i: integer;
  s, y: real;
  k: integer;
begin
  read(x, e);
  a := -9/24 * x*x*x*x;
  s := 3/2 * x*x + a;
  i := 3;
  while abs(a) > e do
  begin
    a := a * (-1) * x*x * (2*i*i+1)/(2*i)/(2*i-1)/(2*(i-1)*(i-1)+1);
    i := i+1;
    s := s+a;
  end;
  k := 0;
  while e <> 1 do
  begin
    k := k+1;
    e := e*10;
  end;
  y := 1 + x/2 * Sin(x) + (x*x/2-1)*Cos(x);
  writeln(s:0:k);
  writeln(y:0:k);
end.