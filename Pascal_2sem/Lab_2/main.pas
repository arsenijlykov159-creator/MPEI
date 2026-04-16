program lab_2;

uses commonTypes;
uses getInputArrays;
uses operations;

var
  fl: TextFile;
  m: Matrix;
  m_rows, m_columns: Integer;
  res: UnsortedRow;
  a, b: Arr;
  res_a, res_b: Integer;
  a_count, b_count: Integer;
  
  
begin
  
  if ParamCount < 2 then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  
  if (not FileExists(ParamStr(1))) then
  begin
    writeln('Невозможно открыть входной файл для чтения');
    exit;
  end;
  
  AssignFile(fl, ParamStr(1));
  Reset(fl);
  
  readln(fl, m_rows, m_columns);
  getMatrix(fl, m, m_rows, m_columns);
  
  readln(fl, a_count);
  getArray(fl, a, a_count);
  readln(fl, b_count);
  getArray(fl, b, b_count);
  
  CloseFile(fl);
  
  AssignFile(fl, ParamStr(2));
  Rewrite(fl);
  
  res := countPositiveInLastUnsortedRow(m, m_rows, m_columns);
  if (res.row <> -1) then
    writeln(fl, 'Количество положительных элементов в последней несортированной строке: ', res.positive_count)
  else 
  begin
    remakeMatrix(m, m_rows, m_columns);
    inputMatrix(fl, 'Измененная матрица', m, m_rows, m_columns);
  end;
  
  res_a := positiveCount(a, a_count);
  res_b := positiveCount(b, b_count);
  
  write(fl, 'Максимальное количество положительных элементов имеет массив: ');
  if (res_a < res_b) then
    writeln(fl, '1')
  else if (res_a > res_b) then writeln(fl, '2')
  else writeln(fl, 'одинаково');
  
  CloseFile(fl);
  
end.


