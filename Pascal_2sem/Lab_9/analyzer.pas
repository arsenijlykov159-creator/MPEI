unit analyzer;

interface

type
  AnalysisResults = (OK, EXP_FUNCTION, EXP_ID, EXP_BEGIN, EXP_END, EXP_SC, EXP_NUMBER, 
                    EXP_ASSIGN, EXP_OPERAND, EXP_SIGN);
  LexemeType = (ID, SC, NUMBER, SIGN, ERROR);

function analyzeFunction: AnalysisResults;
function analyzeFunctionCall: AnalysisResults;

var
  fl: TextFile;

implementation


var
  c: char;
  lexeme: string;


procedure getChar;
begin
  if not eof(fl) then
    read(fl, c)
  else
    c := #0;
end;


function readID: LexemeType;
begin
  lexeme := '';
  lexeme := lexeme + c;
  
  while true do
  begin
    getChar;
    if (c = '_') or (c in ['a'..'z', 'A'..'Z']) or (c in ['0'..'9']) then
      lexeme := lexeme + c
    else break;
  end;
  
  result := ID;
end;


function readNumber: LexemeType;
begin
  lexeme := lexeme + c;
  getChar;
  
  while (c >= '0') and (c <= '9') do
  begin
    lexeme := lexeme + c;
    getChar;
  end;
  
  result := NUMBER;
end;


function readSign: LexemeType;
begin
  lexeme := lexeme + c;
  getChar;
  
  if ((c = '=') and (lexeme[1] in [':', '<', '>'])) or 
     ((c = '>') and (lexeme[1] = '<')) then
  begin
    lexeme := lexeme + c;
    getChar;
  end;
  
  result := SIGN;
end;


function readLexeme: LexemeType;
begin
  lexeme := '';
  
  if c = #0 then
    getChar;
  
  while (c = ' ') or (c = #9) or (c = #10) or (c = #13) do
    getChar;
  
  if eof(fl) then
  begin
    result := ERROR;
    exit;
  end;
  
  writeln('[LEX] c="', c, '" ord=', ord(c));
  
  if c = ';' then
  begin
    lexeme := c;
    result := SC;
    getChar;
  end
  else if (c = '_') or (c in ['a'..'z', 'A'..'Z']) then
    result := readID
  else if (c in ['0'..'9']) then
    result := readNumber
  else result := readSign;
end;


function IsNumber(s: string): boolean;
var
  i: integer;
begin
  s := Trim(s);
  
  if Length(s) = 0 then
  begin
    result := false;
    exit;
  end;
  
  result := true;
  for i := 1 to Length(s) do
    if not (s[i] in ['0'..'9']) then
    begin
      result := false;
      exit;
    end;
end;


function IsIdentifier(s: string): boolean;
var
  i: integer;
begin
  s := Trim(s);
  
  if Length(s) = 0 then
  begin
    result := false;
    exit;
  end;
  
  result := true;
  for i := 1 to Length(s) do
    if not (s[i] in ['a'..'z', 'A'..'Z', '0'..'9', '_']) then
    begin
      result := false;
      exit;
    end;
end;


function IsValidParameter(s: string): boolean;
begin
  s := Trim(s);
  
  writeln('[CHECK] Проверяем параметр: "', s, '"');
  
  if IsNumber(s) then
  begin
    writeln('[CHECK] Это число - OK');
    exit(true);
  end;
  
  if IsIdentifier(s) then
  begin
    writeln('[CHECK] Это идентификатор - OK');
    exit(true);
  end;
  
  if Pos(' MOD ', ' ' + s + ' ') > 0 then
  begin
    writeln('[CHECK]  MOD');
    exit(true);
  end;
  
  if Pos(' DIV ', ' ' + s + ' ') > 0 then
  begin
    writeln('[CHECK]  DIV');
    exit(true);
  end;
  
  writeln('[CHECK] Встречен неподходящий параметр');
  result := false;
end;

function analyzeFunctionCall: AnalysisResults;
var
  paramStr: string;
  tempType: LexemeType;
begin
  writeln('[FCALL] Начало анализа вызова функции');
  
  // Имя переменной
  tempType := readLexeme;
  writeln('[FCALL] 1-й элемент: lexeme="', lexeme, '"');
  if tempType <> ID then
  begin
    writeln('[FCALL] ОШИБКА: ожидается ID, получен type=', ord(tempType));
    result := EXP_ID;
    exit;
  end;
  writeln('[FCALL] Имя переменной: "', lexeme, '"');
  
  // :=
  tempType := readLexeme;
  writeln('[FCALL] 2-й элемент lexeme="', lexeme, '"');
  if (tempType <> SIGN) or (lexeme <> ':=') then
  begin
    writeln('[FCALL] ОШИБКА: ожидалось :=, получено "', lexeme, '"');
    result := EXP_ASSIGN;
    exit;
  end;
  
  // Имя функции
  tempType := readLexeme;
  writeln('[FCALL] 3-й элемент lexeme="', lexeme, '"');
  if tempType <> ID then
  begin
    writeln('[FCALL] ОШИБКА: ожидается имя функции');
    result := EXP_ID;
    exit;
  end;
  writeln('[FCALL] Имя функции: "', lexeme, '"');
  
  // Открывающая скобка
  tempType := readLexeme;
  writeln('[FCALL] 4-й элемент lexeme="', lexeme, '"');
  if (tempType <> SIGN) or (lexeme <> '(') then
  begin
    writeln('[FCALL] ОШИБКА: ожидается (, получено "', lexeme, '"');
    result := EXP_SIGN;
    exit;
  end;
  
  // Параметр
  writeln('[FCALL] Начинаем чтение параметра...');
  paramStr := '';
  
  // Пропускаем пробелы после (
  while (c = ' ') or (c = #9) or (c = #10) or (c = #13) do
    getChar;
  
  while not eof(fl) and (c <> ')') do
  begin
    paramStr := paramStr + c;
    getChar;
  end;
  
  writeln('[FCALL] Прочитан параметр: "', paramStr, '"');
  
  if c <> ')' then
  begin
    writeln('[FCALL] ОШИБКА: не найдена закрывающая скобка');
    result := EXP_SIGN;
    exit;
  end;
  
  // Проверка параметр
  if not IsValidParameter(paramStr) then
  begin
    writeln('[FCALL] ОШИБКА: неверный параметр "', paramStr, '"');
    result := EXP_OPERAND;
    exit;
  end;
  
  // Закрывающаяся скобка
  getChar;
  writeln('[FCALL] Закрывающая скобка найдена');
  
  // Пропускаем пробелы
  while (c = ' ') or (c = #9) or (c = #10) or (c = #13) do
    getChar;
  
  // Точка с запятой
  writeln('[FCALL] Проверка точки с запятой, c="', c, '"');
  if c <> ';' then
  begin
    writeln('[FCALL] ОШИБКА: ожидалась ;, получено "', c, '"');
    result := EXP_SC;
    exit;
  end;
  
  getChar;
  writeln('[FCALL] УСПЕХ!');
  result := OK;
end;

function analyzeFunction: AnalysisResults;
var
  tempType: LexemeType;
begin
  // FUNCTION
  tempType := readLexeme;
  if (tempType <> ID) or (LowerCase(lexeme) <> 'function') then
  begin
    result := EXP_FUNCTION;
    exit;
  end;
  
  // имя функции
  tempType := readLexeme;
  if tempType <> ID then
  begin
    result := EXP_ID;
    exit;
  end;
  
  // ;
  tempType := readLexeme;
  if tempType <> SC then
  begin
    result := EXP_SC;
    exit;
  end;
  
  // BEGIN
  tempType := readLexeme;
  if (tempType <> ID) or (LowerCase(lexeme) <> 'begin') then
  begin
    result := EXP_BEGIN;
    exit;
  end;
  
  // имя в теле
  tempType := readLexeme;
  if tempType <> ID then
  begin
    result := EXP_ID;
    exit;
  end;
  
  // END
  tempType := readLexeme;
  if (tempType <> ID) or (LowerCase(lexeme) <> 'end') then
  begin
    result := EXP_END;
    exit;
  end;
  
  // ; - ТОЧКА С ЗАПЯТОЙ ПОСЛЕ END
  tempType := readLexeme;
  if tempType <> SC then
  begin
    result := EXP_SC;
    exit;
  end;
  
  result := OK;
end;

end.