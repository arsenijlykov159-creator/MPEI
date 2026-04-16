unit arraySorting;

interface

uses commonTypes;

procedure getArray(var f: TextFile; var x: Arr; const x_count: Integer);
procedure inputArray(var f: TextFile; var x: Arr; const x_count: Integer);

function isSorted(const x: Arr; const x_count: Integer): boolean;
procedure shakeSorting(var x: Arr; const x_count: Integer);
procedure impSelectionSorting(var x: Arr; const x_count: Integer);
procedure sortingShell(var x: Arr; const x_count: Integer);
procedure fastSorting(var x: Arr; const start, finish: Integer);



implementation


procedure getArray(var f: TextFile; var x: Arr; const x_count: Integer);
begin
  SetLength(x, x_count);
  for i: Integer := 0 to x_count - 1 do
    readln(f, x[i]);
end;


procedure inputArray(var f: TextFile; var x: Arr; const x_count: Integer);
begin
  for i: Integer := 0 to x_count - 1 do
    write(f, x[i], ' ');
end;


function isSorted(const x: Arr; const x_count: Integer): boolean;
begin
  for i: Integer := 0 to x_count - 2 do
    if (x[i] > x[i + 1]) then 
    begin
      result := false;
      exit;
    end;
  
  result := true;
end;

procedure swap(var a, b: EType);
var
  c: EType;
begin
  c := a;
  a := b;
  b := c;
end;


procedure shakeSorting(var x: Arr; const x_count: Integer);
var
  start_i, end_i: Integer;
begin
  
  for k: Integer := 0 to x_count - 2 do
  begin
    
    if (k mod 2 = 0) then
    begin
      start_i := k div 2;
      end_i := x_count - 1 - k div 2;
      
      for i: Integer := start_i to end_i - 1 do
      begin
        if (x[i] > x[i + 1]) then
          swap(x[i], x[i + 1]);
      end;
    end
    
    else
    begin
      start_i := x_count - (k + 1) div 2;
      end_i := k div 2;
      
      for j: Integer := start_i downto end_i + 1 do
      begin
        if (x[j] < x[j - 1]) then
          swap(x[j], x[j - 1]);
      end;
    end;
  end;
end;


procedure impSelectionSorting(var x: Arr; const x_count: Integer);
var
  start_i: Integer := 0;
  end_i: Integer := x_count - 1;
  x_max, x_min: EType;
  x_max_index, x_min_index: Integer;
begin
  
  while (start_i < end_i) do
  begin
    x_max := x[start_i];
    x_max_index := start_i;
    x_min := x[start_i];
    x_min_index := start_i;
    
    for i: Integer := start_i to end_i do
    begin
      if (x[i] > x_max) then
      begin
        x_max := x[i];
        x_max_index := i;
      end
      else if (x[i] < x_min) then
      begin
        x_min := x[i];
        x_min_index := i;
      end;
    end;

    swap(x[x_min_index], x[start_i]);
    if (x_max_index = start_i) then x_max_index := x_min_index;
    swap(x[x_max_index], x[end_i]);
    
    start_i += 1;
    end_i -= 1;
  end;
end;


procedure sortingShell(var x: Arr; const x_count: Integer);
var
  k: Integer := 1;
  current_i: Integer;
begin
  
  while (k < x_count div 2) do
    k *= 2;
  k -= 1;
  
  while (k > 0) do
  begin
    for i: Integer := k to x_count - 1 do
    begin
      current_i := i;
      
      while ((current_i >= k) and (x[current_i] < x[current_i - k])) do
      begin
        swap(x[current_i], x[current_i - k]);
        current_i := current_i - k;
      end;
    end;
    k := k div 2;
  end;
end;


procedure fastSorting(var x: Arr; const start, finish: Integer);
var
  mediana: EType;
  mediana_index: Integer;
  mid: Integer := (start + finish) div 2;
  j: Integer := start;
begin
  
  if (x[start] <= x[mid]) and (x[mid] <= x[finish]) or (x[finish] <= x[mid]) and (x[mid] <= x[start]) then
  begin
    mediana := x[mid];
    mediana_index := mid;
  end
  else if (x[mid] <= x[start]) and (x[start] <= x[finish]) or (x[finish] <= x[start]) and (x[start] <= x[start]) then
  begin
    mediana := x[start];
    mediana_index := start;
  end
  else if (x[start] <= x[finish]) and (x[finish] <= x[mid]) or (x[mid] <= x[finish]) and (x[finish] <= x[start]) then
  begin
    mediana := x[finish];
    mediana_index := finish;
  end;
  
//  writeln(mediana, ' ', mediana_index);
  
  swap(x[finish], x[mediana_index]);
  
  for i: Integer := start to finish - 1 do
  begin
    if (x[i] < mediana) then
    begin
      swap(x[i], x[j]);
      j += 1;
    end;
  end;

  swap(x[j], x[finish]);
  
  if (start < j) then fastSorting(x, start, j - 1);
  if (j + 1 < finish) then fastSorting(x, j + 1, finish);
end;
  

end.