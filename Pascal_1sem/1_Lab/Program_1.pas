program LykovLab1_12;

var
  a, b, xe: real;
  xv, xn: real;

begin
  write('Введи координату центра эллипса и полуоси эллипса: ');
  read(xe, a, b);
  write('Введи верхнюю и нижнюю границу полосы: ');
  read(xv, xn);
  if (xv < -a) or (xn > a) then write('Фигуры не пересекаются')
  else if (xn = a) or (xv = -a) then write('Фигуры касаются')
  else if (xn > -a) and (xv < a) then write('Эллипс вложен в полосу')
  else write('Фигуры пересекаются')
end.