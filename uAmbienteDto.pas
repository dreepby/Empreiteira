unit uAmbienteDto;

interface

type
  TAmbienteDto = class
  private
    FDescricao: String;
    FidAmbiente: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetidAmbiente(const Value: Integer);
  public
    property idAmbiente: Integer read FidAmbiente write SetidAmbiente;
    property Descricao: String read FDescricao write SetDescricao;
  end;

implementation

{ TAmbienteDto }

procedure TAmbienteDto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TAmbienteDto.SetidAmbiente(const Value: Integer);
begin
  FidAmbiente := Value;
end;


end.
