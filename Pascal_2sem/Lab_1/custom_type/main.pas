program lab_1;

//uses orderedArray;
uses logicalArray;

var
  fl: TextFile;
  a, b, c: CharSet;
  a_count, b_count, c_count: Integer;

begin
  
  if ParamCount < 2 then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  
  if not FileExists(ParamStr(1)) then
  begin
    writeln('Невозможно открыть входной файл для чтения');
    exit;
  end;
  
  AssignFile(fl, ParamStr(1));
  Reset(fl);
  
  readln(fl, a_count);
  initSet(a);
  readCharSet(fl, a, a_count);
  
  readln(fl, b_count);
  initSet(b);
  readCharSet(fl, b, b_count);
  
  readln(fl, c_count);
  initSet(c);
  readCharSet(fl, c, c_count);
  
  CloseFile(fl);
  
  AssignFile(fl, ParamStr(2));
  Rewrite(fl);
  writeCharSet(fl, 'Объединение множеств a и b:    ', unionOfCharSet(a, b));
  writeCharSet(fl, 'Пересечение множеств a и b:    ', intersectionOfCharSet(a, b));
  writeCharSet(fl, 'Разность множеств a и b:    ', differenceOfCharSet(a, b));
  writeCharSet(fl, '(a and c) \ (b \ c):    ', differenceOfCharSet(unionOfCharSet(a, c), differenceOfCharSet(b, c)));
  CloseFile(fl);
  
end.