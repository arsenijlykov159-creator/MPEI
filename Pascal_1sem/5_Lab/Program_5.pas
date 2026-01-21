program Lab_5;

const
  nmax = 10;

type
  mas = array[1..nmax] of integer;

var
  n, k, el, min, x: integer;
  exist, exist_aft_k: boolean;
  a: mas;
  in_fl, out_fl: TextFile;

begin
  if ParamCount < 2 then writeln('Недостаточно параметров')
  else
  begin
    if not FileExists(ParamStr(1)) then writeln('Невозможно открыть файл для чтения')
    else
    begin
      AssignFile(in_fl, ParamStr(1));
      Reset(in_fl);
      read(in_fl, n);
      for i: integer := 1 to n do
        read(in_fl, a[i]);
      read(in_fl, k);
      Closefile(in_fl);
      
      el := 1;
      exist := false;
      while (el <= n) and (a[el] mod k <> 0) do
        el := el + 1;
      if el <= n then
        exist := true
      else
        el := 0;
      
      x := el + 1;
      exist_aft_k := true;
      while (x <= n) and (a[x] mod 2 = 0) do
        x := x + 1;
      if x <= n then
        min := a[x]
      else 
        exist_aft_k := false;
      
      if exist_aft_k then
        for i: integer := x to n do
        begin
          if (Abs(a[i] mod 2) = 1) and (a[i] <= min) then
            min := a[i];
        end
      else min := 0;
    end;
    AssignFile(out_fl, ParamStr(2));
    Rewrite(out_fl);
    if exist then
    begin
      if min <> 0 then writeln(out_fl, 'Минимальный нечетный элемент после первого, кратного k: ', min)
      else writeln(out_fl, 'После первого элемента, кратного k, нет нечетных элементов');
    end
      else
    begin
      if min <> 0 then writeln(out_fl, 'Элементов, кратных k, нет, минимальный нечетный элемент: ', min)
      else writeln(out_fl, 'В массиве нет ни элементов, кратных k, ни нечетных элементов');
    end;
    Closefile(out_fl);
  end;
end.