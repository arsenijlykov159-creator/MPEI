unit averageOfElementOfMatrixAndExistPositiveRow;

interface
uses commonTypes;
function averageMatrix(f: function(x: integer): real; const mtrx: matrix; const m, n: integer): real;
function positiveRow(const mtrx: matrix; const m, n: integer): boolean;

implementation
function averageMatrix(f: function(x: integer): real; const mtrx: matrix; const m, n: integer): real;
var
  sum: integer;
  count: integer;
begin
  sum := 0;
  count := 0;
  for i: integer := 1 to m do
    for j: integer := 1 to n do
      if f(mtrx[i, j]) >= 0 then 
      begin
        sum := sum + mtrx[i, j];
        count := count + 1;
      end;
  result := sum / count;
end;

function positiveRow(const mtrx: matrix; const m, n: integer): boolean;
var
  s: integer;
  i: integer;
begin
  i := 1;
  s := 0;
  result := false;
  while (i <= m) and not result do
  begin
    for j: integer := 1 to n do
      s := s + mtrx[i, j];
    if s > 0 then result := true;
    i := i + 1;
  end;
end;
end.