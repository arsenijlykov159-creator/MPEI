unit arrayQueue;

interface

type
  TInfo = Integer;
  queue = array of TInfo;
  
  
procedure initQueue(var q: queue);
function isQueueEmpty(const q: queue): boolean;
procedure enqueue(var q: queue; const element: TInfo);
function dequeue(var q: queue; var element: TInfo): boolean;
function deleteQueue(var q: queue): boolean;


implementation


procedure initQueue(var q: queue);
begin
  SetLength(q, 0);
end;


function isQueueEmpty(const q: queue): boolean;
begin
  result := (Length(q) = 0);
end;


procedure enqueue(var q: queue; const element: TInfo);
begin
  if (isQueueEmpty(q)) then
  begin
    SetLength(q, 1);
    q[0] := element;
    exit;
  end;
  
  SetLength(q, Length(q) + 1);
  q[High(q)] := element;
end;


function dequeue(var q: queue; var element: TInfo): boolean;
begin
  if (isQueueEmpty(q)) then
  begin
    result := false;
    exit;
  end;
  
  element := q[0];
  for i: Integer := 0 to High(q) - 1 do
    q[i] := q[i + 1];
  SetLength(q, Length(q) - 1);
  result := true;
end;


function deleteQueue(var q: queue): boolean;
begin
  if (isQueueEmpty(q)) then
  begin
    result := false;
    exit;
  end;
  
  SetLength(q, 0);
  result := true;
end;


end.