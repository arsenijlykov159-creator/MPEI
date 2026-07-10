unit arrayDeque;

interface

type
  TInfo = Integer;
  deque = array of TInfo;
  
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
  SetLength(d, 0);
end;


function isDequeEmpty(const d: deque): boolean;
begin
  result := (Length(d) = 0);
end;


procedure pushToHead(var d: deque; const element: TInfo);
begin
  if (isDequeEmpty(d)) then
  begin
    SetLength(d, 1);
    d[0] := element;
    exit;
  end;
  
  SetLength(d, Length(d) + 1);
  for i: Integer := High(d) downto 1 do
    d[i] := d[i - 1];
  d[0] := element;
end;


procedure pushToTail(var d: deque; const element: TInfo);
begin
  SetLength(d, Length(d) + 1);
  d[High(d)] := element;
end;


function popFromHead(var d: deque; var element: TInfo): boolean;
begin
  if (isDequeEmpty(d)) then
  begin
    result := false;
    exit;
  end;
  
  element := d[0];
  for i: Integer := 0 to High(d) - 1 do
    d[i] := d[i + 1];
  SetLength(d, Length(d) - 1);
  result := true;
end;


function popFromTail(var d: deque; var element: TInfo): boolean;
begin
  if (isDequeEmpty(d)) then
  begin
    result := false;
    exit;
  end;
  
  element := d[High(d)];
  SetLength(d, Length(d) - 1);
  result := true;
end;


function deleteDeque(var d: deque): boolean;
begin
  if (isDequeEmpty(d)) then
  begin
    result := false;
    exit;
  end;
  
  SetLength(d, 0);
  result := true;
end;

end.