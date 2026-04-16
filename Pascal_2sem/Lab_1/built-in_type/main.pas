program Lab1;

uses commonTypes;
uses readWriteSet;

var
  a, b, c: CharSet;
  fl: TextFile;

begin
  if ParamCount < 2 then writeln('Недостаточно парметров')
  else
  begin
    if not FileExists(ParamStr(1)) then writeln('Невозможно открыть входной файл для чтения')
    else
    begin
      AssignFile(fl, ParamStr(1));
      Reset(fl);
      
      a := [];
      readSet(fl, a);
      b := [];
      readSet(fl, b);
      c := [];
      readSet(fl, c);
      
      CloseFile(fl);
      
      AssignFile(fl, ParamStr(2));
      Rewrite(fl);
      
      writeSet(fl, a + b, 'Объединение множеств a и b:    ');
      writeSet(fl, a * b, 'Пересечение множеств a и b:    ');
      writeSet(fl, a - b, 'Разность множеств a и b:    ');
      writeSet(fl, (a * b) * (c - b), '(a and b) and (c \ b):    ');
      
      CloseFile(fl);
    end;
  end;
end.
