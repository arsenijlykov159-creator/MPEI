unit dequeRealization;

interface

//uses listDeque;
uses arrayDeque;

procedure getDequeFromFile(var fl: TextFile; var d: deque);
function outputDeque(var fl: TextFile; var d: deque): boolean;
procedure deleteDequeByCondition(var d: deque; F: function(x: TInfo): boolean);


implementation


procedure getDequeFromFile(var fl: TextFile; var d: deque);
var
  addTo: boolean;
var
  element: TInfo;
begin
  addTo := false;
  
  while (not eof(fl)) do
  begin
    read(fl, element);
    if (addTo) then pushToHead(d, element)
    else pushToTail(d, element);
    addTo := not addTo;
  end;
end;


function outputDeque(var fl: TextFile; var d: deque): boolean;
var
  temp_d: deque;
  element: TInfo;
begin
  If (isDequeEmpty(d)) then
  begin
    result := false;
    exit;
  end;
  
  initDeque(temp_d);
  while (not isDequeEmpty(d)) do
  begin
    popFromHead(d, element);
    write(fl, element, ' ');
    pushToTail(temp_d, element);
  end;
  
  while (not isDequeEmpty(temp_d)) do
  begin
    popFromHead(temp_d, element);
    pushToTail(d, element);
  end;
  writeln(fl);
  result := true;
end;


procedure deleteDequeByCondition(var d: deque; F: function(x: TInfo): boolean);
var
  temp_d: deque;
  temp_head, temp_tail: TInfo;
begin
  if (isDequeEmpty(d)) then exit;
  
  initDeque(temp_d);
  
  while (not isDequeEmpty(d)) do
  begin
    popFromHead(d, temp_head);
    
    if (isDequeEmpty(d)) then 
    begin
      pushToHead(temp_d, temp_head);
      break;
    end;
    
    popFromTail(d, temp_tail);

    if (not (F(temp_head) and F(temp_tail))) then
    begin
      pushToHead(temp_d, temp_head);
      pushToTail(temp_d, temp_tail);
    end;
  end;
  
//  outputDeque(temp_d);
  while (not isDequeEmpty(temp_d)) do
  begin
    popFromHead(temp_d, temp_head);
    if (not isDequeEmpty(temp_d)) then popFromTail(temp_d, temp_tail);
    pushToHead(d, temp_head);
    if (not isDequeEmpty(temp_d)) then pushToTail(d, temp_tail);
  end;
end;
  
  
end.