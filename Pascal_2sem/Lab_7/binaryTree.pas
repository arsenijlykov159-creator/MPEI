unit binaryTree;

interface

uses commonTypes;

procedure addPeak(var t: BTree; const element: TInfo);
procedure addLeft(var x: PElement; const element: TInfo);
procedure addRight(var x: PElement; const element: TInfo);
procedure searchNode(const t: PElement; info: TInfo; var node: PElement; var level: Integer);
function deleteLeaf(var t: PElement; info: TInfo): boolean;

function isTreeEmpty(const t: BTree): boolean;
function lowestCommonAncestor(const t: BTree; const a, b: PElement): PElement;

function getTreeFromFile(var f: TextFile): PElement;
procedure outputTree(var f: TextFile; node: PElement; level: Integer);
procedure deleteSubTree(var t: PElement; const element: TInfo);
procedure deleteTree(var t: PElement);
function matchPeakCount(var t: PElement; F: searchFunction): Integer;


implementation

function isTreeEmpty(const t: BTree): boolean;
begin
  result := (t.peak = nil);
end;


procedure addPeak(var t: BTree; const element: TInfo);
var
  p: PElement;
begin
  new(p);
  p^.info := element;
  t.peak := p;
  t.peak^.top := nil;
  t.peak^.left := nil;
  t.peak^.right := nil;
end;


procedure addLeft(var x: PElement; const element: TInfo);
var
  p: PElement;
begin
  if (x = nil) then exit;
  if (x^.left <> nil) then exit;
  
  new(p);
  p^.info := element;
  p^.top := x;
  x^.left := p;
end;


procedure addRight(var x: PElement; const element: TInfo);
var
  p: PElement;
begin
  if (x = nil) then exit;
  if (x^.right <> nil) then exit;
  
  new(p);
  p^.info := element;
  p^.top := x;
  x^.right := p;
end;


function lowestCommonAncestor(const t: BTree; const a, b: PElement): PElement;
var
  deep_a: Integer := 0;
  deep_b: Integer := 0;
  node_a: PElement := a;
  node_b: PElement := b;
begin
  if (a^.info = b^.info) then 
  begin
    result := a;
    exit;
  end;
  
  while (node_a <> t.peak) do
  begin
    node_a := node_a^.top;
    deep_a += 1;
  end;
  
  while (node_b <> t.peak) do
  begin
    node_b := node_b^.top;
    deep_b += 1;
  end;
  
  node_a := a;
  node_b := b;
  while (deep_a > deep_b) do
  begin
    node_a := node_a^.top;
    deep_a -= 1;
  end;
  while (deep_a < deep_b) do
  begin
    node_b := node_b^.top;
    deep_b -= 1;
  end;
  
  while (node_a^.info <> node_b^.info) do
  begin
    node_a := node_a^.top;
    node_b := node_b^.top;
  end;
  
  result := node_a;
end;


procedure searchNode(const t: PElement; info: TInfo; var node: PElement; var level: Integer);
begin
  if (t = nil) then exit;
  if (t^.info = info) then
  begin
    node := t;
    level := 0;
  end
  else
  begin
    if (t^.left <> nil) then searchNode(t^.left, info, node, level);
    if (t^.right <> nil) and (node = nil) then searchNode(t^.right, info, node, level);
    level += 1;
  end;
end;


function deleteLeaf(var t: PElement; info: TInfo): boolean;
begin
  if (t = nil) then 
  begin
    result := false;
    exit;
  end;
  
  if (t^.left = nil) and (t^.right = nil) and (t^.info = info) then
  begin
    if (t^.top <> nil) then
    begin
      if (t^.top^.left = t) then t^.top^.left := nil
      else t^.top^.right := nil;
    end;
    t := nil;
    dispose(t);
    result := true;
  end
  else
  begin
    if (deleteLeaf(t^.left, info)) then result := true
    else result := deleteLeaf(t^.right, info);
  end;
end;


function getTreeFromFile(var f: TextFile): PElement;
var
  element: char;
begin
  if (eof(f)) then
  begin
    result := nil;
    exit;
  end;
  
  readln(f, element);
  writeln(element);
  if (element = '*') then result := nil
  else
  begin
    new(result);
    result^.info := StrToInt(element);
  end;
  
  if (result <> nil) then
  begin
    result^.left := getTreeFromFile(f);
    result^.right := getTreeFromFile(f);
  end;
end;


procedure outputTree(var f: TextFile; node: PElement; level: Integer);
begin
  if node = nil then exit;
  
  outputTree(f, node^.right, level + 1);
  
  for i: Integer := 1 to level * 4 do
    write(f, ' ');
  writeln(f, node^.info);
  
  outputTree(f, node^.left, level + 1);
end;


procedure deleteTree(var t: PElement);
begin
  if (t = nil) then exit;
  if (t^.left <> nil) then deleteTree(t^.left);
  if (t^.right <> nil) then deleteTree(t^.right);
  dispose(t);
  t := nil;
end;


procedure deleteSubTree(var t: PElement; const element: TInfo);
begin
  if (t = nil) then exit;
  
  if (t^.info = element) then
  begin
    deleteTree(t);
    t := nil;
  end
  else
  begin
    if (t^.left <> nil) then deleteSubTree(t^.left, element);
    if (t^.right <> nil) then deleteSubTree(t^.right, element);
  end;
end;


function matchPeakCount(var t: PElement; F: searchFunction): Integer;
begin
  if (t = nil) then exit;
  
  if F(t^.info) then result += 1;
  if (t^.left <> nil) then result += matchPeakCount(t^.left, F);
  if (t^.right <> nil) then result += matchPeakCount(t^.right, F);
end;


end.