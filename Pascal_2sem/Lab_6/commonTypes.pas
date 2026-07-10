unit commonTypes;

interface

type
  TInfo = Integer;
  searchFunction = function(x: TInfo): boolean;
  
function Func(x: TInfo): boolean;
  

implementation

function Func(x: TInfo): boolean;
begin
  result := ((x >= -10) and (x <= 30));
end;

end.