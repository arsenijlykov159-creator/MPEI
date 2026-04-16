program main_typedFile;

uses commonTypes_type;
uses typedFile;
uses checkCorrectRecord;
  

var
  type_file: file of TStudents;
  output_file: TextFile;
  
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
  
  sortArray(type_file, keyF1);
  sortArray(type_file, keyF2);
  typeToTxt(type_file, output_file);

  CloseFile(type_file);
  CloseFile(output_file);
  
end.