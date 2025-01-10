unit uTextTable;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Math;

type
  TTextTable = class
  private
    type
      TRow = class
      public
        Values: TArray<string>;
        constructor Create(const AValues: TArray<string>);
      end;

      TColumn = class
      public
        Title: string;
        Width: Integer;
        constructor Create(const ATitle: string);
      end;
  private
    FRows: TObjectList<TRow>;
    FColumns: TObjectList<TColumn>;
    FText: string;
    procedure MarkDirty;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure AddColumns(const Values: TArray<string>);
    procedure AddColumn(const Title: string);
    procedure AddRow(const Values: TArray<string>);
    function ToString: string; override;
  end;

implementation

constructor TTextTable.TRow.Create(const AValues: TArray<string>);
begin
  Values := AValues;
end;

constructor TTextTable.TColumn.Create(const ATitle: string);
begin
  Title := ATitle;
  Width := Length(ATitle);
end;

constructor TTextTable.Create;
begin
  FRows := TObjectList<TRow>.Create;
  FColumns := TObjectList<TColumn>.Create;
end;

destructor TTextTable.Destroy;
begin
  FRows.Free;
  FColumns.Free;
  inherited;
end;

procedure TTextTable.Clear;
begin
  FRows.Clear;
  FColumns.Clear;
  MarkDirty;
end;

procedure TTextTable.AddColumns(const Values: TArray<string>);
var
  Value: string;
begin
  for Value in Values do
    FColumns.Add(TColumn.Create(Value));
  MarkDirty;
end;

procedure TTextTable.AddColumn(const Title: string);
begin
  FColumns.Add(TColumn.Create(Title));
  MarkDirty;
end;

procedure TTextTable.AddRow(const Values: TArray<string>);
var
  I, Num: Integer;
begin
  Num := Min(FColumns.Count, Length(Values));
  for I := 0 to Num - 1 do
    FColumns[I].Width := Max(FColumns[I].Width, Length(Values[I]));
  FRows.Add(TRow.Create(Values));
  MarkDirty;
end;

function TTextTable.ToString: string;
var
  Column: TColumn;
  Row: TRow;
  I, J: Integer;
begin
  if FText = '' then
  begin
    FText := '';
    // Add column headers
    for Column in FColumns do
      FText := FText + Column.Title.PadRight(Column.Width + 1);
    FText := FText + sLineBreak;

    // Add rows
    for Row in FRows do
    begin
      for J := 0 to Min(FColumns.Count, Length(Row.Values)) - 1 do
        FText := FText + Row.Values[J].PadRight(FColumns[J].Width + 1);
      FText := FText + sLineBreak;
    end;
  end;
  Result := FText;
end;

procedure TTextTable.MarkDirty;
begin
  FText := '';
end;

end.

