program Lab_4;

const
  nmax = 10;

type
  mas = array[1..nmax] of real;

var
  exist: boolean;
  a, x, y: mas;
  n, cnt, el, s_me_a, s_mm_a, xa: integer;
  max_a, max_mod_a, sum_r: real;
  in_fl, out_fl: TextFile;

begin
  
  
  if ParamCount < 2 then writeln('Недостаточно параметров')
   else
  begin
    if not FileExists(ParamStr(1)) then
      writeln('Невозможно открыть файл input.txt для чтения')
    else
    begin
      AssignFile(in_fl, ParamStr(1));
      Reset(in_fl);
      readln(in_fl, n);
      for i: integer := 1 to n do
        read(in_fl, a[i]);
      for i: integer := 1 to n do
        read(in_fl, x[i]);
      for i: integer := 1 to n do
        read(in_fl, y[i]);
      Closefile(in_fl);
    end;
    
    exist := true;
    xa := 1;
    while (xa <= n) and (a[xa] >= 0) do
      xa := xa + 1;
    if xa = n+1 then
      exist := false;

   if exist then
    begin
      max_a := a[1];
      max_mod_a := 0;
      for el := 1 to n do
      begin
        if a[el] > max_a then
        begin
          max_a := a[el];
          s_me_a := el;
        end;
        if Abs(a[el]) > max_mod_a then
        begin
          max_mod_a := Abs(a[el]);
          s_mm_a := el;
        end;
      end;
    end
    else
    begin
      cnt := 0;
      for el := 1 to n do
      begin
        if y[el] > x[el] then
          cnt := cnt + 1;
        sum_r := sum_r + sqrt(power(el, 2) + power(a[el], 2));
      end;
    end;
    
    AssignFile(out_fl, ParamStr(2));
    Rewrite(out_fl);
    if exist then
    begin
      writeln(out_fl, 'Номер наиболшего элемента: ', s_me_a);
      writeln(out_fl, 'Номер наиболшего модуля элемента: ', s_mm_a);
    end
    else
    begin
      writeln(out_fl, 'Количество точек, у которых Y>X: ', cnt);
      writeln(out_fl, 'Сумма растояний точек до центра: ', sum_r);
    end;
    Closefile(out_fl);
  end;
end.

