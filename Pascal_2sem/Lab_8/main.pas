program main;

//uses listStack;
uses arrayStack;
uses stackRealization;
uses listQueue;
//uses arrayQueue;
uses queueRealization;
//uses listDeque;
uses arrayDeque;
uses dequeRealization;


function searchFunction(x: TInfo): boolean;
begin
  result := (x >= -10) and (x <= 30);
end;

var
  input_file, output_file: TextFile;
  s: stack;
  q: queue;
  d: deque;
  e: TInfo;
  
begin
  
  if (ParamCount < 2) then 
  begin
    writeln('Недостаточно праметров');
    exit;
  end;
  
  if (not FileExists(ParamStr(1))) then
  begin
    writeln('Невозможно открыть входной файл для чтения');
    exit;
  end;
  
  AssignFile(input_file, ParamStr(1));
  Reset(input_file);
  AssignFile(output_file, ParamStr(2));
  Rewrite(output_file);
  
  initStack(s);
  if (not outputStack(output_file, s)) then writeln(output_file, 'outputStack(s): Структура пуста');
  
  //ввести данные в стек
  getStackFromFile(input_file, s);
  if (not outputStack(output_file, s)) then writeln(output_file, 'outputStack(s): Структура пуста');
  
  //добавить в стек несколько элементов
  push(s, 0);
  push(s, 12);
  if (not outputStack(output_file, s)) then writeln(output_file, 'outputStack(s): Структура пуста');
  
  //удалить из стека несколько элементов
  pop(s, e);
  pop(s, e);
  pop(s, e);
  pop(s, e);
  if (not outputStack(output_file, s)) then writeln(output_file, 'outputStack(s): Структура пуста');
  
  //удалить из стека элементы по заданному условию
  deleteStackByCondition(s, searchFunction);
  if (not outputStack(output_file, s)) then writeln(output_file, 'outputStack(s): Структура пуста');
  
  deleteStack(s);
  if (not outputStack(output_file, s)) then writeln(output_file, 'outputStack(s): Структура пуста');
  
  CloseFile(input_file);
  
  writeln(output_file, '-----------------------------------------');
  
  AssignFile(input_file, ParamStr(1));
  Reset(input_file);
  
  initQueue(q);
  if (not outputQueue(output_file, q)) then writeln(output_file, 'outputQueue(s): Структура пуста');
  
  //ввести данные в очередь (те же значения из того же файла)
  getQueueFromFile(input_file, q);
  if (not outputQueue(output_file, q)) then writeln(output_file, 'outputQueue(s): Структура пуста');
  
  //добавить в очередь несколько элементов
  enqueue(q, 0);
  enqueue(q, 12);
  if (not outputQueue(output_file, q)) then writeln(output_file, 'outputQueue(s): Структура пуста');
  
  //удалить из очереди несколько элементов
  dequeue(q, e);
  dequeue(q, e);
  dequeue(q, e);
  dequeue(q, e);
  if (not outputQueue(output_file, q)) then writeln(output_file, 'outputQueue(s): Структура пуста');
  
  //удалить из очереди элементы по заданному условию
  deleteQueueByCondition(q, searchFunction);
  if (not outputQueue(output_file, q)) then writeln(output_file, 'outputQueue(s): Структура пуста');
  
  deleteQueue(q);
  if (not outputQueue(output_file, q)) then writeln(output_file, 'outputQueue(s): Структура пуста');
  
  CloseFile(input_file);
  
  writeln(isQueueEmpty(q));
  
  writeln(output_file, '-----------------------------------------');
  
  AssignFile(input_file, ParamStr(1));
  Reset(input_file);
  
  initDeque(d);
  if (not outputDeque(output_file, d)) then writeln(output_file, 'outputDeque(s): Структура пуста');
  
  //ввести данные в дек 
  getDequeFromFile(input_file, d);
  if (not outputDeque(output_file, d)) then writeln(output_file, 'outputDeque(s): Структура пуста');
  
  //добавить несколько элементов в начало дека и несколько элементов в конец дека
  pushToHead(d, 1);
  pushToHead(d, 0);
  pushToTail(d, 1);
  pushToTail(d, 0);
  if (not outputDeque(output_file, d)) then writeln(output_file, 'outputDeque(s): Структура пуста');
  
  //удалить из дека несколько элементов из начала дека и несколько элементов с конца дека
  popFromHead(d, e);
  popFromHead(d, e);
  popFromHead(d, e);
  popFromHead(d, e);
  popFromTail(d, e);
  popFromTail(d, e);
  popFromTail(d, e);
  popFromTail(d, e);
  if (not outputDeque(output_file, d)) then writeln(output_file, 'outputDeque(s): Структура пуста');
  
  //удалить из дека элементы по заданному условию
  deleteDequeByCondition(d, searchFunction);
  if (not outputDeque(output_file, d)) then writeln(output_file, 'outputDeque(s): Структура пуста');
  
  deleteDeque(d);
  if (not outputDeque(output_file, d)) then writeln(output_file, 'outputDeque(s): Структура пуста');
  
  CloseFile(input_file);
  CloseFile(output_file);
  
end.