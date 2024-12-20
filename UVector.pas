unit UVector;

uses UComplex, UNumber, System;

type
  Vector = class
    public x: Number;
    public y: Number;
    public z: Number;
    
    public constructor Create(x, y, z: Number);
    begin
      Self.x := x;
      Self.y := y;
      Self.z := z;
    end;
    
    public constructor Create(str: string);
    var
      parts: array of string;
      x, y, z: Number;
    begin
      parts := str.Split([';']);
      
      if Length(parts) <> 3 then
        raise new Exception('Некорректный формат строки для приведения к вектору. Ожидается три координаты.');
      
      x := new Number(parts[0]);
      y := new Number(parts[1]);
      z := new Number(parts[2]);
      
      if not ValidateTypeVector(x, y, z) then
        raise new Exception('Ошибка: все компоненты вектора должны быть одного типа.');
      
      Self.x := x;
      Self.y := y;
      Self.z := z;
    end;
    
    private static function ValidateTypeVector(a, b, c: Number): boolean;
begin

  var IsComplex := a.ComplexValue <> nil;

  if IsComplex then
  begin
    if b.RealValue <> nil then
      begin
        Result := false;
        exit;
      end;
    if c.RealValue <> nil then
    begin
      Result := false;
      exit;
    end;
  end;
  if not IsComplex then
  begin
    if b.ComplexValue <> nil then
      begin
        Result := false;
        exit;
      end;
    if c.ComplexValue <> nil then
    begin
      Result := false;
      exit;
    end;
  end;
  Result := true; // Если все проверки пройдены
end;


    public
    // Сложение векторов
    static function operator+(a, b: Vector): Vector;
    begin
      Result := new Vector(a.x + b.x, a.y + b.y, a.z + b.z);
    end;
    
    // Вычитание векторов
    static function operator-(a, b: Vector): Vector;
    begin
      Result := new Vector(a.x - b.x, a.y - b.y, a.z - b.z);
    end;
    
    // Скалярное произведение
    static function operator*(a, b: Vector): Number;
    begin
      Result := a.x * b.x + a.y * b.y + a.z * b.z;
    end;
    
    // Векторное произведение
    static function operator**(a, b: Vector): Vector;
    begin
      Result := new Vector(
        a.y * b.z - a.z * b.y,
        a.z * b.x - a.x * b.z,
        a.x * b.y - a.y * b.x);
    end;
    
    // Умножение вектора на скаляр
    static function operator*(v: Vector; scalar: Number): Vector;
    begin
      Result := new Vector(v.x * scalar, v.y * scalar, v.z * scalar);
    end;
    
    // Деление на скаляр
    static function operator/(v: Vector; scalar: Number): Vector;
    begin
      Result := new Vector(v.x / scalar, v.y / scalar, v.z / scalar);
    end;
    
    // Равенство векторов
    static function operator=(a, b: Vector): boolean;
    begin
      Result := (a.x = b.x) and (a.y = b.y) and (a.z = b.z);
    end;
    
    static function MixedProduct(a, b, c: Vector): Number;
    begin
      Result := a * (b ** c);
    end;
    
    // Модуль вектора
    public function Abs(): real;
    begin
      Result := Sqrt(real(Self * Self));
    end;
    
    // Нормализация вектора
    public function Normalize(): Vector;
    var
      magnitude: real;
    begin
      magnitude := Self.Abs();
      if magnitude = 0 then
        raise new Exception('Невозможно нормализовать нулевой вектор');
      Result := Self / magnitude;
    end;
    
    static function operator implicit(num: string): Vector;
    begin
      Result := new Vector(num);
    end;
    
    public function ToString(): string; override;
    begin
      Result := $'Vector(x={Self.x}, y={Self.y}, z={Self.z})';
    end;
  end;

end.
