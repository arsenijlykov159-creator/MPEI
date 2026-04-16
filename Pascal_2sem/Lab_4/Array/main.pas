program lab_4;

uses commonTypes;
uses arraySorting;
  
var
  fl: TextFile;
  a, a_initial: Arr;
  a_count, a_initial_count: Integer;
  start, finish: System.DateTime;
  ts: System.TimeSpan;
  
  
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
  getArray(fl, a, a_count);
//  a_initial := Copy(a);
//  a_initial_count := a_count;
  CloseFile(fl);
  
  start := System.DateTime.Now;
  fastSorting(a, 0, a_count - 1);
  finish := System.DateTime.Now;
  ts := finish - start;
  
  AssignFile(fl, ParamStr(2));
  Rewrite(fl);
  inputArray(fl, a, a_count);
  writeln(isSorted(a, a_count));
  CloseFile(fl);
  
  writeln(Format('{0:d2}:{1:d2}.{2:d3}', ts.Minutes, ts.Seconds, ts.Milliseconds));
end.