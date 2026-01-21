program Stroki;

var
  d, st: string;
  cnt, len: Integer;
  i, j, m, n, k, l, el, ch, it: Integer;
  sp1: array[1..50] of Integer;
  sp2: array[1..50] of string;
  itog: string;
  fl: TextFile;

begin
  AssignFile(fl, 'input.txt');
  Reset(fl);
  
  while not eof(fl) do
  begin
    readln(fl, d);
  end;
  
  len := length(d);
  cnt := 1;
  for i := 1 to len - 1 do
    if (d[i] <> ' ') and (d[i + 1] = ' ') then
      cnt := cnt + 1;
  
  for j := 1 to len - 1 do
    if d[j] <> ' ' then
      Insert(d[j], st, j)
    else if (d[j] = ' ') and (d[j + 1] <> ' ') then
      Insert('*', st, j);
  Insert(d[len], st, len);
  Insert('*', st, len + 1);
  st := '*' + st;
  
  k := 1;
  for m := 1 to length(st) do
    if st[m] = '*' then
    begin
      sp1[k] := m;
      k := k + 1;
    end;
    st := st + '*';
  l := 1;
  for n := 1 to cnt do
  begin
    sp2[l] := st[sp1[n]+1 : sp1[n + 1]];
    l := l + 1;
  end;
  
  for el := 1 to cnt do
  begin
    sp2[el] := sp2[el] + sp2[((cnt + 1) div 2) + el];
  end;
  
   if cnt mod 2 = 0 then
     for ch := cnt div 2 + 1 to cnt do
       sp2[ch] := ''
   else if cnt mod 2 <> 0 then
     for ch := cnt div 2 + 2 to cnt do
       sp2[ch] := '';
   
   for it := 1 to cnt do
     itog := itog + sp2[it] + ' ';
    
  writeln(itog);
end.