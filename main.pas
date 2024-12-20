uses
  Crt, UComplex, UMatrix, UVector, UArrayTools, UNumber;

type
  TMenuCallback = procedure;

  TMenuItems = array of record
    Name: string;
    Callback: TMenuCallback;
  end;

var
  selected: Integer = 0;
  ch: Char;

procedure ExitProgram();
begin
  Write('exit')
end;

procedure Option3();
begin
  writeln('Вы выбрали опцию 3');
end;



procedure DrawMenu(Menu: TMenuItems; Selected: Integer);
var
  i: Integer;
begin
  ClrScr;
  for i := 0 to High(Menu) do
  begin
    if i = Selected then
      TextColor(Green)
    else
      TextColor(White);
    if i = Selected then
      Write('-> ');
    Writeln(Menu[i].Name);
  end;
  TextColor(White)
end;

procedure HandleMenu(Menu: TMenuItems; var Selected: Integer);
begin
  repeat
    DrawMenu(Menu, Selected);
    ch := ReadKey;
    case ch of
      #0, #224:
        begin
          ch := ReadKey;
          case Ord(ch) of
            38:
              begin
                if Selected > 0 then
                  Dec(Selected)
                else
                  Selected := High(Menu);
              end;
            40:
              begin
                if Selected < High(Menu) then
                  Inc(Selected)
                else
                  Selected := 0;
              end;
          end;
        end;
      #13:
        begin
          if Selected = High(Menu) then
            begin
              Selected := 0;
              exit()
            end
          else
            ClrScr;
            Menu[Selected].Callback;
            ReadKey();
        end;
    end;
  until False;
end;


// complex
procedure TestAddComplex();
begin
  var a, b, result: Complex;
  writeln('Введите первое комплексное число:');
  a := ReadString();
  writeln('Введите второе комплексное число:');
  b := ReadString();
  result := a + b;
  writeln('Результат сложения: ', result);
end;

procedure TestSubComplex();
begin
  var a, b, result: Complex;
  writeln('Введите первое комплексное число:');
  a := ReadString();
  writeln('Введите второе комплексное число:');
  b := ReadString();
  result := a - b;
  writeln('Результат вычитания: ', result);
end;

procedure TestMultComplex();
begin
  var a, b, result: Complex;
  writeln('Введите первое комплексное число:');
  a := ReadString();
  writeln('Введите второе комплексное число:');
  b := ReadString();
  result := a * b;
  writeln('Результат умножения: ', result);
end;

procedure TestInvComplex();
begin
  var a, result: Complex;
  writeln('Введите комплексное число для нахождения обратного:');
  a := ReadString();
  try
    result := a.Inv();
    writeln('Обратное число: ', result);
  except
    on e: Exception do writeln('Ошибка: ', e.Message);
  end;
end;

procedure TestAbsComplex();
begin
  var a: Complex;
  writeln('Введите комплексное число для вычисления модуля:');
  a := ReadString();
  writeln('Модуль числа: ', a.Abs());
end;

procedure TestConjugateComplex();
begin
  var a, result: Complex;
  writeln('Введите комплексное число для нахождения сопряженного:');
  a := ReadString();
  result := a.Conjugate();
  writeln('Сопряженное число: ', result);
end;

procedure TestSinComplex();
begin
  var a, result: Complex;
  writeln('Введите комплексное число для вычисления синуса:');
  a := ReadString();
  result := a.sin();
  writeln('Синус числа: ', result);
end;

procedure TestCosComplex();
begin
  var a, result: Complex;
  writeln('Введите комплексное число для вычисления косинуса:');
  a := ReadString();
  result := a.cos();
  writeln('Косинус числа: ', result);
end;

procedure TestExpComplex();
begin
  var a, result: Complex;
  writeln('Введите комплексное число для вычисления экспоненты:');
  a := ReadString();
  result := a.Exp();
  writeln('Экспонента числа: ', result);
end;

procedure TestProdComplex();
begin
  var a, b, result: Number;
  writeln('Введите первое комплексное число:');
  a := ReadString();
  writeln('Введите скаляр:');
  b := ReadString();
  result := a.Prod(b);
  writeln('Результат: ', result);
end;


// Vector

procedure TestAddVector();
begin
  var a, b, result: Vector;
  writeln('Введите первый вектор (x;y;z):');
  a := ReadString();
  writeln('Введите второй вектор (x;y;z):');
  b := ReadString();
  result := a + b;
  writeln('Результат сложения: ', result);
end;

procedure TestSubVector();
begin
  var a, b, result: Vector;
  writeln('Введите первый вектор (x;y;z):');
  a := ReadString();
  writeln('Введите второй вектор (x;y;z):');
  b := ReadString();
  result := a - b;
  writeln('Результат вычитания: ', result);
end;

procedure TestDotProduct();
begin
  var a, b: Vector;
  var result: Number;
  writeln('Введите первый вектор (x;y;z):');
  a := ReadString();
  writeln('Введите второй вектор (x;y;z):');
  b := ReadString();
  result := a * b;
  writeln('Результат скалярного произведения: ', result);
end;

procedure TestCrossProduct();
begin
  var a, b, result: Vector;
  writeln('Введите первый вектор (x;y;z):');
  a := ReadString();
  writeln('Введите второй вектор (x;y;z):');
  b := ReadString();
  result := a ** b;
  writeln('Результат векторного произведения: ', result);
end;

procedure TestScalarMultiplication();
begin
  var v, result: Vector;
  var scalar: Number;
  writeln('Введите вектор (x;y;z):');
  v := ReadString();
  writeln('Введите скаляр:');
  scalar := ReadString();
  result := v * scalar;
  writeln('Результат умножения на скаляр: ', result);
end;

procedure TestMixedProduct();
begin
  var a, b, c: Vector;
  var result: Number;
  writeln('Введите первый вектор (формат: x;y;z):');
  a := ReadString();
  writeln('Введите второй вектор (формат: x;y;z):');
  b := ReadString();
  writeln('Введите третий вектор (формат: x;y;z):');
  c := ReadString();
  result := Vector.MixedProduct(a, b, c);
  writeln('Смешанное произведение векторов: ', result);
end;

procedure TestScalarDivision();
begin
  var v, result: Vector;
  var scalar: Number;
  writeln('Введите вектор (x;y;z):');
  v := ReadString();
  writeln('Введите скаляр (не равный нулю):');
  scalar := ReadString();
  result := v / scalar;
  writeln('Результат деления на скаляр: ', result);
end;

procedure TestAbsVector();
begin
  var v: Vector;
  writeln('Введите вектор (x;y;z):');
  v := ReadString();
  writeln('Модуль вектора: ', v.Abs());
end;



// Matrix
procedure TestAddMatrix();
begin
  var m1, m2, result: Matrix;
//  writeln('Введите размерность первой матрицы (n x m):');
  m1 := new Matrix(2, 2, new Number());
  Writeln('Введите матрицу');
  m1 := Matrix.Read(m1);
  
  writeln('Введите размерность второй матрицы (n x m):');
  m2 := new Matrix(2, 2, new Number());
  Writeln('Введите матрицу');
  m2 := Matrix.Read(m2);
  Matrix.Print(m1 + m2);
end;

procedure TestSubMatrix();
begin
  var m1, m2, result: Matrix;
//  writeln('Введите размерность первой матрицы (n x m):');
  m1 := new Matrix(2, 2, new Number());
  Writeln('Введите матрицу');
  m1 := Matrix.Read(m1);
  
  writeln('Введите размерность второй матрицы (n x m):');
  m2 := new Matrix(2, 2, new Number());
  Writeln('Введите матрицу');
  m2 := Matrix.Read(m2);
  Matrix.Print(m1 - m2);
end;

procedure TestMultMatrix();
begin
  var m1, m2, result: Matrix;
//  writeln('Введите размерность первой матрицы (n x m):');
  m1 := new Matrix(2, 2, new Number());
  Writeln('Введите матрицу');
  m1 := Matrix.Read(m1);
  
//  writeln('Введите размерность второй матрицы (n x m):');
  m2 := new Matrix(2, 2, new Number());
  Writeln('Введите матрицу');
  m2 := Matrix.Read(m2);
  Matrix.Print(m1 * m2);
end;

procedure TestProdMatrix();
begin
  var m1, m2, result: Matrix;
  var scalar: Number;
//  writeln('Введите размерность первой матрицы (n x m):');
  m1 := new Matrix(2, 2, new Number());
  Writeln('Введите скаляр');
  scalar := ReadString();
  Writeln('Введите матрицу');
  m1 := Matrix.Read(m1);
  Writeln(m1.Prod(scalar));
end;

procedure TestNormMatrix();
begin
  var m1, m2, result: Matrix;
  var scalar: Number;
//  writeln('Введите размерность первой матрицы (n x m):');
  m1 := new Matrix(2, 2, new Number());
  Writeln('Введите матрицу');
  m1 := Matrix.Read(m1);
  Writeln(m1.Norm().ToString());
end;

procedure TestExpMatrix();
begin
  var m1, m2, result: Matrix;
  var scalar: Number;
//  writeln('Введите размерность первой матрицы (n x m):');
  m1 := new Matrix(2, 2, new Number());
  Writeln('Введите матрицу');
  m1 := Matrix.Read(m1);
  Writeln(m1.ExpMatrix().ToString());
end;


procedure ComplexMenu();
begin
  var Menu: TMenuItems;
  SetLength(Menu, 11);
  
  Menu[0].Name := 'Сложение';
  Menu[0].Callback := TestAddComplex;

  Menu[1].Name := 'Умножение';
  Menu[1].Callback := TestMultComplex;
  
  Menu[2].Name := 'Сопряжонное';
  Menu[2].Callback := TestConjugateComplex;

  Menu[3].Name := 'Умножение на скаляр';
  Menu[3].Callback := TestProdComplex;
  
  Menu[4].Name := 'Модуль';
  Menu[4].Callback := TestAbsComplex;
  
  Menu[5].Name := 'Exp';
  Menu[5].Callback := TestExpComplex;
  
  Menu[6].Name := 'Cos';
  Menu[6].Callback := TestCosComplex;
  
  Menu[7].Name := 'Sin';
  Menu[7].Callback := TestSinComplex;
  
  Menu[8].Name := 'Вычитание';
  Menu[8].Callback := TestSubComplex;
  
  Menu[9].Name := 'Обратное';
  Menu[9].Callback := TestInvComplex;

  Menu[10].Name := 'выход';
  Menu[10].Callback := ExitProgram;

  HandleMenu(Menu, selected);
  
end;

procedure MatrixMenu();
begin
  var Menu: TMenuItems;
  SetLength(Menu, 7);
  
  Menu[0].Name := 'Сложение';
  Menu[0].Callback := TestAddMatrix;

  Menu[1].Name := 'Вычитание';
  Menu[1].Callback := TestSubMatrix;
  
  Menu[2].Name := 'Умножение';
  Menu[2].Callback := TestMultMatrix;
  
  Menu[3].Name := 'Умножение на скаляр';
  Menu[3].Callback := TestProdMatrix;
  
  Menu[4].Name := 'Норма матрицы';
  Menu[4].Callback := TestNormMatrix;
  
  Menu[5].Name := 'Exp';
  Menu[5].Callback := TestExpMatrix;

  Menu[6].Name := 'выход';
  Menu[6].Callback := ExitProgram;

  HandleMenu(Menu, selected);
end;


procedure VectorMenu();
begin
  var Menu: TMenuItems;
  SetLength(Menu, 8);
  
  Menu[0].Name := 'Сложение';
  Menu[0].Callback := TestAddVector;

  Menu[1].Name := 'Скалярное произведение';
  Menu[1].Callback := TestDotProduct;
  
  Menu[2].Name := 'Векторное произведение';
  Menu[2].Callback := TestCrossProduct;
  
  Menu[3].Name := 'Смешаное произведение';
  Menu[3].Callback := TestMixedProduct;
  
  Menu[5].Name := 'Умножение на скаляр';
  Menu[5].Callback := TestScalarMultiplication;
  
  Menu[6].Name := 'Деление на скаляр';
  Menu[6].Callback := TestScalarDivision;

  Menu[7].Name := 'выход';
  Menu[7].Callback := ExitProgram;

  HandleMenu(Menu, selected);
  
end;



begin
  var Menu: TMenuItems;
  SetLength(Menu, 4);
  
  Menu[0].Name := 'Комплексные числа';
  Menu[0].Callback := ComplexMenu;

  Menu[1].Name := 'Матрицы';
  Menu[1].Callback := MatrixMenu;
  
  Menu[2].Name := 'Векторы';
  Menu[2].Callback := VectorMenu;

  Menu[3].Name := 'выход';
  Menu[3].Callback := ExitProgram;

  HandleMenu(Menu, selected);
end.