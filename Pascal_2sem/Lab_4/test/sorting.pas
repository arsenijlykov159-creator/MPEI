unit sorting;

interface

procedure sort(input_file_name, output_file_name: string);


implementation

procedure sort(input_file_name, output_file_name: string);
const
  sup_1 = 'file__1.txt';
  sup_2 = 'file__2.txt';
var
  input_file, output_file: TextFile;
  file_1, file_2: TextFile;
  element: Integer;
  num: boolean;
  n: Integer := 1;
  i: Integer;
  s: Integer;
  i_1: Integer;
  i_2: Integer;
  e1, e2: Integer;
  eof_1, eof_2: boolean;
  a, b: boolean;
begin

  repeat
    
    s := 0;
    num := true;
    i := 0;
    
    AssignFile(input_file, input_file_name);
    Reset(input_file);
    AssignFile(file_1, sup_1);
    Rewrite(file_1);
    AssignFile(file_2, sup_2);
    Rewrite(file_2);
    
    while (not eof(input_file)) do
    begin
      readln(input_file, element);
      if (num) then writeln(file_1, element)
      else writeln(file_2, element);
      i += 1;
      //      writeln(element);
      if (i >= n) then
      begin
        num := not num;
        i := 0;
        s += 1;
      end;
    end;
    //    writeln(s);
    CloseFile(file_1);
    CloseFile(file_2);
    CloseFile(input_file);
    
    //        if (s = 1) then break;
    
    AssignFile(output_file, output_file_name);
    Rewrite(output_file);
    AssignFile(file_1, sup_1);
    Reset(file_1);
    AssignFile(file_2, sup_2);
    Reset(file_2);
    
    if (not eof(file_1)) then readln(file_1, e1);
    if (not eof(file_2)) then readln(file_2, e2);
    while (not eof(file_1) or not eof(file_2)) do
    begin
      i_1 := 0;
      i_2 := 0;
      
      while (i_1 < n) and (i_2 < n) and not eof(file_1) and not eof(file_2) do
      begin
        if (e1 <= e2) then
        begin
          writeln(output_file, e1);
          i_1 += 1;
          
          if (not eof(file_1)) then readln(file_1, e1);
        end
        else
        begin
          writeln(output_file, e2);
          i_2 += 1;
          
          if (not eof(file_2)) then readln(file_2, e2);
        end;
      end;
      
      eof_1 := eof(file_1);
      while (i_1 < n) and not eof(file_1) do
      begin
        writeln(output_file, e1);
        i_1 += 1;
        readln(file_1, e1);
      end;
      
      eof_2 := eof(file_2);
      while (i_2 < n) and not eof(file_2) do
      begin
        writeln(output_file, e2);
        i_2 += 1;
        readln(file_2, e2);
      end;
      
      i_1 := 0;
      i_2 := 0;
    end;
    
    if (not eof_1) then writeln(output_file, e1);
    
    while (not eof(file_1)) do
    begin
      readln(file_1, e1);
      writeln(output_file, e1);
    end;
    
    if (not eof_2) then writeln(output_file, e2);
    
    while (not eof(file_2)) do
    begin
      readln(file_2, e2);
      writeln(output_file, e2);
    end;
    
    CloseFile(file_1);
    CloseFile(file_2);
    CloseFile(output_file);
    
    n *= 2;
    input_file_name := output_file_name;
    
  until s <= 1;
  
end;

end.