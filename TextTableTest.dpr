program TextTableTest;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uTextTable in 'uTextTable.pas';

procedure Main;
begin
  var textTable := TTextTable.Create;
  try
    textTable.AddColumns(['col1', 'Middle Column', 'col3']);
    textTable.AddRow(['val1', 'val2', 'val 3']);

    Writeln(textTable.ToString);
  finally
    textTable.Free;
  end;
end;

begin
  ReportMemoryLeaksOnShutdown := True;

  try
    Main;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  ReadLn;
end.

