unit uEstadoDto;

interface

type
  TEstadoDto = class
  private
    FUF: String;
    FIdUF: Integer;
    FNome: String;
    procedure SetIdUF(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetUF(const Value: String);
  public
    property IdUF: Integer read FIdUF write SetIdUF;
    property Nome: String read FNome write SetNome;
    property UF: String read FUF write SetUF;
  end;

implementation

{ TEstadoDto }

procedure TEstadoDto.SetIdUF(const Value: Integer);
begin
  FIdUF := Value;
end;

procedure TEstadoDto.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TEstadoDto.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
