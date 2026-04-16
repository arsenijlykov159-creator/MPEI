unit logicalArray;

interface


const
  INITIAL_SIZE = 255;

type
  CharSet = array[0..INITIAL_SIZE] of boolean;
  
procedure initSet(var x: CharSet);
procedure readCharSet(var f: TextFile; var x: CharSet; const count: Integer);
procedure writeCharSet(var f: TextFile; const text: string; const x: CharSet);
function unionOfCharSet(const x, y: CharSet): CharSet;
function intersectionOfCharSet(const x, y: CharSet): CharSet;
function differenceOfCharSet(const x, y: CharSet): CharSet;
function isSubset(const y, x: CharSet): boolean;
function isSuperset(const y, x: CharSet): boolean;
function isInSet(const x: CharSet; const el: char): boolean;
function isEqual(const x, y: CharSet): boolean;
procedure deleteCharSet(var x: CharSet);


implementation



procedure initSet(var x: CharSet);
begin
  for i: Integer := 0 to INITIAL_SIZE do
    x[i] := false;
end;


procedure add(var c: CharSet; const element: char);
begin
  c[ord(element)] := true;
end;


procedure readCharSet(var f: TextFile; var x: CharSet; const count: Integer);
var
  s: string;
begin
  read(f, s);
  
  if (Length(s) <> count) then 
  begin
    writeln('Error: Length(s) <> count');
    exit;
  end;
  
  for i: Integer := 1 to count do
  begin
    add(x, s[i]);
  end;
end;
  
  
procedure writeCharSet(var f: TextFile; const text: string; const x: CharSet);
begin
  write(f, text);
  for i: Integer := 0 to INITIAL_SIZE do
    if x[i] then write(f, chr(i), ' ');
  writeln(f);
end;


function unionOfCharSet(const x, y: CharSet): CharSet;
begin
  for i: Integer := 0 to INITIAL_SIZE do
    result[i] := (x[i] or y[i]);
end;

function intersectionOfCharSet(const x, y: CharSet): CharSet;
begin
  for i: Integer := 0 to INITIAL_SIZE do
    result[i] := (x[i] and y[i]);
end;

function differenceOfCharSet(const x, y: CharSet): CharSet;
begin
  for i: Integer := 0 to INITIAL_SIZE do
    result[i] := (x[i] and not y[i]);
end;

function sumCharSet(const x: CharSet): Integer;
begin
  result := 0;
  for i: Integer := 0 to INITIAL_SIZE do
    if (x[i]) then result := result + 1;
end;

function isSubset(const y, x: CharSet): boolean;
begin
  if sumCharSet(x) < sumCharSet(y) then 
  begin
    result := false;
    exit;
  end;
  for i: Integer := 0 to INITIAL_SIZE do
    if (not x[i] and y[i]) then 
    begin
      result := false;
      exit;
    end;
  result := true;
end;

function isSuperset(const y, x: CharSet): boolean; //является ли y надмножеством x
begin
  if sumCharSet(y) < sumCharSet(x) then
  begin
    result := false;
    exit;
  end;
  for i: Integer := 0 to INITIAL_SIZE do
    if (x[i] and not y[i]) then
    begin
      result := false;
      exit;
    end;
  result := true;
end;


function isInSet(const x: CharSet; const el: char): boolean;
begin
  result := x[ord(el)];
end;

function isEqual(const x, y: CharSet): boolean;
begin
  result := true;
  if (sumCharSet(x) <> sumCharSet(y)) then
  begin
    result := false;
    exit;
  end;
  for i: Integer := 0 to INITIAL_SIZE do
    if (x[i] <> y[i]) then
    begin
      result := false;
      exit;
    end;
end;

procedure deleteCharSet(var x: CharSet);
begin
  for i: Integer := 0 to INITIAL_SIZE do
    x[i] := false;
end;


end.