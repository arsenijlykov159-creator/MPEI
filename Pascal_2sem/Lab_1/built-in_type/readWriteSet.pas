unit readWriteSet;



interface
uses commonTypes;
procedure readSet(var fl: TextFile; var x: CharSet);
procedure writeSet(var fl: TextFile; const x: CharSet; const t: string);



implementation

procedure add(var x: CharSet; c: char);
begin
  x := x + [c];
end;

procedure readSet(var fl: TextFile; var x: CharSet);
var
  elem: char;
begin
  while not eoln(fl) do
  begin
    read(fl, elem);
    add(x, elem)
  end;
  readln(fl);
end;

procedure writeSet(var fl: TextFile; const x: CharSet; const t: string);
begin
  write(fl, t, '[');
  for elem: char := #0 to #255 do
    if elem in x then
      write(fl, elem, ' ');
  writeln(fl, ']');
end;

end.


