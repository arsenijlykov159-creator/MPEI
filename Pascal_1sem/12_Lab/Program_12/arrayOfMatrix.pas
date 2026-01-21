unit arrayOfMatrix;

interface
uses commonTypes;
procedure arrayMatrix(const mtrx: matrix; const m, n: integer; const e: real; var a: arr; var i: integer);

implementation
procedure arrayMatrix(const mtrx: matrix; const m, n: integer; const e: real; var a: arr; var i: integer);
begin
  i := 0;
  for j: integer := 1 to m do
    for k: integer := 1 to n do
      if mtrx[j, k] > e then
      begin
        i := i + 1;
        a[i] := mtrx[j, k];
      end;
end;
end.