program Lab_7;

type
  TypeFile = file of char;
  Resault = (Done, Error, NotFound);

var
//  num: char;
  nomer_elem: integer;
  found: boolean;
  res: Resault;

procedure txt_Type(input_fl_name, type_fl_name: string);
var
  n: char;
//  x: integer;
  type_fl: TypeFile;
  in_fl: TextFile;
begin
  AssignFile(in_fl, input_fl_name);
  Reset(in_fl);
  AssignFile(type_fl, type_fl_name);
  Rewrite(type_fl);
//  x := 0;
  while not Eof(in_fl) do
  begin
    read(in_fl, n);
    if n in ['a'..'z'] then
    begin
      write(type_fl, n);
//      x += 1;
    end;
  end;
  Closefile(in_fl);
  CloseFile(type_fl);
end;


procedure fnd(output_fl_name: string; var num_el: integer; var exist: boolean);
var
  pos: integer;
  el: char;
  local_fl: TypeFile;
begin
  AssignFile(local_fl, output_fl_name);
  Reset(local_fl);
  pos := FileSize(local_fl) - 1;
  exist := false;
  num_el := 0;
  while (pos >= 0) and not exist do
  begin
    Seek(local_fl, pos);
    read(local_fl, el);
    if (el = 'b') or (el = 'r') then
    begin
      exist := true;
//      num := el;
      num_el := pos;
    end
    else
      pos -= 1;
  end;
  CloseFile(local_fl);
end;


function plus_El(output_fl_name: string; cnt: integer; exist: boolean): Resault;
var
  out_fl: TypeFile;
  count: integer;
  j: char;
  BorR: char;
begin
  if exist = false then plus_El := NotFound
  else
  begin
    AssignFile(out_fl, output_fl_name);
    Reset(out_fl);
    count := FileSize(out_fl);
    if (cnt < 0) or (cnt > count) then plus_El := Error
    else
    begin
      Seek(out_fl, count);
      write(out_fl, ' ');
      Seek(out_fl, cnt);
      read(out_fl, BorR);
      for i: integer := cnt - 1 downto 0 do
      begin
        Seek(out_fl, i);
        read(out_fl, j);
        Seek(out_fl, i + 1);
        write(out_fl, j);
      end;
      Seek(out_fl, 0);
      write(out_fl, BorR);
      Closefile(out_fl);
      plus_El := Done;
    end;
  end;
end;


begin
  if ParamCount < 2 then writeln('Недостаточно параметров')
  else
  begin
    if not FileExists(ParamStr(1)) then writeln('Невозможно открыть входной файл')
    else
    begin
      txt_Type(ParamStr(1), ParamStr(2));
      fnd(ParamStr(2), nomer_elem, found);
      res := plus_El(ParamStr(2), nomer_elem, found);
      if res = Error then writeln('Ошибка в параметрах')
      else if res = NotFound then writeln('В файле нет символов "b" или "r"')
      else writeln('Успешное выполнение');
    end;
  end;
end.