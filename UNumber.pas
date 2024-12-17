unit UNumber;

uses UComplex;

type
  Number = class
  private
    RealValue: real? := nil;
    ComplexValue: Complex := nil;
  public
    
    public constructor Create(aValue: real); overload;
    begin
      self.RealValue := aValue;
    end;
    
    public constructor Create(aValue: string); overload;
    begin
      var newNum: real;
      if real.TryParse(aValue, newNum) then 
        self.RealValue := newNum
      else
      begin
        var c: Complex := aValue;
        self.ComplexValue := c;
      end;
    end;
    
    public constructor Create(aValue: Complex); overload;
    begin
      ComplexValue := aValue;
    end;
    
    public constructor Create(); overload;
    begin
      
    end;
    
    
    static function operator implicit(num: System.String): Number; overload;
    begin
      Result := new Number(num);
    end;
    
    static function operator implicit(num: real): Number; overload;
    begin
      Result := new Number(num);
    end;
    
    static function operator implicit(num: Complex): Number; overload;
    begin
      Result := new Number(num);
    end;
    
    static function operator implicit(num: Number): real; overload;
    begin
      if num.RealValue.HasValue then
        Result := num.RealValue.Value
      else
        raise new Exception('Невозможно привести Complex к Real');
    end;
    
    static function operator implicit(num: Number): Complex; overload;
    begin
      if num.ComplexValue <> nil then
        Result := num.ComplexValue
      else
        Result := new Complex(num.RealValue.Value, 0);
    end;
    
    static function operator +(a, b: Number): Number;
    begin
      if (a.ComplexValue <> nil) or (b.ComplexValue <> nil) then
        Result := new Number(Complex(a) + Complex(b))
      else
        Result := new Number(real(a) + real(b));
    end;
    
    static function operator -(a, b: Number): Number;
    begin
      if (a.ComplexValue <> nil) or (b.ComplexValue <> nil) then
        Result := new Number(Complex(a) - Complex(b))
      else
        Result := new Number(real(a) - real(b));
    end;
    
    static function operator *(a, b: Number): Number;
    begin
      if (a.ComplexValue <> nil) or (b.ComplexValue <> nil) then
        Result := new Number(Complex(a) * Complex(b))
      else
        Result := new Number(real(a) * real(b));
    end;
    
    public function Prod(scalar: real): Number;
    begin
      if (self.ComplexValue <> nil) then
        Result := new Number(self.ComplexValue.Prod(scalar))
      else
        Result := new Number(real(self)*scalar);
    end;
    
    public function Sqrt(): Number;
    begin
      if (self.ComplexValue <> nil) then
        Result := new Number(self.ComplexValue.Sqrt())
      else
        Result := new Number(real(self).Sqrt());
    end;
    
    static function operator /(a, b: Number): Number;
    begin
      if (a.ComplexValue <> nil) or (b.ComplexValue <> nil) then
        Result := new Number(Complex(a) / Complex(b))
      else
        Result := new Number(real(a) / real(b));
    end;
    
    public function ToString(): string; override;
    begin
      if ComplexValue <> nil then
        Result := ComplexValue.ToString()
      else if RealValue.HasValue then
        Result := RealValue.Value.ToString()
      else
        Result := 'No Value';
    end;
  end;
end.