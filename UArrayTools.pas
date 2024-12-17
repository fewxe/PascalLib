unit UArrayTools;

  uses crt;
  uses UNumber;

  type TArrayTools = class
    
  private static procedure PrintOneDimensionalArray<T>(
    arr: array of T; 
    x: integer;
    y: integer);
  begin
    GoToXY(x, y);
    Write('[');
    for var i: integer := 0 to arr.Length - 1 do
    begin
      crt.GoToXY(crt.WhereX() + 1, y);
      Write(arr[i].ToString());
      if (i < arr.Length - 1) then 
        Write(',');
    end;
    crt.GoToXY(crt.WhereX() + 1, y);
    Writeln(']');
    crt.GoToXY(1, crt.WhereY() + 1);
  end;
  
  
  public static procedure PrintArray<T>(
    arr: array of T; 
    x: integer; 
    y: integer);
  begin
    PrintOneDimensionalArray(arr, x, y);
  end;
  
  
  public static procedure PrintArray<T>(arr: array of T);
  begin
    var x: integer := crt.WhereX();
    var y: integer := crt.WhereY();
    PrintArray(arr, x, y);
  end;
  
  
  public static procedure PrintArray<T>(
    arr: array [,] of T; 
    x: integer; 
    y: integer);
  begin
    foreach var i: array of T in arr.Rows() do
    begin
      PrintOneDimensionalArray(i, x, y);
      y += 1;
    end;
    GoToXY(1, y);
  end;
  
  
  public static procedure PrintArray<T>(arr: array [,] of T);
  begin
    var x: integer := crt.WhereX();
    var y: integer := crt.WhereY();
    PrintArray(arr, x, y);
  end;
  
  
  private static function ReadOneDimensionalArray<T>(
    arr: array of T;
    outX: integer;
    outY: integer;
    inputX: integer;
    inputY: integer): array of T;
  begin
    var arr2: array of T := new T[arr.Length];
    arr.CopyTo(arr2, 0);
    var s: string;
    s += '[';
    for var i: integer := 0 to arr2.Length - 1 do
    begin
      GoToXY(inputX, inputY);
      Write('input: ');
      var str: string := ReadString();
      crt.GotoXY(1, WhereY() - 1);
      crt.ClearLine();
      
      if (typeof(T) = typeof(Number)) then
      begin
        var n: Number := new Number(str);
        arr2[i] := T(Convert.ChangeType(n, typeof(T)))
      end
      else
        begin
      var implicitMethod := typeof(T).GetMethod('op_Implicit',  System.Reflection.BindingFlags.Public or System.Reflection.BindingFlags.Static, nil, new System.Type[](typeof(string)), nil);
      if (implicitMethod <> nil) then
        arr2[i] := T(implicitMethod.Invoke(nil, new object[](str)))
      else
        arr2[i] := T(Convert.ChangeType(str, typeof(T)))
      end;
      GoToXY(outX, outY);
      s += arr2[i].ToString();
      if (i <> arr2.Length - 1) then 
        s += ', ';
      write(s);
    end;
    s += ']';
    GoTOXY(outX, outY);
    Write(s);
    GoToXY(1, WhereY() + 1);
    Result := arr2;
  end;
  
  
  public static function ReadArray<T>(
    arr: array of T;
    outX: integer;
    outY: integer;
    inputX: integer;
    inputY: integer): array of T;
  begin
    Result := ReadOneDimensionalArray(arr, outX, outY, inputX, inputY)
  end;
  
  
  public static function ReadArray<T>(arr: array of T): array of T;
  begin
    var outX: integer := crt.WhereX();
    var outY: integer := crt.WhereY();
    var inputX: integer := Round(crt.WindowWidth() / 2);
    var inputY: integer := crt.WindowHeight - 2;
    Result := ReadArray(arr, outX, outY, inputX, inputY);
  end;
  
  
  public static function ReadArray<T>(
    arr: array [,] of T;
    outX: integer;
    outY: integer;
    inputX: integer;
    inputY: integer): array [,] of T;
  begin
    var arr2: array [,] of T := new T[arr.RowCount(), arr.ColCount()];
    for var i: integer := 0 to arr.RowCount() - 1 do
    begin
      var arr3: array of T := ReadOneDimensionalArray(arr.Row(i), outX, outY, inputX, inputY);
      for var j: integer := 0 to arr3.Length - 1 do
      begin
        arr2[i, j] := arr3[j];
      end;
      outY += 1;
    end;
    Result := arr2;
  end;
  
  
  public static function ReadArray<T>(arr: array [,] of T): array [,] of T;
  begin
    var outX: integer := crt.WhereX();
    var outY: integer := crt.WhereY();
    var inputX: integer := Round(crt.WindowWidth() / 2);
    var inputY: integer := crt.WindowHeight - 2;
    Result := ReadArray(arr, outX, outY, inputX, inputY);
  end;
end;
end.