program Lab_7;

uses commonTypes;
uses binaryTree;


var
  fl: TextFile;
  tree: PElement;
  n: PElement;
  lvl: Integer;
  
begin
  
  if (ParamCount < 2) then
  begin
    writeln('Недостаточно параметров');
    exit;
  end;
  
  if (not FileExists(ParamStr(1))) then
  begin
    writeln('Невозможно открыть входной файл для чтения');
    exit;
  end;
  
  AssignFile(fl, ParamStr(1));
  Reset(fl);
  tree := getTreeFromFile(fl);
  CloseFile(fl);

  AssignFile(fl, ParamStr(2));
  Rewrite(fl);
  
  outputTree(fl, tree, 0);
  writeln(fl, '----------------------------------');
  
  searchNode(tree, -6, n, lvl);
  addRight(n, 1000);
  addLeft(n, 1111);
  outputTree(fl, tree, 0);
  
  writeln(fl, '----------------------------------');
  
  deleteSubTree(tree, 7);
  outputTree(fl, tree, 0);
  
  writeln(fl, '----------------------------------');
  
  writeln(fl, matchPeakCount(tree, func));
  
  CloseFile(fl);
end.