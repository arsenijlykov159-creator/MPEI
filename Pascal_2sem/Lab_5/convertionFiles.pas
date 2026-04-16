program convertionFiles;

uses checkCorrectRecord;
uses commonTypes_type;

var
  input_file: TextFile;
  type_file: file of TStudents;
  current_record: TStudents;
  
begin
  
  if ParamCount < 2 then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  
  if not FileExists(ParamStr(1)) then
  begin
    writeln('Невозможно открыть файл для чтения');
    exit;
  end;
  
  AssignFile(input_file, ParamStr(1));
  Reset(input_file);
  AssignFile(type_file, ParamStr(2));
  Rewrite(type_file);
  
  while (not eof(input_file)) do
  begin
    readRecord(input_file, current_record);
     if isGroupCorrect(current_record.group) and isNameCorrect(current_record.fio) and isYearCorrect(current_record.year)
        and isMarkCorrect(current_record.marks.math) and isMarkCorrect(current_record.marks.physics) and isMarkCorrect(current_record.marks.info)
        then write(type_file, current_record);
  end;
  
  CloseFile(input_file);
  CloseFile(type_file);
  
end.