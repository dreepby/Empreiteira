unit uBairrosDto;

interface

type
  TBairrosDto = class
  private
    FNomeMunicipio: String;
    FidBairro: Integer;
    FNome: String;
    FidMunicipio: Integer;
    procedure SetidBairro(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetNomeMunicipio(const Value: String);
    procedure SetidMunicipio(const Value: Integer);
  public
    property idBairro: Integer read FidBairro write SetidBairro;
    property Nome: String read FNome write SetNome;
    property idMunicipio: Integer read FidMunicipio write SetidMunicipio;
    property NomeMunicipio: String read FNomeMunicipio write SetNomeMunicipio;
  end;

implementation

{ TBairrosDto }

procedure TBairrosDto.SetidBairro(const Value: Integer);
begin
  FidBairro := Value;
end;


procedure TBairrosDto.SetidMunicipio(const Value: Integer);
begin
  FidMunicipio := Value;
end;

procedure TBairrosDto.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TBairrosDto.SetNomeMunicipio(const Value: String);
begin
  FNomeMunicipio := Value;
end;

end.
