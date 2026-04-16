unit setOperations;



interface
uses commonTypes;
function combiningSets(const x, y: CharSet): CharSet;
function intersectionSets(const x, y: CharSet): CharSet;
function differenceSets(const x, y: CharSet): CharSet;
function userOperation(const x, y, z: CharSet): CharSet;



implementation

function combiningSets(const x, y: CharSet): CharSet;
begin
  for elem: char := #0 to #255 do
    if ((elem in x) or (elem in y)) then
      result := result + [elem];
end;


function intersectionSets(const x, y: CharSet): CharSet;
begin
  for elem: char := #0 to #255 do
    if ((elem in x) and (elem in y)) then
      result := result + [elem];
end;


function differenceSets(const x, y: CharSet): CharSet;
begin
  for elem: char := #0 to #255 do
    if ((elem in x) and (elem not in y)) then
      result := result + [elem];
end;


function userOperation(const x, y, z: CharSet): CharSet;
begin
  for elem: char := #0 to #255 do
    if elem in (intersectionSets(intersectionSets(x, y), differenceSets(z, y))) then
      result := result + [elem];
end;

end.