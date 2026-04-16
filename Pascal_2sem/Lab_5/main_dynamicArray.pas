program main_dynamicArray;

uses commonTypes_type;
uses dynamicArray;
uses checkCorrectRecord;
  

var
  type_file: file of TStudents;
  output_file: TextFile;
  records: array of TStudents;
  students_count: Integer := 0;
  honor_students_count: Integer := 0;
  
begin
  
  if (ParamCount < 2) then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  
  if (not FileExists(ParamStr(1))) then
  begin
    writeln('Невозможно открыть входной файл для чтения');
    exit;
  end;
  
  AssignFile(type_file, ParamStr(1));
  Reset(type_file);
  AssignFile(output_file, ParamStr(2));
  Rewrite(output_file);
  
  SetLength(records, 1000);
  while (not eof(type_file)) do
  begin
    read(type_file, records[students_count]);
    students_count += 1;
  end;
  SetLength(records, students_count);

  sortArray(records, 0, students_count - 1, keyF1);
  sortArray(records, 0, students_count - 1, keyF2);
  
  outputArray(output_file, records);

  CloseFile(type_file);
  CloseFile(output_file);
  
end.