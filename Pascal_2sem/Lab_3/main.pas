program lab_3;

uses arrayOperations;
  
var
  a: array of Integer;
  n: Integer;
  k1, k2:Integer;
  fl: TextFile;
  
begin
  
  if ParamCount < 2 then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  
  if not fileExists(ParamStr(1)) then
  begin
    writeln('Невозможно открыть входной файл для чтения');
    exit;
  end;
  
  AssignFile(fl, ParamStr(1));
  Reset(fl);
  
  readln(fl, n);
  getArray(fl, a, n);
  readln(fl, k1, k2);
  
  CloseFile(fl);
  
  AssignFile(fl, ParamStr(2));
  Rewrite(fl);
  if (not hasMultipleOfNumber(a, n, k1)) then
  begin
     writeln(fl, 'В массиве нет элементов, кратных ', k1);
     writeln(fl, 'Произведение элементов массива, кратных другому числу ', k2, ': ',  multipleOfNumber(a, 0, n - 1, k2));
  end
  else
     writeln(fl, 'В массиве есть элементы, кратные ', k1);
  CloseFile(fl);
  
end.
