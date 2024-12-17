unit UMatrix;

uses UComplex;
uses UArrayTools;
uses UNumber;

type
  Matrix = class
    public Data: array [,] of Number;
    
    public constructor Create(r, c: integer; fill: Number := new Number());
    begin
      Data := new Number[r, c];
      self.FillMatrix(fill);
    end;
    
    // Заполнение матрицы
    public procedure FillMatrix(value: Number);
    begin
      for var i: integer := 0 to Data.GetLength(0) - 1 do
        for var j: integer := 0 to Data.GetLength(1) - 1 do
          Data[i, j] := value;
    end;
    
    // Установка значения элемента матрицы
    public procedure SetElement(i, j: integer; value: Number);
    begin
      if (i >= 0) and (i < Data.GetLength(0)) and (j >= 0) and (j < Data.GetLength(1)) then
        Data[i, j] := value
      else
        raise new Exception('Индекс за пределами матрицы');
    end;
    
    // Получение элемента матрицы
    public function GetElement(i, j: integer): Number;
    begin
      if (i >= 0) and (i < Data.GetLength(0)) and (j >= 0) and (j < Data.GetLength(1)) then
        Result := Data[i, j]
      else
        raise new Exception('Индекс за пределами матрицы');
    end;
    
    // Сложение матриц
    static function operator+(a, b: Matrix): Matrix;
    begin
      if (a.Data.GetLength(0) <> b.Data.GetLength(0)) or (a.Data.GetLength(1) <> b.Data.GetLength(1)) then
        raise new Exception('Матрицы должны быть одинакового размера для сложения');
      
      Result := new Matrix(a.Data.GetLength(0), a.Data.GetLength(1), new Number(0));
      for var i: integer := 0 to a.Data.GetLength(0) - 1 do
        for var j: integer := 0 to a.Data.GetLength(1) - 1 do
          Result.Data[i, j] := a.Data[i, j] + b.Data[i, j];
    end;
    
    // Вычитание матриц
    static function operator -(a, b: Matrix): Matrix;
    begin
      if (a.Data.GetLength(0) <> b.Data.GetLength(0)) or (a.Data.GetLength(1) <> b.Data.GetLength(1)) then
        raise new Exception('Матрицы должны быть одинакового размера для вычитания');
      
      Result := new Matrix(a.Data.GetLength(0), a.Data.GetLength(1), new Number(0));
      for var i: integer := 0 to a.Data.GetLength(0) - 1 do
        for var j: integer := 0 to a.Data.GetLength(1) - 1 do
          Result.Data[i, j] := a.Data[i, j] - b.Data[i, j];
    end;
    
    // Умножение матриц
    static function operator*(a, b: Matrix): Matrix;
    begin
      if a.Data.GetLength(1) <> b.Data.GetLength(0) then
        raise new Exception('Число столбцов первой матрицы должно быть равно числу строк второй матрицы');
      
      Result := new Matrix(a.Data.GetLength(0), b.Data.GetLength(1), new Number(0));
      for var i: integer := 0 to a.Data.GetLength(0) - 1 do
        for var j: integer := 0 to b.Data.GetLength(1) - 1 do
        begin
          var sum: Number := new Number(0);
          for var k: integer := 0 to a.Data.GetLength(1) - 1 do
            sum := sum + a.Data[i, k] * b.Data[k, j];
          Result.Data[i, j] := sum;
        end;
    end;
    
    public function Prod(scalar: real): Matrix;
    var
      newMatrix: Matrix := new Matrix(self.RowCount(), self.ColCount());
    begin
      for var i := 0 to self.RowCount() - 1 do
        for var j := 0 to self.ColCount() - 1 do
          newMatrix.SetElement(i, j, self.Data[i, j].Prod(scalar));
      
      Result := newMatrix;
    end;
    
    // Метод для вычисления модуля матрицы (евклидова норма)
public function Norm: Number;
    begin
      var sumSquares: Number := new Number(0);
      for var i := 0 to RowCount - 1 do
        for var j := 0 to ColCount - 1 do
          sumSquares := sumSquares + (Data[i, j] * Data[i, j]); // Сумма квадратов элементов
      
      Result := sumSquares.Sqrt(); // Корень из суммы квадратов
    end;

    
    // Получение количества строк
    public function RowCount: integer;
    begin
      Result := Data.GetLength(0);
    end;
    
    // Получение количества столбцов
    public function ColCount: integer;
    begin
      Result := Data.GetLength(1);
    end;
    
    
    static procedure Print(
    matrix: Matrix; 
    x: integer; 
    y: integer);
    begin
      TArrayTools.PrintArray(Matrix.Data, x, y);
    end;
    
    static procedure Print(
    matrix: Matrix);
    begin
      TArrayTools.PrintArray(Matrix.Data);
    end;
    
    public static function Read(
      mat: Matrix;
      outX: integer;
      outY: integer;
      inputX: integer;
      inputY: integer): Matrix;
    begin
      var m: Matrix := new Matrix();
      m.Data := TArrayTools.ReadArray(mat.Data, outX, outY, inputX, inputY);
      Result := m;
    end;
    
    public static function Read(mat: Matrix): Matrix;
    begin
      var m: Matrix := new Matrix();
      m.Data := TArrayTools.ReadArray(mat.Data);
      Result := m;
    end;
  
  end;
end.