unit typedFile;


interface

uses commonTypes_type;

procedure sortArray(var x: file of TStudents; f: function(x, y: TStudents): boolean);
procedure typeToTxt(var type_fl: file of TStudents; var text_fl: TextFile);


implementation


procedure sortArray(var x: file of TStudents; f: function(x, y: TStudents): boolean);
var
  start_i: Integer := 0;
  end_i: Integer := FileSize(x) - 1;
  x_max, x_min: TStudents;
  x_max_index, x_min_index: Integer;
  element: TStudents;
  i: Integer;
begin
  
  while (start_i < end_i) do
  begin
    
    Seek(x, start_i);
    read(x, x_max);
    x_max_index := start_i;
    x_min := x_max;
    x_min_index := start_i;
    
    i := start_i + 1;
    while (i <= end_i) do
    begin
      Seek(x, i);
      read(x, element);
      if not f(element, x_max) then
      begin
        x_max := element;
        x_max_index := i;
      end
      else if f(element, x_min) then
      begin
        x_min := element;
        x_min_index := i;
      end;
      i += 1;
    end;
    
    if (x_min_index <> start_i) then
    begin
      Seek(x, start_i);
      read(x, element);
      Seek(x, start_i);
      write(x, x_min);
      Seek(x, x_min_index);
      write(x, element);
    end;
    if (x_max_index = start_i) then x_max_index := x_min_index;
    if (x_max_index <> end_i) then
    begin
      Seek(x, end_i);
      read(x, element);
      Seek(x, end_i);
      write(x, x_max);
      Seek(x, x_max_index);
      write(x, element);
    end;
    
    start_i += 1;
    end_i -= 1;
  end;
end;


procedure typeToTxt(var type_fl: file of TStudents; var text_fl: TextFile);
var
  element: TStudents;
  honor_students_count: Integer := 0;
begin
  write(text_fl, 'Students: {');
  Seek(type_fl, 0);
  while (not (eof(type_fl))) do
  begin
    read(type_fl, element);
    if (element.marks.math in GOOD_MARKS) and (element.marks.physics in GOOD_MARKS) and (element.marks.info in GOOD_MARKS) then
    begin
      writeln(text_fl);
      write(text_fl, element);
      honor_students_count += 1;
    end;
  end;
  
  if (honor_students_count > 0) then writeln(text_fl);
  writeln(text_fl, '}');
  
  if (honor_students_count = 0) then writeln(text_fl, 'В списке нет подходящих студентов')
  else writeln(text_fl, 'Количество подходящих студентов: ', honor_students_count);
  
  writeln(text_fl, 'Их процент от общего числа студентов: ', honor_students_count / FileSize(type_fl) * 100, '%');
end;


end.