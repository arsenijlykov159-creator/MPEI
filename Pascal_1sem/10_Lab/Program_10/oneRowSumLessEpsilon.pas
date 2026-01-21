unit oneRowSumLessEpsilon;

interface
uses commonTypes;
function oneRowSumLessE(const m: matrix; const row, col, e: integer): boolean;

implementation
function oneRowSumLessE(const m: matrix; const row, col, e: integer): boolean;
var
  i: integer;
  sum: integer;
begin
  result := false;
  i := 1;
  while (i <= row) and not result do
  begin
    sum := 0;
    for j: integer := 1 to col do
      sum := sum + m[i, j];
    if sum < e then result := true;
    i := i + 1;
  end;
end;

begin 
end.