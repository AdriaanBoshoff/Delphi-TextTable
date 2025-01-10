# Delphi TextTable
 Allows you to make a table with columns and rows but in text format.

## Example

```delphi
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
```

### Output

```delphi
col1 Middle Column col3
val1 val2          val 3
```
