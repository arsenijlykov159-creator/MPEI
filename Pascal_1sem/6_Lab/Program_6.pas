program lab_6;

const
  mmax = 5;
  nmax = 5;

type
  matrix = array[1..mmax, 1..nmax] of integer;

var
  a: matrix;
  exist: boolean;
  m, n, k: integer;
  i, j, start: integer;
  cnt, sum_el: integer;
  in_fl, out_fl: TextFile;

begin
  if ParamCount < 2 then writeln('Недостаточно параметров')
  else
  begin
    if not FileExists(ParamStr(1)) then writeln('Невозможно открыть входной файл для чтения')
    else
    begin
      AssignFile(in_fl, ParamStr(1));
      Reset(in_fl);
      Read(in_fl, m, n);
      for i := 1 to m do
        for j := 1 to n do
          read(in_fl, a[i][j]);
      Read(in_fl, k); 
      CloseFile(in_fl);
      
      exist := true;
      start := 1;
      i := 1;
      while (i <= m) and exist do
      begin
        j := 1;
        while (j <= n) and (a[i, j] <> k) do
          j := j + 1;
        if j > n then
        begin
          exist := false;
          start := i;
        end;
        i := i + 1;
      end;
      
      cnt := 0;
      for i := start to m do
      begin
        sum_el := 0;
        for j := 1 to n do
          sum_el := sum_el + a[i, j];
        if sum_el < 0 then cnt := cnt + 1;
      end;
    end;
    
    AssignFile(out_fl, ParamStr(2));
    Rewrite(out_fl);
    if not exist then
      writeln(out_fl, 'Количество строк после первой без элемента ', k, ' с отрицательной суммой: ', cnt)
    else
      writeln(out_fl, 'Количество строк с отрицательной суммой: ', cnt);
    CloseFile(out_fl);
  end;
end.