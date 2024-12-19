uses Crt;

const
  MenuItems: array[0..4] of string = ('Комплексные числа', 'Векторы', 'Матрицы', 'Настройки', 'Выход');
var
  selected: integer = 0;
  ch: char;

procedure DrawMenu();
var
  i: integer;
begin
  ClrScr;
  for i := 0 to High(MenuItems) do
  begin
    if i = selected then
      TextColor(Green)
    else
      TextColor(White);
    if i = selected then
      Write('-> ');
    Writeln(MenuItems[i]);
  end;
end;

begin
  repeat
    DrawMenu;
    ch := ReadKey;  // Чтение клавиши

    case ch of
      #0, #224:  // Спецсимволы для стрелок
        begin
          ch := ReadKey;  // Считываем второй байт
          case Ord(ch) of
            38: // Стрелка вверх
              begin
                if selected > 0 then
                  Dec(selected)
                else
                  selected := High(MenuItems);
              end;
            40: // Стрелка вниз
              begin
                if selected < High(MenuItems) then
                  Inc(selected)
                else
                  selected := 0;
              end;
          end;
        end;
      #13: // Enter
        begin
          case selected of
            0: Writeln('Вы выбрали пункт: Комплексные числа');
            1: Writeln('Вы выбрали пункт: Векторы');
            2: Writeln('Вы выбрали пункт: Матрицы');
            3: Writeln('Вы выбрали пункт: Настройки');
            4: Writeln('Выход из программы');
            else Writeln('Неизвестный пункт');
          end;
          Delay(1000);  // Задержка перед возвратом в меню
        end;
    end;
  until selected = 4;  // Пока не выбран пункт "Выход"
end.
