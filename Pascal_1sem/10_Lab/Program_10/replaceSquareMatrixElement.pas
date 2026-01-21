unit replaceSquareMatrixElement;

interface
uses commonTypes;
procedure replaceBySquare(var m: matrix; const row, col: integer);

implementation
procedure replaceBySquare(var m: matrix; const row, col: integer);
begin
  for i: integer := 1 to row do
    for j: integer := 1 to col do
      m[i, j] := m[i, j] * m[i, j];
end;

begin
  
end.