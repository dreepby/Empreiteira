unit uMunicipioDto;

interface

type
  TMunicipioDto = class
  private
    FidMunicipio: Integer;
    FidUf: integer;
    FNome: String;
    FnomeUf: String;
    procedure SetidMunicipio(const Value: Integer);
    procedure SetidUf(const Value: integer);
    procedure SetNome(const Value: String);
    procedure SetnomeUf(const Value: String);

  public
    property idMunicipio: Integer read FidMunicipio write SetidMunicipio;
    property Nome: String read FNome write SetNome;
    property idUf: integer read FidUf write SetidUf;
    property nomeUf: String read FnomeUf write SetnomeUf;
  end;

implementation

{ TMunicipioDto }

procedure TMunicipioDto.SetidMunicipio(const Value: Integer);
begin
  FidMunicipio := Value;
end;

procedure TMunicipioDto.SetidUf(const Value: integer);
begin
  FidUf := Value;
end;

procedure TMunicipioDto.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TMunicipioDto.SetnomeUf(const Value: String);
begin
  FnomeUf := Value;
end;

end.
