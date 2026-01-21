program Lab_9;

const
  nmax = 10;

type
  Matrix = array[1..nmax, 1..nmax] of real;

var
  a, b, c: Matrix;
  res_a, res_b, res_c: integer;
  max_res, num_res: integer;
  na, nb, nc: integer;
  in_fl, out_fl: TextFile;


procedure input(var fil: TextFile; var mtrx: Matrix; var count: integer);
begin
  read(fil, count);
  for i: integer := 1 to count do
    for j: integer := 1 to count do
      read(fil, mtrx[i, j]);
end;

procedure output(out_fl_name, name: string; mtrx: Matrix; count: integer);
var
  fl: TextFile;
begin
  AssignFile(fl, out_fl_name);
  if not FileExists(out_fl_name) then Rewrite(fl)
  else Append(fl);
  writeln(fl, 'Матрица ', name, ': ', count);
  for i: integer := 1 to count do
  begin
    for j: integer := 1 to count do
      write(fl, mtrx[i, j]:8:2);
    writeln(fl);
  end;
  Closefile(fl);
end;

function mainDiagonal(mtrx: Matrix; mtrx_len: integer): integer;
var
  positive_count: integer;
begin
  positive_count := 0;
  for i: integer := 1 to mtrx_len do
    for j: integer := i + 1 to mtrx_len do
      if mtrx[i, j] > 0 then positive_count := positive_count + 1;
  result := positive_count;
end;

function sideDiagonal(mtrx: Matrix; mtrx_len: integer): integer;
var
  positive_count: integer;
begin
  positive_count := 0;
  for i: integer := 1 to mtrx_len do
    for j: integer := 1 to mtrx_len - i do
      if mtrx[i, j] > 0 then positive_count := positive_count + 1;
  result := positive_count;
end;


begin
  if ParamCount < 2 then writeln('Недостаточно параметров')
  else
  begin
    if not FileExists(ParamStr(1)) then writeln('Невозможно открыть входной файл')
    else
    begin
      AssignFile(in_fl, ParamStr(1));
      Reset(in_fl);
      input(in_fl, a, na);
      input(in_fl, b, nb);
      input(in_fl, c, nc);
      CloseFile(in_fl);
    end;
    
    res_a := mainDiagonal(a, na) - sideDiagonal(a, na);
    res_b := mainDiagonal(b, nb) - sideDiagonal(b, nb);
    res_c := mainDiagonal(c, nc) - sideDiagonal(c, nc);
    
    output(ParamStr(2), 'A', a, na);
    output(ParamStr(2), 'B', b, nb);
    output(ParamStr(2), 'C', c, nc);
    //
    max_res := res_a;
    num_res := 1;
    if res_b > max_res then
    begin
      max_res := res_b;
      num_res := 2;
    end;
    if res_c > max_res then 
    begin
      max_res := res_c;
      num_res := 3;
    end;
    //
    AssignFile(out_fl, ParamStr(2));
    Append(out_fl);
    writeln(out_fl, 'A: ', res_a);
    writeln(out_fl, 'B: ', res_b);
    writeln(out_fl, 'C: ', res_c);
    if ((res_a = res_b) and (res_a = res_c) and (res_a = max_res)) then writeln(out_fl, 'У всех трех матриц совпадают наибольшие зачения и равны: ', res_a)
    else if ((res_a = res_b) and (res_a = max_res)) then writeln(out_fl, 'У матриц A и B совпадают наибольшие значения и равны: ', res_a)
    else if ((res_a = res_c) and (res_a = max_res)) then writeln(out_fl, 'У матриц A и C совпадают наибольшие значения и равны: ', res_a)
    else if ((res_b = res_c) and (res_b = max_res)) then writeln(out_fl, 'У матриц B и C совпадают наибольшие значения и равны: ', res_c)
    else 
    begin
      writeln(out_fl, 'Наибольшую разность между количествами положительных элементов, удовлетворяющих условиям, имеет матрица: ', num_res);
      writeln(out_fl, 'Наибольшая разность: ', max_res);
    end;
    Closefile(out_fl);
  end;
end.