unit UComplex;


type
  Complex = class
    re, im: real;
    
    constructor(re: real := 0; im: real := 0);
    begin
      Self.re := re;
      Self.im := im;
    end;
    
    static function operator+(a, b: Complex): Complex;
    begin
      Result := new Complex(a.re + b.re, a.im + b.im);
    end;
    
    static function operator-(a, b: Complex): Complex;
    begin
      Result := new Complex(a.re - b.re, a.im - b.im);
    end;
    
    static function operator*(a, b: Complex): Complex;
    begin
      Result := new Complex((a.re * b.re - a.im * b.im), (a.re * b.im + a.im * b.re));
    end;
    
    static function operator=(a, b: Complex): boolean;
    begin
      Result := (a.re = b.re) and (a.im = b.im);
    end;
    
    public function Abs(): real;
    begin
      Result := PABCSystem.Sqrt(Sqr(self.re) + Sqr(self.im));
    end;
    
    public function Prod(a: real): Complex;
    begin
      Result := new Complex(a * self.re, a * self.im);
    end;
    
    public function Conjugate(): Complex;
    begin
      Result := new Complex(self.re, -self.im)
    end;
    
    public function Inv(): Complex;
    begin
      var q: real := Sqr(self.re) + Sqr(self.im);
      if (q = 0) then 
        raise new Exception('Division by zero');
      Result := new Complex(self.re / q, self.im / q);
    end;
    
    static function operator/(a, b: Complex): Complex;
    begin
      if (b.re = 0) and (b.im = 0) then
        raise new Exception('Division by zero');
      Result := a * b.Conjugate().Inv();
    end;
    
    static function operator implicit(s: string): Complex;
    begin
      var signPos: integer;
      var foundSign := False;
      s := s.Replace(' ', '');
      for var i := 1 to s.Length do
      begin
        if (s[i] in ['+', '-']) then
        begin
          signPos := i;
          foundSign := True;
        end;
      end;
      
      if not foundSign then
        raise new Exception('Invalid complex number format.');
      
      var reString := s.Substring(0, signPos - 1);  
      var imString := s.Substring(signPos - 1);   
      
      if imString.EndsWith('i') then
        imString := imString.Substring(0, imString.Length - 1);
      
      if imString = '' then
        imString := '0';
      
      var reValue := reString.ToReal();
      var imValue := imString.ToReal();
      
      Result := new Complex(reValue, imValue);
    end;

    
    public function Sqrt(): Complex;
    begin
      var r: real := PABCSystem.Sqrt(self.re * self.re + self.im * self.im);
      var u: real := PABCSystem.Sqrt((r + re) / 2);
      var v: real := PABCSystem.Sqrt((r - re) / 2);
      if self.im < 0 then
        v := -v;
      Result := new Complex(u, v);
    end;
    
    public function ToString(): string; override;
    begin
      var str: string;
      if (self.re <> 0) then str += self.re.ToString();
      if (self.im <> 0) then
      begin
        if (self.im > 0) then
        begin
          if (self.re <> 0) then str += '+';
        end
        else str += '-';
        str += PABCSystem.Abs(self.im).ToString() + 'i';
      end;
      Result := str;
    end;
  end;
end.
