uses UComplex, UVector, UMatrix, Crt;

var
  Mode: integer;
  Ok: boolean;


procedure MenuComplexNumbers();
var a, b: Complex;
var result: Complex;
var scalar: real;
begin
  repeat
    ClrScr;
    writeln('--- Меню: Комплексные числа ---');
    writeln('1. Сложение');
    writeln('2. Вычитание');
    writeln('3. Умножение');
    writeln('4. Деление');
    writeln('5. Конъюгирование');
    writeln('6. Модуль');
    writeln('7. Умножение на скаляр');
    writeln('8. Квадратный корень');
    writeln('0. Назад');
    write('Выберите действие: ');
    readln(Mode);
    case Mode of
      1: begin
        writeln('Введите первое комплексное число:');
        a := ReadString();
        writeln('Введите второе комплексное число:');
        b := ReadString();
        result := a + b;
        writeln('Результат сложения: ', result);
      end;
      2: begin
        writeln('Введите первое комплексное число:');
        a := ReadString();
        writeln('Введите второе комплексное число:');
        b := ReadString();
        result := a - b;
        writeln('Результат вычитания: ', result);
      end;
      3: begin
        writeln('Введите первое комплексное число:');
        a := ReadString();
        writeln('Введите второе комплексное число:');
        b := ReadString();
        result := a * b;
        writeln('Результат умножения: ', result);
      end;
      4: begin
        writeln('Введите первое комплексное число:');
        a := ReadString();
        writeln('Введите второе комплексное число:');
        b := ReadString();
        result := a / b;
        writeln('Результат деления: ', result);
      end;
      5: begin
        writeln('Введите комплексное число:');
        a := ReadString();
        result := a.Conjugate();
        writeln('Конъюгированное число: ', result);
      end;
      6: begin
        writeln('Введите комплексное число:');
        a := ReadString();
        writeln('Модуль: ', a.Abs);
      end;
      7: begin
        writeln('Введите комплексное число:');
        a := ReadString();
        write('Введите скаляр: ');
        readln(scalar);
        result := a.Prod(scalar);
        writeln('Результат умножения на скаляр: ', result);
      end;
      8: begin
        writeln('Введите комплексное число:');
        a := ReadString();
        result := a.Sqrt();
        writeln('Квадратный корень: ', result);
      end;
    end;
    readln;
  until Mode = 0;
end;


procedure MenuVectors();
var
  v1, v2, result: Vector;
  scalar: real;
begin
  repeat
    ClrScr;
    writeln('--- Меню: Векторы ---');
    writeln('1. Сложение');
    writeln('2. Вычитание');
    writeln('3. Скалярное произведение');
    writeln('4. Векторное произведение');
    writeln('5. Умножение на скаляр');
    writeln('6. Деление на скаляр');
    writeln('7. Модуль вектора');
    writeln('8. Нормализация');
    writeln('0. Назад');
    write('Выберите действие: ');
    readln(Mode);
    case Mode of
      1: begin
        writeln('Введите первый вектор:');
        v1 := new Vector(ReadString());
        writeln('Введите второй вектор:');
        v2 := new Vector(ReadString());
        result := v1 + v2;
        writeln('Результат сложения: ', result);
      end;
      2: begin
        writeln('Введите первый вектор:');
        v1 := new Vector(ReadString());
        writeln('Введите второй вектор:');
        v2 := new Vector(ReadString());
        result := v1 - v2;
        writeln('Результат вычитания: ', result);
      end;
      3: begin
        writeln('Введите первый вектор:');
        v1 := new Vector(ReadString());
        writeln('Введите второй вектор:');
        v2 := new Vector(ReadString());
        writeln('Скалярное произведение: ', v1 * v2);
      end;
      4: begin
        writeln('Введите первый вектор:');
        v1 := new Vector(ReadString());
        writeln('Введите второй вектор:');
        v2 := new Vector(ReadString());
        result := v1 ** v2;
        writeln('Векторное произведение: ', result);
      end;
      5: begin
        writeln('Введите вектор:');
        v1 := new Vector(ReadString());
        write('Введите скаляр: ');
        readln(scalar);
        result := v1 * scalar;
        writeln('Результат умножения: ', result);
      end;
      6: begin
        writeln('Введите вектор:');
        v1 := new Vector(ReadString());
        write('Введите скаляр: ');
        readln(scalar);
        result := v1 / scalar;
        writeln('Результат деления: ', result);
      end;
      7: begin
        writeln('Введите вектор:');
        v1 := new Vector(ReadString());
        writeln('Модуль вектора: ', v1.Abs);
      end;
      8: begin
        writeln('Введите вектор:');
        v1 := new Vector(ReadString());
        result := v1.Normalize();
        writeln('Нормализованный вектор: ', result);
      end;
    end;
    readln;
  until Mode = 0;
end;


procedure MenuMatrices();
var m1, m2, result: Matrix;
var scalar: real;

begin
  repeat
    ClrScr;
    writeln('--- Меню: Матрицы ---');
    writeln('1. Сложение');
    writeln('2. Вычитание');
    writeln('3. Умножение');
    writeln('4. Умножение на скаляр');
    writeln('5. Модуль матрицы (евклидова норма)');
    writeln('0. Назад');
    write('Выберите действие: ');
    readln(Mode);
    case Mode of
      1: begin
        writeln('Введите размерность первой матрицы (n x m):');
        m1 := new Matrix(ReadInteger(), ReadInteger());
        Writeln('Введите матрицу');
        m1 := Matrix.Read(m1);
        
        writeln('Введите размерность второй матрицы (n x m):');
        m2 := new Matrix(ReadInteger(), ReadInteger());
        Writeln('Введите матрицу');
        m2 := Matrix.Read(m2);
        result := m1 + m2;
        writeln('Результат сложения:');
        Matrix.Print(result);
      end;
      2: begin
        writeln('Введите размерность первой матрицы (n x m):');
        m1 := new Matrix(ReadInteger(), ReadInteger());
        Writeln('Введите матрицу');
        m1 := Matrix.Read(m1);
        
        writeln('Введите размерность второй матрицы (n x m):');
        m2 := new Matrix(ReadInteger(), ReadInteger());
        Writeln('Введите матрицу');
        m2 := Matrix.Read(m2);
        result := m1 - m2;
        writeln('Результат вычитания:');
        Matrix.Print(result);
      end;
      3: begin
        writeln('Введите размерность первой матрицы (n x m):');
        m1 := new Matrix(ReadInteger(), ReadInteger());
        Writeln('Введите матрицу');
        m1 := Matrix.Read(m1);
        
        writeln('Введите размерность второй матрицы (n x m):');
        m2 := new Matrix(ReadInteger(), ReadInteger());
        Writeln('Введите матрицу');
        m2 := Matrix.Read(m2);
        result := m1 * m2;
        writeln('Результат умножения:');
        Matrix.Print(result);
      end;
      4: begin
        writeln('Введите размерность первой матрицы (n x m):');
        m1 := new Matrix(ReadInteger(), ReadInteger());
        Writeln('Введите матрицу');
        m1 := Matrix.Read(m1);
        
        Writeln('Введите скаляр');
        scalar := ReadReal();
        result := m1.Prod(scalar);
        writeln('Результат умножения на скаляр:');
        Matrix.Print(result);
      end;
      5: begin
        writeln('Введите размерность первой матрицы (n x m):');
        m1 := new Matrix(ReadInteger(), ReadInteger());
        Writeln('Введите матрицу');
        m1 := Matrix.Read(m1);
        Writeln('Модуль матрицы: ');
        Write(m1.Norm());
      end;
    end;
    readln;
  until Mode = 0;
end;

begin
  Ok := true;
  while Ok do
  begin
    ClrScr;
    writeln('--- Главное меню ---');
    writeln('1: Комплексные числа');
    writeln('2: Векторы');
    writeln('3: Матрицы');
    writeln('0: Выход');
    write('Выберите пункт: ');
    readln(Mode);
    ClrScr;
    case Mode of
      1: MenuComplexNumbers;
      2: MenuVectors;
      3: MenuMatrices;
      0: Ok := false;
      else
        begin
          writeln('Ошибка');
          delay(1000);
        end;
    end;
  end;
end.
