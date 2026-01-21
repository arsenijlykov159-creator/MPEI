unit inputOutputMatrixFromFile;

interface
uses commonTypes;
procedure inputMatrix(var f: TextFile; var m: matrix; var row, col: integer);
procedure outputMatrix(var fl: TextFile; const nomer: string;  const m: matrix; const row, col: integer);

implementation
procedure inputMatrix(var f: TextFile; var m: matrix; var row, col: integer);
begin
  read(f, row, col);
  for i: integer := 1 to row do
    for j: integer := 1 to col do
      read(f, m[i, j]);
  readln(f);
end;

procedure outputMatrix(var fl: TextFile; const nomer: string; const m: matrix; const row, col: integer);
begin
  writeln(fl, nomer);
  for i: integer := 1 to row do
    begin
      for j: integer := 1 to col do
        write(fl, m[i, j], ' ');
      writeln(fl);
    end;
end;

begin
end.