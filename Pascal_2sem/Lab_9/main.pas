program main;

uses analyzer;

var
  result: AnalysisResults;
  
procedure PrintError(errorCode: AnalysisResults);
begin
  write('Ошибка: ');
  case errorCode of
    EXP_FUNCTION: writeln('Ожидается ключевое слово "FUNCTION"');
    EXP_ID: writeln('Ожидается идентификатор');
    EXP_BEGIN: writeln('Ожидается ключевое слово "BEGIN"');
    EXP_END: writeln('Ожидается ключевое слово "END"');
    EXP_SC: writeln('Ожидается точка с запятой (;)');
    EXP_NUMBER: writeln('Ожидается число');
    EXP_ASSIGN: writeln('Ожидается оператор присваивания (:=)');
    EXP_OPERAND: writeln('Ожидается операнд (идентификатор или число)');
    EXP_SIGN: writeln('Ожидается знак операции');
    OK: writeln('Успех!');
  end;
end;


function analyzeProgram: AnalysisResults;
var
  tempResult: AnalysisResults;
begin
  writeln('Анализ вызова функции...');
  tempResult := analyzeFunctionCall;
  if tempResult <> OK then
  begin
    result := tempResult;
    exit;
  end;
  writeln('  ✓ Вызов функции корректен');
  writeln;
  
//    writeln('Анализ определения функции...');
//    tempResult := analyzeFunction;
//    if tempResult <> OK then
//    begin
//      result := tempResult;
//      exit;
//    end;
//    writeln('  ✓ Определение функции корректно');
//    writeln;
  
  result := OK;
end;

begin
  
  if ParamCount < 2 then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  
  if not FileExists(ParamStr(1)) then
  begin
    writeln('Невозможно открыть входной файл');
    exit;
  end;
  
  writeln('=========================================');
  writeln('    Синтаксический анализатор языка');
  writeln('=========================================');
  writeln;
  
  AssignFile(fl, ParamStr(1));
  Reset(fl);
  
  readChar;
  result := analyzeProgram;
  
  if result <> OK then
    PrintError(result);
  
  CloseFile(fl);
end.