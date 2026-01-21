program Lab_12;

uses commonTypes;
uses inputMatrixOutputArray;
uses averageOfElementOfMatrixAndExistPositiveRow;
uses arrayOfMatrix;

var
  fl: TextFile;
  matrix_1, matrix_2: matrix;
  row_1, col_1: integer;
  row_2, col_2: integer;
  array_1, array_2: arr;
  av_1, av_2: real;
  cnt_array_1, cnt_array_2: integer;

function F_1(x: integer): real;
begin
  result := x;
end;

function F_2(x: integer): real;
begin
  result := sin(x) + cos(x) + sin(x)/cos(x) + cos(x)/sin(x);
end;

begin
  if ParamCount < 2 then writeln('Недостаточно параметров')
  else
  begin
    if not FileExists(ParamStr(1)) then writeln('Невозможно открыть второй файл для чтения')
    else
    begin
      
      AssignFile(fl, ParamStr(1));
      Reset(fl);
      inputMatrix(fl, matrix_1, row_1, col_1);
      inputMatrix(fl, matrix_2, row_2, col_2);
      CloseFile(fl);
      
      AssignFile(fl, ParamStr(2));
      Rewrite(fl);
      av_1 := averageMatrix(F_1, matrix_1, row_1, col_1);
      av_2 := averageMatrix(F_1, matrix_2, row_2, col_2);
      writeln(fl, 'Средние арифметические: ', av_1, ' и ', av_2);
      if av_1 < av_2 then 
      begin
        arrayMatrix(matrix_1, row_1, col_1, av_1, array_1, cnt_array_1);
        outputArray(fl, 'Массив 1: ', array_1, cnt_array_1);
        writeln(fl, 'Существует ли строка с положительной суммой элементов в матрице 2: ', positiveRow(matrix_2, row_2, col_2));
      end
      else if av_1 > av_2 then 
      begin
        writeln(fl, 'Существует ли строка с положительной суммой элементов в матрице 1: ', positiveRow(matrix_1, row_1, col_1));
        arrayMatrix(matrix_2, row_2, col_2, av_2, array_2, cnt_array_2);
        outputArray(fl, 'Массив 2: ', array_2, cnt_array_2);
      end
      else writeln(fl, 'В матрицах одинаковое среднее арифметическое элементов, удовлетворяющих условиям: ');
      CloseFile(fl);
    end;
  end;
end.

//тесты
//2 2
//1 -2
//3 -4
//2 2
//-5 6
//-7 -8
//
//2 2
//1 -2
//3 4
//2 2
//-5 6
//-7 -8
//
//2 2
//0 0
//0 0
//1 2
//10 11
//
//1 3
//10 11 -40
//2 2
//1 2
//-3 4