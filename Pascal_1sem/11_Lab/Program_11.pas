program Lab_11;

var
  eps, fake_eps: real;
  a_1, b_1, a_2, b_2: real;
  k: integer;
  answer_1, answer_2, answer_3: real;


function initialFunction_1(x: real): real;
begin
  result := 1 / ((6*sin(x))/(5*cos(x)) + sqrt(x+1)) - x;
end;
function initialFunction_2(x: real): real;
begin
  result := 1 / (x * sqrt(x+0.3) + exp(-x) + 1/7) - x;
end;


function simpleIterations(f: function(x: real): real; const left, right, epsilon: real): real;
var
  x_0, current_x_1, current_x_2: real;
  lmd: real;
  i: integer;
begin
  x_0 := (right + left)/2;
  lmd := 0.8;
  i := 0;
  repeat
    current_x_1 := x_0;
    current_x_2 := lmd * f(current_x_1) + current_x_1;
    x_0 := current_x_2;
    i := i + 1;
  until (abs(current_x_2 - current_x_1) < epsilon) or (i > 1000000);
  result := current_x_2;
end;

function secants(f: function(x: real): real; const left, right, epsilon: real): real;
var
  x_1, x_2, x_3: real;
  i: integer;
begin
  x_1 := left;
  x_2 := right;
  i := 0;
  repeat
//    if f(x_2) - f(x_1) <> 0 then
    x_3 := x_2 - (f(x_2) * (x_2 - x_1) / (f(x_2) - f(x_1)));
    x_1 := x_2;
    x_2 := x_3;
    i := i + 1;
  until (abs(x_2 - x_1) < epsilon) or (i > 100000);
  result := x_2;
end;

function methodOfNewton(f: function(x: real): real; const left, right, epsilon: real): real;
var
  x_0: real;
  x_1: real;
  i: integer;
  
function derivative(f: function(x: real): real; const x, e: real): real;
begin
  result := (f(x + e/2) - f(x - e/2)) / e;
end;
begin
  i := 0;
  x_1 := (right + left) / 2;
  repeat
    x_0 := x_1;
//    if derivative(f, x_0, epsilon) > 0 then
    x_1 := x_0 - (f(x_0) / derivative(f, x_0, epsilon));
    i := i + 1;
  until (abs(x_1 - x_0) < epsilon) or (i > 10000);
  result := x_1;
end;


begin
  read(eps);
  k := 0;
  fake_eps := eps;
  while (fake_eps < 1) do
  begin
    fake_eps := fake_eps * 10;
    k := k + 1;
  end;
  
  read(a_1, b_1);
  answer_1 := simpleIterations(initialFunction_1, a_1, b_1, eps);
  answer_2 := secants(initialFunction_1, a_1, b_1, eps);
  answer_3 := methodOfNewton(initialFunction_1, a_1, b_1, eps);
  writeln('1: ', answer_1:10:(k+1), ', 2: ', answer_2:10:(k+1), ', 3: ', answer_3:10:(k+1));
  writeln('1: ', initialFunction_1(answer_1), ', 2: ', initialFunction_1(answer_2), ', 3: ', initialFunction_1(answer_3));
  
  read(a_2, b_2);
  answer_1 := simpleIterations(initialFunction_2, a_2, b_2, eps);
  answer_2 := secants(initialFunction_2, a_2, b_2, eps);
  answer_3 := methodOfNewton(initialFunction_2, a_2, b_2, eps);
  writeln('1: ', answer_1:10:(k+1), ', 2: ', answer_2:10:(k+1), ', 3: ', answer_3:10:(k+1));
  writeln('1: ', initialFunction_2(answer_1), ', 2: ', initialFunction_2(answer_2), ', 3: ', initialFunction_2(answer_3));
end.