unit orderedArray;

interface

type
  CharSet = record
    data: array of char;
    count: Integer;
  end;


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

const
  INITIAL_SIZE = 256;

procedure initSet(var x: CharSet);
begin
  SetLength(x.data, INITIAL_SIZE);
  x.count := 0;
end;

procedure add(var x: CharSet; const element: char);
var
  pos: Integer;
begin
  pos := 0;
  while (pos < x.count) and (element > x.data[pos]) do
    pos := pos + 1;
  
  if (pos < x.count) and (element = x.data[pos]) then
    exit;
  
  for i: Integer := x.count downto pos + 1 do
    x.data[i] := x.data[i - 1];
  
  x.data[pos] := element;
  x.count := x.count + 1;
end;


procedure readCharSet(var f: TextFile; var x: CharSet; count: Integer);
var
  e: char;
begin
  for i: Integer := 0 to count - 1 do
  begin
    read(f, e);
    add(x, e);
  end;
  SetLength(x.data, x.count);
end;


procedure writeCharSet(var f: TextFile; const text: string; const x: CharSet);
begin
  write(f, text, ' ');
  for i: Integer := 0 to x.count - 1 do
    write(f, x.data[i], ' ');
  writeln(f);
end;


procedure delete(var c: CharSet; const element: char);
var
  pos: Integer;
begin
  pos := -1;
  for i: Integer := 0 to c.count - 1 do
    if c.data[i] = element then
      pos := i;
  if (pos >= 0) then
  begin
    for j: Integer := pos to c.count - 1 do
      c.data[j] := c.data[j + 1];
    c.count := c.count - 1;
  end
  else writeln('Элемент не найден...');
end;


function unionOfCharSet(const x, y: CharSet): CharSet;
var
  ix, iy, ir: Integer;
begin
  SetLength(result.data, x.count + y.count);
  ix := 0;
  iy := 0;
  ir := 0;
  
  while (ix < x.count) and (iy < y.count) do
  begin
    
    if (x.data[ix] = y.data[iy]) then
    begin
      result.data[ir] := x.data[ix];
      ix := ix + 1;
      iy := iy + 1;
    end
    else 
    begin
      if (x.data[ix] < y.data[iy]) then
      begin
        result.data[ir] := x.data[ix];
        ix := ix + 1;
      end
      else
      begin
        result.data[ir] := y.data[iy];
        iy := iy + 1;
      end;
    end;
    ir := ir + 1;
  end;
  
  while (iy < y.count) do
  begin
    result.data[ir] := y.data[iy];
    ir := ir + 1;
    iy := iy + 1;
  end;
  
  while (ix < x.count) do
  begin
    result.data[ir] := x.data[ix];
    ir := ir + 1;
    ix := ix + 1;
  end;
    
  SetLength(result.data, ir);
  result.count := ir;
end;


function intersectionOfCharSet(const x, y: CharSet): CharSet;
var
  ix, iy, ir: Integer;
begin
  SetLength(result.data, x.count + y.count);
  ix := 0;
  iy := 0;
  ir := 0;
  
  while (ix < x.count) and (iy < y.count) do
  begin
    
    if (x.data[ix] = y.data[iy]) then
    begin
      result.data[ir] := x.data[ix];
      ir := ir + 1;
      ix := ix + 1;
      iy := iy + 1;
    end
    else 
    begin
      if (x.data[ix] < y.data[iy]) then
        ix := ix + 1;
      else
        iy := iy + 1;
    end;
    
  end;
    
  SetLength(result.data, ir);
  result.count := ir;
end;


function copyCharSet(const x: CharSet): CharSet;
begin
  initSet(result);
  
  for i: Integer := 0 to x.count - 1 do
    add(result, x.data[i]);
  SetLength(result.data, result.count);
end;


function differenceOfCharSet(const x, y: CharSet): CharSet;
var
  ix, iy, ir: Integer;
begin

  initSet(result);
  
  ix := 0;
  iy := 0;
  ir := 0;
  while (ix < x.count) and (iy < y.count) do
  begin
    
    if (x.data[ix] = y.data[iy]) then
    begin
      ix := ix + 1;
      iy := iy + 1;
    end
    else 
    begin
      if (x.data[ix] < y.data[iy]) then
      begin
        result.data[ir] := x.data[ix];
        ir := ir + 1;
        ix := ix + 1;
      end
      else
        iy := iy + 1;
    end;
  end;
  
  while (ix < x.count) do
  begin
    result.data[ir] := x.data[ix];
    ir := ir + 1;
    ix := ix + 1;
  end;
    
  SetLength(result.data, ir);
  result.count := ir;
end;


function isSubset(const y, x: CharSet): boolean; //является ли y подмножеством x
var
  ix, iy: Integer;
begin
  
  ix := 0;
  iy := 0;
  
  while (ix < x.count) and (iy < y.count) do
  begin
    
    if (x.data[ix] = y.data[iy]) then
    begin
      ix := ix + 1;
      iy := iy + 1;
    end
    else
    begin
      if (x.data[ix] < y.data[iy]) then
        ix := ix + 1
      else
      begin
        result := false;
        exit;
      end;
    end;
  end;
  
  result := (iy = y.count);
end;


function isSuperset(const y, x: CharSet): boolean; //является ли y надмножеством x
var
  ix, iy: Integer;
begin
  
  ix := 0;
  iy := 0;
  
  while (ix < x.count) and (iy < y.count) do
  begin
    
    if (x.data[ix] = y.data[iy]) then
    begin
      ix := ix + 1;
      iy := iy + 1;
    end
    else
    begin
      if (y.data[iy] < x.data[ix]) then
        iy := iy + 1
      else if (y.data[iy] > x.data[ix]) then
        begin
          result := false;
          exit;
        end;
    end;
  end;
  
  result := (ix = x.count);
end;


function isInSet(const x: CharSet; const el: char): boolean;
begin
  result := false;
  for i: Integer := 0 to x.count - 1 do
    if x.data[i] = el then
    begin
      result := true;
      exit;
    end;
end;


function isEqual(const x, y: CharSet): boolean;
begin
  result := true;
  if (x.count <> y.count) then
  begin
    result := false;
    exit;
  end;
  for i: Integer := 0 to x.count - 1 do
    if (x.data[i] <> y.data[i]) then
    begin
      result := false;
      exit;
    end;
end;


procedure deleteCharSet(var x: CharSet);
begin
  SetLength(x.data, 0);
  x.count := 0;
end;


end.