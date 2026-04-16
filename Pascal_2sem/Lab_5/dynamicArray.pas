unit dynamicArray;

interface

uses commonTypes_type;

procedure sortArray(var x: array of TStudents; const start, finish: Integer; f: function(x, y: TStudents): boolean);
procedure outputArray(var fl: TextFile; const x: array of TStudents);


implementation

procedure swap(var a, b: TStudents);
var
  c: TStudents;
begin
  c := a;
  a := b;
  b := c;
end;

procedure sortArray(var x: array of TStudents; const start, finish: Integer; f: function(x, y: TStudents): boolean);
var
  mid: Integer := (start + finish) div 2;
  mediana: TStudents;
  mediana_index: Integer;
  j: Integer := start;
begin
  
  if (finish = start) then exit;
  
  if (finish = start + 1) then
  begin
    if f(x[finish], x[start]) then
      swap(x[finish], x[start]);
    exit;
  end;
  
  if (f(x[start], x[mid]) and f(x[mid], x[finish])) or (f(x[finish], x[mid]) and f(x[mid], x[start])) then
  begin
    mediana := x[mid];
    mediana_index := mid;
  end
  else if (f(x[mid], x[start]) and f(x[start], x[finish])) or (f(x[finish], x[start]) and f(x[start], x[mid])) then
  begin
    mediana := x[start];
    mediana_index := start;
  end
  else if (f(x[start], x[finish]) and f(x[finish], x[mid])) or (f(x[mid], x[finish]) and f(x[finish], x[start])) then
  begin
    mediana := x[finish];
    mediana_index := finish;
  end;
  
  swap(x[finish], x[mediana_index]);
  
  for i: Integer := start to finish - 1 do
  begin
    if f(x[i], mediana) then
    begin
      swap(x[i], x[j]);
      j += 1;
    end;
  end;
  
  swap(x[j], x[finish]);
  
  if (start < j) then sortArray(x, start, j - 1, f);
  if (j + 1 < finish) then sortArray(x, j + 1, finish, f);
end;


procedure outputArray( var fl: TextFile; const x: array of TStudents);
var
  honor_students_count: Integer := 0;
begin
  
  write(fl, 'Students: {');
  for k: Integer := 0 to High(x) do
    if (x[k].marks.math in GOOD_MARKS) and (x[k].marks.physics in GOOD_MARKS) and (x[k].marks.info in GOOD_MARKS) then
    begin
      writeln(fl);
      write(fl, x[k]);
      honor_students_count += 1;
    end;
    
  if (honor_students_count > 0) then writeln(fl);
  writeln(fl, '}');
  
  if (honor_students_count = 0) then writeln(fl, 'В списке нет подходящих студентов')
  else writeln(fl, 'Количество подходящих студентов: ', honor_students_count);
  
  writeln(fl, 'Их процент от общего числа студентов: ', honor_students_count / (High(x) + 1) * 100, '%');
end;

end.