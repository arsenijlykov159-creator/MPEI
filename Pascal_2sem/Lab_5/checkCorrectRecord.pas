unit checkCorrectRecord;


interface

uses commonTypes_type;

function isIntegerCorrect(const k: string): boolean;
function isYearCorrect(const k: Integer): boolean;
function isMarkCorrect(const k: Integer): boolean;
function isCorrectBoolean(const k: string): Boolean;
function isStringCorrect(const k: string): boolean;
function isGroupCorrect(const k: string): boolean;
function isNameCorrect(const k: string): boolean;
procedure readRecord(var fl: TextFile; var k: TStudents);


implementation

function isIntegerCorrect(const k: string): boolean;
var
  v, err: Integer;
begin
  val(k, v, err);
  if (err = 0) then result := true
  else result := false;
end;


function isYearCorrect(const k: Integer): boolean;
begin
  if (k >= 1926) and (k <= 2026) then result := true
  else result := false;
end;


function isMarkCorrect(const k: Integer): boolean;
begin
  if (k >= 2) and (k <= 5) then result := true
  else result := false;
end;


function isCorrectBoolean(const k: string): Boolean;
begin
  if (k = 'man') or (k = 'boy') or (k = 'm') or (k = '1') or (k = 'м') then
    result := true
  else {if (k = 'woman') or (k = 'girl') or (k = 'w') or (k = '0') or (k = 'false') then}
    result := false;
end;


function isStringCorrect(const k: string): boolean;
var
  element: Integer;
begin
  
  if length(k) > 20 then
  begin
    result := false;
    exit;
  end
  else
  begin
    for i: Integer := 1 to length(k) do
    begin
      element := ord(k[i]);
      if not (((element >= 97) and (element <= 122)) or ((element >= 65) and (element <= 90)) or ((element >= 1040))) then
      begin
        result := false;
        exit;
      end;
    end;
    
    result := true;
  end;
end;


function isGroupCorrect(const k: string): boolean;
begin
  if (length(k) <> 7) then result := false
  else
  begin
    if (isStringCorrect(k[1]) and (k[2] = '-') and isIntegerCorrect(k[3] + k[4]) and (k[5] = '-') and isIntegerCorrect(k[6]) and isIntegerCorrect(k[7])) then result := true
    else result := false;
  end;
end;


function isNameCorrect(const k: string): boolean;
var
  isNameString: boolean;
begin
  
  isNameString := true;
  for i: Integer := 1 to length(k) - 5 do
    if (not isStringCorrect(k[i])) then
    begin
      isNameString := false;
      break;
    end;
  
  if ((k[length(k)] = '.') and isStringCorrect(k[length(k) - 1]) and (k[length(k) - 2] = '.') and isStringCorrect(k[length(k) - 3]) and (k[length(k) - 4] = ' ') and isNameString) then result := true
  else result := false;
  
end;


procedure readRecord(var fl: TextFile; var k: TStudents);
var
  element: string;
  e: string;
  i: Integer;
  j: Integer := 1;
  new_i: Integer := 1;
begin
  
  readln(fl, element);
  while (j <= 8) do
  begin
    i := new_i;
    e := '';
    
    while (i <= length(element)) and (element[i] <> ',') do
    begin
      e += element[i];
      i += 1;
    end;
    if (i <= length(element)) then new_i := i + 2
    else new_i := i;
    
    case j of
      1: k.group := e;
      2: if isNameCorrect(e) then k.fio := e;
      3: if isIntegerCorrect(e) then k.year := StrToInt(e);
      4: k.gender := isCorrectBoolean(e);
      5: if isIntegerCorrect(e) then k.marks.math := StrToInt(e);
      6: if isIntegerCorrect(e) then k.marks.physics := StrToInt(e);
      7: if isIntegerCorrect(e) then k.marks.info := StrToInt(e);
      8: 
        begin
          try
            k.money := StrToInt(e);
          except
            writeln('Предупреждение: у некоторых студентов нет стипендии!');
            k.money := 0;
          end;
        end;
    end;
    j += 1;
  end;
end;

end.