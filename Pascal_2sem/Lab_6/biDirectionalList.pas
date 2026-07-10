unit biDirectionalList;


interface

uses commonTypes;

type
  PElement = ^TElement;
  
  TElement = record
    info: TInfo;
    previous, next: PElement;
  end;
  
  List = record
    first, last: PElement;
  end;
  
procedure initList(var x: List);
function isListEmpty(const x: List): boolean;
procedure insertElement(var x: List; const element: TInfo; pos: PElement := nil);
procedure searchElement(const x: List; F: searchFunction; var start, finish: PElement);
procedure deleteElement(var x: List; current: PElement);
procedure deleteList(var x: List);

procedure insertByOrder(var x: List; const element: TInfo);
procedure getList(var f: TextFile; var x: List);
procedure getListByOrder(var f: TextFile; var x: List);
function outputList(var f: TextFile; const x: List): boolean;
procedure deleteByCondition(var x: List; F: searchFunction);

  
  
implementation

procedure initList(var x: List);
begin
  x.first := nil;
  x.last := nil;
end;


function isListEmpty(const x: List): boolean;
begin
  result := (x.last = nil);
end;


procedure insertElement(var x: List; const element: TInfo; pos: PElement);
var
  p: PElement;
begin
  new(p);
  p^.info := element;
  if (pos = nil) then
  begin
    if (x.last = nil) then
    begin
      x.first := p;
      x.last := p;
      p^.previous := x.last;
      p^.next := x.first;
    end
    else
    begin
      p^.previous := x.last;
      p^.next := x.first;
      x.first^.previous := p;
      x.last^.next := p;
      x.first := p;
    end;
  end
  else
  begin
    p^.previous := pos;
    p^.next := pos^.next;
    pos^.next^.previous := p;
    pos^.next := p;
    if (pos = x.last) then x.last := p;
  end;
end;


procedure searchElement(const x: List; F: searchFunction; var start, finish: PElement);
var
  p: PElement;
begin
  start := nil;
  finish := nil;
  
  if isListEmpty(x) then exit;
  
  p := x.first;
  repeat
    if F(p^.info) then
    begin
      start := p;
      break;
    end;
    p := p^.next;
  until (p = x.first);
  
  p := x.last;
  repeat
    if F(p^.info) then
    begin
      finish := p;
      break;
    end;
    p := p^.previous;
  until (p = x.last);
end;


procedure deleteElement(var x: List; current: PElement);
begin
  if (current = nil) then exit;
  
  if (current = x.first) and (x.first = x.last) then
  begin
    x.first := nil;
    x.last := nil;
    dispose(current);
  end
  else if (current = x.first) then
  begin
    x.last^.next := x.first^.next;
    x.first^.next^.previous := x.last;
    x.first := current^.next;
    dispose(current);
  end
  else if (current = x.last) then
  begin
    x.first^.previous := current^.previous;
    x.last^.previous^.next := x.first;
    x.last := x.last^.previous;
    dispose(current);
  end
  else 
  begin
    current^.previous^.next := current^.next;
    current^.next^.previous := current^.previous;
    dispose(current);
    current := nil;
  end;
end;


procedure deleteList(var x: List);
var
  p, next_p: PElement;
begin
  if isListEmpty(x) then exit;
  
  p := x.first;
  repeat
    next_p := p^.next;
    dispose(p);
    p := next_p;
  until (p = x.first);
  
  x.first := nil;
  x.last := nil;
end;


function outputList(var f: TextFile; const x: List): boolean;
var p: PElement;
begin
  if isListEmpty(x) then 
  begin
    result := false;
    exit;
  end;
  
  p := x.first;
  repeat
    write(f, p^.info, ' ');
    p := p^.next;
  until (p = x.first);
  
  write(f, '   -----   ');
  
  p := x.last;
  repeat
    write(f, p^.info, ' ');
    p := p^.previous;
  until (p = x.last);
  
  result := true;
  writeln(f);
end;


procedure insertByOrder(var x: List; const element: TInfo);
var
  current_pos: PElement;
begin
  if isListEmpty(x) then
  begin
    insertElement(x, element);
    exit;
  end;
  
  if (abs(element) < abs(x.first^.info)) then
  begin
    insertElement(x, element);
    exit;
  end;
  
  current_pos := x.first;
  while (current_pos <> x.last) do
  begin
    if (abs(element) >= abs(current_pos^.info)) and (abs(element) < abs(current_pos^.next^.info)) then
    begin
      insertElement(x, element, current_pos);
      exit;
    end;
    current_pos := current_pos^.next;
  end;
  
  insertElement(x, element, x.last);
end;


procedure getList(var f: TextFile; var x: List);
var
  element: TInfo;
  p: PElement;
begin
  p := x.first;
  
  while (not eof(f)) do
  begin
    readln(f, element);
    insertElement(x, element, p);
    if (p = nil) then p := x.first;
    p := p^.next;
  end;
end;


procedure getListByOrder(var f: TextFile; var x: List);
var
  element: TInfo;
begin
  while (not eof(f)) do
  begin
    readln(f, element);
    insertByOrder(x, element);
  end;
end;


procedure deleteByCondition(var x: List; F: searchFunction);
var
  p, next_p: PElement;
begin
  if isListEmpty(x) then
  begin
    writeln('deleteByCondition(): Список пуст!');
    exit;
  end;
  
  p := x.first;
  repeat
    next_p := p^.next;
    if F(p^.info) then
      deleteElement(x, p);
    
    p := next_p;
  until (p = x.last);
  
  if F(x.last^.info) then deleteElement(x, x.last);
end;

end.