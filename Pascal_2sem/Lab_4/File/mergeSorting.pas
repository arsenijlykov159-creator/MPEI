unit mergeSorting;

interface

procedure directSorting(input_file_name, output_file_name: string);
procedure naturalSorting(input_file_name, output_file_name: string);
function isSorted(fl_name: string): boolean;

implementation

function isSorted(fl_name: string): boolean;
var
  i, j: Integer;
  fl: TextFile;
begin
  
  AssignFile(fl, fl_name);
  Reset(fl);
  
  readln(fl, i);
  while (not eof(fl)) do
  begin
    readln(fl, j);
    if (i > j) then
    begin
      result := false;
      exit;
    end;
    
    i := j;
  end;
  
  result := true;
  CloseFile(fl);
end;


procedure directSorting(input_file_name, output_file_name: string);
const
  file_1_name = 'test____1.txt';
  file_2_name = 'test____2.txt';
var
  input_file, output_file, file_1, file_2: TextFile;
  element, element_1, element_2: Integer;
  n: Integer := 1;
  isEnd_1, isEnd_2: boolean;
  number: boolean;
  i: Integer;
  series: Integer;
  i_1, i_2: Integer;
begin
  
  repeat
    series := 0;
    number := true;
    
    AssignFile(input_file, input_file_name);
    Reset(input_file);
    AssignFile(file_1, file_1_name);
    Rewrite(file_1);
    AssignFile(file_2, file_2_name);
    Rewrite(file_2);
    
    i := 0;
    while (not eof(input_file) and (i < n)) do
    begin
      readln(input_file, element);
      if (number) then writeln(file_1, element)
      else writeln(file_2, element);
      
      i += 1;
      
      if (i = n) then
      begin
        i := 0;
        series += 1;
        number := not number;
      end;
    end;
    
    CloseFile(input_file);
    CloseFile(file_1);
    CloseFile(file_2);
    
    AssignFile(output_file, output_file_name);
    Rewrite(output_file);
    AssignFile(file_1, file_1_name);
    Reset(file_1);
    AssignFile(file_2, file_2_name);
    Reset(file_2);
    
    readln(file_1, element_1);
    readln(file_2, element_2);
    isEnd_1 := false;
    isEnd_2 := false;
    while (not isEnd_1 or not isEnd_2) do
    begin
      
      i_1 := 0;
      i_2 := 0;
      while (i_1 < n) and (i_2 < n) and not isEnd_1 and not isEnd_2 do
      begin
        if (element_1 <= element_2) then
        begin
          writeln(output_file, element_1);
          i_1 += 1;
          
          isEnd_1 := eof(file_1);
          if (not isEnd_1) then readln(file_1, element_1);
        end
        else
        begin
          writeln(output_file, element_2);
          i_2 += 1;
          
          isEnd_2 := eof(file_2);
          if (not isEnd_2) then readln(file_2, element_2);
        end;
      end;
      
      while (i_1 < n) and not isEnd_1 do
      begin
        writeln(output_file, element_1);
        i_1 += 1;
        
        isEnd_1 := eof(file_1);
        if (not isEnd_1) then readln(file_1, element_1);
      end;
      
      while (i_2 < n) and not isEnd_2 do
      begin
        writeln(output_file, element_2);
        i_2 += 1;
        
        isEnd_2 := eof(file_2);
        if (not isEnd_2) then readln(file_2, element_2);
      end;
    end;
    
    CloseFile(output_file);
    CloseFile(file_1);
    CloseFile(file_2);
    DeleteFile(file_1_name);
    DeleteFile(file_2_name);
    
    n *= 2;
    input_file_name := output_file_name;
    
  until series <= 1;
  
end;


procedure naturalSorting(input_file_name, output_file_name: string);
const
  file_1_name = 'file______1.txt';
  file_2_name = 'file______2.txt';
var
  input_file, output_file, file_1, file_2: TextFile;
  element, previous_element: Integer;
  number: boolean;
  series: Integer;
  element_1, element_2, new_element_1, new_element_2: Integer;
  isSerieContinue_1, isSerieContinue_2: boolean;
  isFile1End, isFile2End: boolean;
begin
  
  repeat
    
    AssignFile(input_file, input_file_name);
    Reset(input_file);
    AssignFile(file_1, file_1_name);
    Rewrite(file_1);
    AssignFile(file_2, file_2_name);
    Rewrite(file_2);
    
    series := 0;
    number := true;
    
    readln(input_file, previous_element);
    writeln(file_1, previous_element);
    while (not eof(input_file)) do
    begin
      readln(input_file, element);
      
      if (previous_element >= element) then
      begin
        number := not number;
        series += 1;
      end;
      
      if (number) then writeln(file_1, element)
      else writeln(file_2, element);
      
      previous_element := element;

    end;
    
    series += 1;
    CloseFile(input_file);
    CloseFile(file_1);
    CloseFile(file_2);
    
    AssignFile(output_file, output_file_name);
    Rewrite(output_file);
    AssignFile(file_1, file_1_name);
    Reset(file_1);
    AssignFile(file_2, file_2_name);
    Reset(file_2);
    
    if (not eof(file_1)) then readln(file_1, element_1);
    if (not eof(file_2)) then readln(file_2, element_2);
    isFile1End := eof(file_1);
    isFile2End := eof(file_2);
    while (not isFile1End and not isFile2End) do
    begin
      
      isSerieContinue_1 := true;
      isSerieContinue_2 := true;
      while (isSerieContinue_1 and isSerieContinue_2) do
      begin
        if (element_1 < element_2) then
        begin
          writeln(output_file, element_1);
          isFile1End := eof(file_1);
          if (not isFile1End) then
          begin
            readln(file_1, new_element_1);
            if (element_1 > new_element_1) then isSerieContinue_1 := false
            else element_1 := new_element_1;
          end
          else isSerieContinue_1 := false;
        end
        else
        begin
          writeln(output_file, element_2);
          isFile2End := eof(file_2);
          if (not isFile2End) then
          begin
            readln(file_2, new_element_2);
            if (element_2 > new_element_2) then isSerieContinue_2 := false
            else element_2 := new_element_2;
          end
          else isSerieContinue_2 := false;
        end;
        
      end;
      
      
      
      while (isSerieContinue_1 and not isFile1End) do
      begin
        writeln(output_file, element_1);
        isFile1End := eof(file_1);
        if (not isFile1End) then readln(file_1, new_element_1);
        if (new_element_1 < element_1) then isSerieContinue_1 := false
        else element_1 := new_element_1;
      end;
      
      while (isSerieContinue_2 and not isFile2End) do
      begin
        writeln(output_file, element_2);
        isFile2End := eof(file_2);
        if (not isFile2End) then readln(file_2, new_element_2);
        if (new_element_2 < element_2) then isSerieContinue_2 := false
        else element_2 := new_element_2;
      end;
      
      element_1 := new_element_1;
      element_2 := new_element_2;
    end;
    
    while (not isFile1End) do
    begin
      writeln(output_file, element_1);
      if (eof(file_1)) then break
      else isFile1End := eof(file_1);
      if (not isFile1End) then readln(file_1, element_1);
    end;
    
    while (not isFile2End) do
    begin
      writeln(output_file, element_2);
      if (eof(file_2)) then break
      else isFile2End := eof(file_2);
      if (not isFile2End) then readln(file_2, element_2);
    end;
    
    CloseFile(output_file);
    CloseFile(file_1);
    CloseFile(file_2);
    DeleteFile(file_1_name);
    DeleteFile(file_2_name);
    
    input_file_name := output_file_name;
    
  until (series <= 1);
  
end;


end.