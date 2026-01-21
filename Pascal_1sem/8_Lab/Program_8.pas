program Lab_8;

const
  mmax = 5;
  nmax = 5;
  mnmax = 25;

type
  Arr = array[1..mnmax] of integer;
  Matrix = array[1..mmax, 1..nmax] of integer;

var
  matrix_1, matrix_2, matrix_3: Matrix;
  row_1, col_1, row_2, col_2, row_3, col_3: integer;
  m, n: integer;
  out_mas_1, out_mas_2, out_mas_3: Arr;
  cnt_1, cnt_2, cnt_3: integer;
  fl: TextFile;


procedure Open(var fil: TextFile; var m_1: Matrix; var r_1, c_1: integer);
begin
  Read(fil, r_1, c_1);
  for i: integer := 1 to r_1 do
    for j: integer := 1 to c_1 do
      read(fil, m_1[i, j]);
  readln(fil);
end;


procedure Main(mat: Matrix; left, right: integer; start_row, end_row, start_col, end_col: integer; var out_mas: Arr; var cnt: integer);
begin
  cnt := 0;
  for i: integer := start_row to end_row do
    for j: integer := start_col to end_col do
      if (mat[i, j] < left) or (mat[i, j] > right) then
      begin
        cnt := cnt + 1;
        out_mas[cnt] := mat[i, j];
      end;
end;


function findElementFromArray(mas: Arr; cnt: integer): integer;
var
  i: integer;
begin
  i := 1;
  while (i <= cnt) and (mas[i] <= 0) do
    i := i + 1;
  if i > cnt then
    result := 0
  else result := mas[i];
end;


procedure deleteElementFromArray(var mas: Arr; var cnt: integer; el: integer);
var
  i: integer;
  found: boolean;
begin
  i := 1;
  found := false;
  while (i <= cnt) and not found do
  begin
    if mas[i] = el then
    begin
      found := true;
      for j: integer := i to cnt do
        mas[j] := mas[j + 1];
      cnt := cnt - 1;
    end;
    i := i + 1;
  end;
end;


procedure Out(fl_name, nomer: string; mas: Arr; cnt: integer);
var
  fl: TextFile;
begin
  AssignFile(fl, fl_name);
  if not FileExists(ParamStr(2)) then Rewrite(fl)
  else
    Append(fl);
  write(fl, nomer);
  for i: integer := 1 to cnt do
    write(fl, mas[i], ' ');
  writeln(fl);
  CloseFile(fl);
end;


begin
  if ParamCount < 2 then writeln('Недостаточно параметров')
  else
  begin
    if not FileExists(ParamStr(1)) then writeln('Невозможно открыть файл для чтения')
    else
    begin
      AssignFile(fl, ParamStr(1));
      Reset(fl);
      Open(fl, matrix_1, row_1, col_1);
      Open(fl, matrix_2, row_2, col_2);
      Open(fl, matrix_3, row_3, col_3);
      Read(fl, m, n);
      CloseFile(fl);
    end;
    //
    if (col_1 mod 2 <> 0) then writeln('Число строк и столбцов матрицы 1 нечетно')
    else 
    begin
      Main(matrix_1, m, n, 1, row_1, 1, col_1 div 2, out_mas_1, cnt_1);
      if (cnt_1 <> 0) then Out(ParamStr(2), '1: ', out_mas_1, cnt_1)
      else Out(ParamStr(2), '1: пустой', out_mas_1, cnt_1)
    end;
    if (col_2 mod 2 <> 0) then writeln('Число строк и столбцов матрицы 2 нечетно')
    else 
    begin
      Main(matrix_2, m, n, 1, row_2, col_2 div 2 + 1, col_2, out_mas_2, cnt_2);
      if (cnt_2 <> 0) then Out(ParamStr(2), '2: ', out_mas_2, cnt_2)
      else Out(ParamStr(2), '2: пустой', out_mas_2, cnt_2)
    end;
    if (row_3 mod 2 <> 0) then writeln('Число строк и столбцов матрицы 3 нечетно')
    else 
    begin
      Main(matrix_3, m, n, 1, row_3 div 2, 1, col_3, out_mas_3, cnt_3);
      if (cnt_3 <> 0) then Out(ParamStr(2), '3: ', out_mas_3, cnt_3)
      else Out(ParamStr(2), '3: пустой', out_mas_3, cnt_3)
    end;
    //
    if (cnt_1 > 0) then
    begin
      deleteElementFromArray(out_mas_1, cnt_1, findElementFromArray(out_mas_2, cnt_2));
      deleteElementFromArray(out_mas_1, cnt_1, findElementFromArray(out_mas_3, cnt_3));
    end;
    //
    Out(ParamStr(2), '1: ', out_mas_1, cnt_1);
    AssignFile(fl, ParamStr(2));
    Append(fl);
    writeln(fl, 'END');
    CloseFile(fl);
    //
  end;
end.