unit operations;

interface

uses commonTypes;
function positiveCount(const x: Arr; const x_count: Integer): Integer;
function countPositiveInLastUnsortedRow(const x: Matrix; const x_rows, x_columns: Integer): UnsortedRow;
procedure remakeMatrix(var x: Matrix; const x_rows, x_columns: Integer);


implementation

function positiveCount(const x: Arr; const x_count: Integer): Integer;
begin
  result := 0;
  for i: Integer := 0 to x_count - 1 do
    if (x[i] > 0) then result := result + 1;
end;

function isUnsorted(const x: Arr; const x_count: Integer): boolean;
begin
  result := false;
  
  for i: Integer := 0 to x_count - 2 do
    if (x[i] <= x[i + 1]) then
      exit(true);
end;


function countPositiveInLastUnsortedRow(const x: Matrix; const x_rows, x_columns: Integer): UnsortedRow;
begin
  
  for i: Integer := x_rows - 1 downto 0 do
    if (isUnsorted(x[i], x_columns)) then
    begin
      result.row := i;
      result.positive_count := positiveCount(x[i], x_columns);
      exit;
    end;
    
  result.row := -1;
  result.positive_count := -1;
end;


procedure remakeMatrix(var x: Matrix; const x_rows, x_columns: Integer);
begin

  for i: Integer := 0 to x_rows - 1 do
  begin
    if (x[i, 0] < 0) then
      x[i, 0] := x[i, 0] + x[i, x_columns - 1];
    for j: Integer := 1 to x_columns - 1 do
      if (x[i, j] < 0) then 
        x[i, j] := x[i, j] + x[i, j - 1];
  end;

end;


end.