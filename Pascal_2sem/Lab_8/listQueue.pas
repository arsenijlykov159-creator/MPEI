unit listQueue;

interface

type
  TInfo = Integer;

  PElement = ^TElement;
  
  TElement = record
    info: TInfo;
    next: PElement;
  end;
  
  queue = record
    head: PElement; //первые на выход
    tail: PElement; //только что пришли
  end;
  
procedure initQueue(var q: queue);
function isQueueEmpty(const q: queue): boolean;
procedure enqueue(var q: queue; const element: TInfo);
function dequeue(var q: queue; var element: TInfo): boolean;
function deleteQueue(var q: queue): boolean;


implementation

procedure initQueue(var q: queue);
begin
  q.tail := nil;
  q.head := nil;
end;


function isQueueEmpty(const q: queue): boolean;
begin
  result := (q.tail = nil);
end;


procedure enqueue(var q: queue; const element: TInfo);
var
  p: PElement;
begin
  new(p);
  p^.info := element;
  p^.next := nil;
  
  if (isQueueEmpty(q)) then
  begin
    q.head := p;
    q.tail := p;
  end
  else
  begin
    q.tail^.next := p;
    q.tail := p;
  end;
end;


function dequeue(var q: queue; var element: TInfo): boolean;
var
  p: PElement;
begin
  if (isQueueEmpty(q)) then 
  begin
    result := false;
    exit;
  end;
  
  p := q.head;
  element := p^.info;
  q.head := p^.next;
  if (q.head = nil) then q.tail := nil;
  dispose(p);
  result := true;
end;


function deleteQueue(var q: queue): boolean;
var
  p: PElement;
begin
  if (isQueueEmpty(q)) then 
  begin
    result := false;
    exit;
  end;
  
  while (q.head <> nil) do
  begin
    p := q.head;
    q.head := q.head^.next;
    dispose(p);
  end;
  q.tail := nil;
  result := true;
end;


end.