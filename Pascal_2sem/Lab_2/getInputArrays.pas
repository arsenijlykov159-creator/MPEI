unit getInputArrays;

interface

uses commonTypes;

procedure getMatrix(var f: TextFile; var x: Matrix; x_rows, x_columns: Integer);
procedure getArray(var f: TextFile; var x: Arr; const x_count: Integer);
procedure inputMatrix(var f: TextFile; const txt: string; var x: Matrix; const x_rows, x_columns: Integer);



implementation


procedure getMatrix(var f: TextFile; var x: Matrix; x_rows, x_columns: Integer);
var
  element: Integer;
begin
  SetLength(x, x_rows);
  
  for i: Integer := 0 to x_rows - 1 do
  begin
    SetLength(x[i], x_columns);
    
    for j: Integer := 0 to x_columns - 1 do
    begin
      read(f, element);
      x[i, j] := element;
    end;
  end;
end;


procedure getArray(var f: TextFile; var x: Arr; const x_count: Integer);
var
  element: Integer;
begin
  SetLength(x, x_count);
  for i: Integer := 0 to x_count - 1 do
  begin
    read(f, element);
    x[i] := element;
  end;
end;


procedure inputMatrix(var f: TextFile; const txt: string; var x: Matrix; const x_rows, x_columns: Integer);
begin
  writeln(f, txt);
  for i: Integer := 0 to x_rows - 1 do
  begin
    for j: Integer := 0 to x_columns - 1 do
      write(f, x[i, j], ' ');
    writeln(f);
  end;
end;


end.