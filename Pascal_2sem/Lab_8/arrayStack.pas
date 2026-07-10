unit arrayStack;

interface

type
  TInfo = Integer;
  stack = array of TInfo;
  
  
procedure initStack(var s: stack);
function isStackEmpty(const s: stack): boolean;
procedure push(var s: stack; const element: TInfo);
function pop(var s: stack; var element: TInfo): boolean;
function deleteStack(var s: stack): boolean;


implementation


procedure initStack(var s: stack);
begin
  SetLength(s, 0);
end;


function isStackEmpty(const s: stack): boolean;
begin
  result := (Length(s) = 0);
end;


procedure push(var s: stack; const element: TInfo);
begin
  SetLength(s, Length(s) + 1);
  s[High(s)] := element;
end;


function pop(var s: stack; var element:TInfo): boolean;
var
  lastIndex: Integer;
begin
  if (Length(s) = 0) then
  begin
    result := false;
    exit;
  end;
  
  lastIndex := High(s);
  element := s[lastIndex];
  SetLength(s, lastIndex);
  result := true;
end;


function deleteStack(var s: stack): boolean;
begin
  if (Length(s) = 0) then
  begin
    result := false;
    exit;
  end;
  
  SetLength(s, 0);
  result := true;
end;


end.