unit listStack;

interface

type
  TInfo = Integer;

  PElement = ^TElement;
  
  TElement = record
    info: TInfo;
    next: PElement;
  end;
  
  stack = PElement;
  
  
procedure initStack(var s: stack);
function isStackEmpty(const s: stack): boolean;
procedure push(var s: stack; const element: TInfo);
function pop(var s: stack; var element: TInfo): boolean;
function deleteStack(var s: stack): boolean;


implementation

procedure initStack(var s: stack);
begin
  s := nil;
end;


function isStackEmpty(const s: stack): boolean;
begin
  result := (s = nil);
end;


procedure push(var s: stack; const element: TInfo);
var
  p: PElement;
begin
  new(p);
  p^.info := element;
  p^.next := s;
  s := p;
end;


function pop(var s: stack; var element: TInfo): boolean;
var
  p: PElement;
begin
  if (isStackEmpty(s)) then 
  begin
    result := false;
    exit;
  end;
  
  element := s^.info;
  p := s;
  s := s^.next;
  dispose(p);
  result := true;
end;


function deleteStack(var s: stack): boolean;
var
  p: PElement;
begin
  if (isStackEmpty(s)) then 
  begin
    result := false;
    exit;
  end;
  
  repeat
    p := s;
    s := s^.next;
    dispose(p);
  until (s = nil);
  result := true;
end;

end.  