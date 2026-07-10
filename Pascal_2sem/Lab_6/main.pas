program main;

//{$DEFINE BIDIRECT}
//uses biDirectionalList;

{$DEFINE DIRECT}
uses directionalList;
uses commonTypes;

var
  input_fl, output_fl: TextFile;
  l: List;
  a, b: PElement;

begin
  
  if (ParamCount < 2) then
  begin
    writeln('Неверное количество входных параметров');
    exit;
  end;
  
  if (not FileExists(ParamStr(1))) then
  begin
    writeln('Невозможно открыть входной файл для чтения');
    exit;
  end;
  
  AssignFile(input_fl, ParamStr(1));
  Reset(input_fl);
  AssignFile(output_fl, ParamStr(2));
  Rewrite(output_fl);
// 1) ввести данные из файла с сохранением порядка элементов таким, какой есть в файле  
  getList(input_fl, l);
  if (not outputList(output_fl, l)) then writeln(output_fl, 'OutputList(): Список пуст!');
// 2) добавить несколько элементов в начало списка и несколько элементов в конец списка
  insertElement(l, 101);
  insertElement(l, 103);
  insertElement(l, 102, l.last);
  insertElement(l, 104, l.last);
  if (not outputList(output_fl, l)) then writeln(output_fl, 'OutputList(): Список пуст!');
// 3) найти первый (и последний) элемент по заданному условию
  searchElement(l, func, a, b);
  if (a <> nil) then write(output_fl, a^.info, ' ');
  if (b <> nil) then write(output_fl, b^.info);
  writeln(output_fl);
// 4) в однонаправленном списке добавить новый элемент после найденного, в двунаправленном списке удалить найденные элементы
  {$ifdef BIDIRECT}
  deleteElement(l, a);
  deleteElement(l, b);
  {$endif}
  {$ifdef DIRECT}
  insertElement(l, a^.info + 10, a);
  {$endif}
  if (not outputList(output_fl, l)) then writeln(output_fl, 'OutputList(): Список пуст!');
// 5) удалить элементы из списка по заданному условию
  deleteByCondition(l, func);
  if (not outputList(output_fl, l)) then writeln(output_fl, 'OutputList(): Список пуст!');
// 6) удалить список
  deleteList(l);
  if (not outputList(output_fl, l)) then writeln(output_fl, 'OutputList(): Список пуст!');
  
  CloseFile(input_fl);
  writeln(output_fl, '--------------------------------------------------------------------------------------------------------');
  AssignFile(input_fl, ParamStr(1));
  Reset(input_fl);
// 7) ввести данные из файла, добавляя элементы в список так, чтобы создавался порядок, указанный в задании
  getListByOrder(input_fl, l);
  if (not outputList(output_fl, l)) then writeln(output_fl, 'OutputList(): Список пуст!');
// 8) найти первый (и последний) элемент по заданному условию
  searchElement(l, func, a, b);
  if (a <> nil) then write(output_fl, a^.info, ' ');
  if (b <> nil) then writeln(output_fl, b^.info)
  else writeln(output_fl, '-');
// 9) удалить элементы из списка по заданному условию
  deleteByCondition(l, func);
  if (not outputList(output_fl, l)) then writeln(output_fl, 'OutputList(): Список пуст!');
// 10) удалить список
  deleteList(l);
  if (not outputList(output_fl, l)) then writeln(output_fl, 'OutputList(): Список пуст!');
  
  CloseFile(input_fl);
  CloseFile(output_fl);
  
end.