unit stackRealization;

interface

//uses listStack;
uses arrayStack;

procedure getStackFromFile(var fl: TextFile; var s: stack);
function outputStack(var fl: TextFile; var s: stack): boolean;
procedure deleteStackByCondition(var s: stack; F: function(x: TInfo): boolean);

implementation


procedure getStackFromFile(var fl: TextFile; var s: stack);
var
  info: TInfo;
begin
  while (not eof(fl)) do
  begin
    read(fl, info);
    push(s, info);
  end;
end;


function outputStack(var fl: TextFile; var s: stack): boolean;
var
  temp_s: stack;
  element: TInfo;
begin
  If (isStackEmpty(s)) then
  begin
    result := false;
    exit;
  end;
  
  initStack(temp_s);
  while (not isStackEmpty(s)) do
  begin
    pop(s, element);
    write(fl, element, ' ');
    push(temp_s, element);
  end;
  
  while (not isStackEmpty(temp_s)) do
  begin
    pop(temp_s, element);
    push(s, element);
  end;
  writeln(fl);
  result := true;
end;


procedure deleteStackByCondition(var s: stack; F: function(x: TInfo): boolean);
var
  temp_s: stack;
  temp: TInfo;
begin
  initStack(temp_s);
  
  while (not isStackEmpty(s)) do
  begin
    pop(s, temp);
    if (not F(temp)) then push(temp_s, temp);
  end;
  
  while (not isStackEmpty(temp_s)) do
  begin
    pop(temp_s, temp);
    push(s, temp);
  end;
end;

end.

