program lab_4_2;

uses mergeSorting;

var
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
  
  start := System.DateTime.Now;
  directSorting(ParamStr(1), ParamStr(2));
  finish := System.DateTime.Now;
  ts := finish - start;
  
  writeln(isSorted(ParamStr(2)));
  writeln(Format('{0:d2}:{1:d2}.{2:d3}', ts.Minutes, ts.Seconds, ts.Milliseconds));
  
end.