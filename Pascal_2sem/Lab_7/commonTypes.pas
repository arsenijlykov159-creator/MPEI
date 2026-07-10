unit commonTypes;

interface

type
  TInfo = Integer;
  
  PElement = ^TElement;
  
  TElement = record
    info: TInfo;
    top, left, right: PElement;
  end;
  
  BTree = record
    peak: PElement;
  end;
  
  searchFunction = function(x: TInfo): boolean;
  function func(x: TInfo): boolean;
  
implementation

function func(x: TInfo): boolean;
begin
  result := ((x >= -10) and (x <= 30));
end;

end.