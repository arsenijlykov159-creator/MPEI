unit inputMatrixOutputArray;

interface
uses commonTypes;
procedure inputMatrix(var f: TextFile; var mtrx: matrix; var m, n: integer);
procedure outputArray(var f: TextFile; const text: string; const a: arr; const m: integer);

implementation
procedure inputMatrix(var f: TextFile; var mtrx: matrix; var m, n: integer);
begin
  read(f, m, n);
  for i: integer := 1 to m do
    begin
      for j: integer := 1 to n do
        read(f, mtrx[i, j]);
      readln(f);
    end;
end;

procedure outputArray(var f: TextFile; const text: string; const a: arr; const m: integer);
begin
  if m = 0 then writeln(f, text, 'пустой')
  else
    begin
    writeln(f, text);
    for i: integer := 1 to m do
      write(f, a[i], ' ');
    writeln(f);
  end;
end;
end.