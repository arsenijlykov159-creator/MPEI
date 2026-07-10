unit queueRealization;

interface

uses listQueue;
//uses arrayQueue;

procedure getQueueFromFile(var fl: TextFile; var q: queue);
function outputQueue(var fl: TextFile; var q: queue): boolean;
procedure deleteQueueByCondition(var q: queue; F: function(x: TInfo): boolean);


implementation


procedure getQueueFromFile(var fl: TextFile; var q: queue);
var
  element: TInfo;
begin
  while (not eof(fl)) do
  begin
    read(fl, element);
    enqueue(q, element);
  end;
end;


function outputQueue(var fl: TextFile; var q: queue): boolean;
var
  temp_q: queue;
  element: TInfo;
begin
  If (isQueueEmpty(q)) then
  begin
    result := false;
    exit;
  end;
  
  initQueue(temp_q);
  while (not isQueueEmpty(q)) do
  begin
    dequeue(q, element);
    write(fl, element, ' ');
    enqueue(temp_q, element);
  end;
  
  while (not isQueueEmpty(temp_q)) do
  begin
    dequeue(temp_q, element);
    enqueue(q, element);
  end;
  writeln(fl);
  result := true;
end;


procedure deleteQueueByCondition(var q: queue; F: function(x: TInfo): boolean);
var
  temp_q: queue;
  temp: TInfo;
begin
  initQueue(temp_q);
  
  while (not isQueueEmpty(q)) do
  begin
    dequeue(q, temp);
    if (not F(temp)) then enqueue(temp_q, temp);
  end;
  
  while (not isQueueEmpty(temp_q)) do
  begin
    dequeue(temp_q, temp);
    enqueue(q, temp);
  end;
end;
  
  
end.