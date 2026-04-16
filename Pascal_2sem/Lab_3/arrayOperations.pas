unit arrayOperations;

interface

procedure getArray(var f: TextFile; var x: array of Integer; const x_count: Integer);
function hasMultipleOfNumber(const x: array of Integer; const x_count, number: Integer): boolean;
function multipleOfNumber(const x: array of Integer; const start, finish, number: Integer): Integer; 

implementation


procedure getArray(var f: TextFile; var x: array of Integer; const x_count: Integer);
begin
  SetLength(x, x_count);
  
  for i: Integer := 0 to x_count - 1 do
    read(f, x[i]);
end;

function hasMultipleOfNumber(const x: array of Integer; const x_count, number: Integer): boolean;
begin
  
  if (x_count = 1) then
    result := (x[0] mod number = 0)
  else if (x[x_count - 1] mod number = 0) then
    result := true
  else
    result := hasMultipleOfNumber(x, x_count - 1, number);
  
end;


function multipleOfNumber(const x: array of Integer; const start, finish, number: Integer): Integer; 
begin
  
  result := 0;
  
  if (start = finish) then
  begin
    if (x[start] mod number = 0) then
      result := x[start]
    else result := 1;
  end
  else result := multipleOfNumber(x, start, (start + finish) div 2, number) * multipleOfNumber(x, (start + finish) div 2 + 1, finish, number);

end;

end.