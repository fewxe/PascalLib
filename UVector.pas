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
      parts := Str.Split([';']);
      
      if Length(parts) <> 3 then
        raise new Exception('Некорректный формат строки для приведения к вектору. Ожидается три координаты.');
      
      x := new Number(parts[0]);
      y := new Number(parts[1]);
      z := new Number(parts[2]);
      
      self.x := x;
      self.y := y;
      self.z := z;
    end;
    
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
    var
      parts: array of string;
      x, y, z: Number;
    begin
      parts := num.Split([';']);
      
      if Length(parts) <> 3 then
        raise new Exception('Некорректный формат строки для приведения к вектору. Ожидается три координаты.');
      
      x := new Number(parts[0]);
      y := new Number(parts[1]);
      z := new Number(parts[2]);
      
      Result := new Vector(x, y, z);
    end;
    
    public function ToString(): string; override;
    begin
      Result := $'Vector(x={Self.x}, y={Self.y}, z={Self.z})';
    end;
  end;

end.
