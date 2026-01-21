program Lab_10;

uses commonTypes;
uses oneRowSumLessEpsilon;
uses replaceSquareMatrixElement;
uses inputOutputMatrixFromFile;

var
  fl: TextFile;
  matrix_1, matrix_2, matrix_3: matrix;
  row_1, col_1, row_2, col_2, row_3, col_3: integer;
  epsilon: integer;

begin
  if ParamCount < 2 then writeln('Недостаточно параметров')
  else
  begin
    if not FileExists(ParamStr(1)) then writeln('Невозможно открыть входной файл')
    else
    begin
      AssignFile(fl, ParamStr(1));
      Reset(fl);
      inputMatrix(fl, matrix_1, row_1, col_1);
      inputMatrix(fl, matrix_2, row_2, col_2);
      inputMatrix(fl, matrix_3, row_3, col_3);
      read(fl, epsilon);
      CloseFile(fl);
      
      if oneRowSumLessE(matrix_1, row_1, col_1, epsilon) then
        replaceBySquare(matrix_1, row_1, col_1);
      if oneRowSumLessE(matrix_2, row_2, col_2, epsilon) then
        replaceBySquare(matrix_2, row_2, col_2);
      if oneRowSumLessE(matrix_3, row_3, col_3, epsilon) then
        replaceBySquare(matrix_3, row_3, col_3);
      
      AssignFile(fl, ParamStr(2));
      Rewrite(fl);
      if (row_1 = 0) and (col_1 = 0) then outputMatrix(fl, '1: пустая', matrix_1, row_1, col_1)
      else outputMatrix(fl, '1: ', matrix_1, row_1, col_1);
      if (row_2 = 0) and (col_2 = 0) then outputMatrix(fl, '2: пустая', matrix_2, row_2, col_2)
      else outputMatrix(fl, '2: ', matrix_2, row_2, col_2);
      if (row_3 = 0) and (col_3 = 0) then outputMatrix(fl, '3: пустая', matrix_3, row_3, col_3)
      else outputMatrix(fl, '3: ', matrix_3, row_3, col_3);
      CloseFile(fl);
    end;
  end;
end.