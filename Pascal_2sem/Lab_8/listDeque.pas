unit listDeque;

interface

type
  TInfo = Integer;

  PElement = ^TElement;
  
  TElement = record
    info: TInfo;
    next, previous: PElement;
  end;
  
  deque = record
    head, tail: PElement;
  end;
  
  
procedure initDeque(var d: deque);
function isDequeEmpty(const d: deque): boolean;
procedure pushToHead(var d: deque; const element: TInfo);
procedure pushToTail(var d: deque; const element: TInfo);
function popFromHead(var d: deque; var element: TInfo): boolean;
function popFromTail(var d: deque; var element: TInfo): boolean;
function deleteDeque(var d: deque): boolean;


implementation


procedure initDeque(var d: deque);
begin
  d.head := nil;
  d.tail := nil;
end;


function isDequeEmpty(const d: deque): boolean;
begin
  result := (d.tail = nil);
end;


procedure pushToHead(var d: deque; const element: TInfo);
var
  p: PElement;
begin
  new(p);
  p^.info := element;
  p^.next := nil;
  p^.previous := nil;
  
  if (isDequeEmpty(d)) then
  begin
    d.head := p;
    d.tail := p;
  end
  else
  begin
    p^.next := d.head;
    d.head^.previous := p;
    d.head := p;
  end;
end;


procedure pushToTail(var d: deque; const element: TInfo);
var
  p: PElement;
begin
  new(p);
  p^.info := element;
  p^.next := nil;
  p^.previous := nil;
  
  if (isDequeEmpty(d)) then
  begin
    d.head := p;
    d.tail := p;
  end
  else
  begin
    p^.previous := d.tail;
    d.tail^.next := p;
    d.tail := p;
  end;
end;


function popFromHead(var d: deque; var element: TInfo): boolean;
var
  p: PElement;
begin
  if (isDequeEmpty(d)) then 
  begin
    result := false;
    exit;
  end;
  
  p := d.head;
  element := p^.info;
  d.head := p^.next;
  if (d.head <> nil) then d.head^.previous := nil
  else d.tail := nil;
  dispose(p);
  result := true;
end;


function popFromTail(var d: deque; var element: TInfo): boolean;
var
  p: PElement;
begin
  if (isDequeEmpty(d)) then 
  begin
    result := false;
    exit;
  end;
  
  p := d.tail;
  element := p^.info;
  d.tail := p^.previous;
  if (d.tail <> nil) then d.tail^.next := nil
  else d.head := nil;
  dispose(p);
  result := true;
end;


function deleteDeque(var d: deque): boolean;
var
  p: PElement;
begin
  if (isDequeEmpty(d)) then 
  begin
    result := false;
    exit;
  end;
  
  repeat
    p := d.head;
    d.head := d.head^.next;
    dispose(p);
  until (d.head = nil);
  d.tail := nil;
  result := true;
end;


end.