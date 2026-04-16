unit commonTypes_type;


interface

const
  GOOD_MARKS = [4, 5];

type
  TMarks = record
    math: Integer;
    physics: Integer;
    info: Integer;
  end;
  
  TStudents = record 
    group: string[7];
    fio: string[20];
    year: Integer;
    gender: boolean;
    marks: TMarks;
    money: Integer;
  end;
  
function keyF1(const x, y: TStudents): boolean;
function keyF2(const x, y: TStudents): boolean;

implementation

function keyF1(const x, y: TStudents): boolean;
begin
  result := (x.year < y.year);
end;

function keyF2(const x, y: TStudents): boolean;
begin
  if (x.year <> y.year) then result := (x.year < y.year)
  else if (x.fio <> y.fio) then result := (x.fio < y.fio)
  else result := (x.money < y.money);
end;

end.
