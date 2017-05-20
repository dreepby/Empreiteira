unit uBairroDto;

interface

uses
  uMunicipioDto, System.SysUtils;

type
  TBairroDto = class
  private
    FNomeMunicipio: String;
    FidBairro: Integer;
    FNome: String;
    FidMunicipio: Integer;
    FoMunicipio: TMunicipioDto;
    procedure SetidBairro(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetNomeMunicipio(const Value: String);
    procedure SetidMunicipio(const Value: Integer);
    procedure SetoMunicipio(const Value: TMunicipioDto);
  public
    property idBairro: Integer read FidBairro write SetidBairro;
    property Nome: String read FNome write SetNome;
    property oMunicipio: TMunicipioDto read FoMunicipio write SetoMunicipio;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBairrosDto }

constructor TBairroDto.Create;
begin
  FoMunicipio := TMunicipioDto.Create;
end;

destructor TBairroDto.Destroy;
begin
  if Assigned(FoMunicipio) then
    FreeAndNil(FoMunicipio);
  inherited;
end;

procedure TBairroDto.SetidBairro(const Value: Integer);
begin
  FidBairro := Value;
end;


procedure TBairroDto.SetidMunicipio(const Value: Integer);
begin
  FidMunicipio := Value;
end;

procedure TBairroDto.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TBairroDto.SetNomeMunicipio(const Value: String);
begin
  FNomeMunicipio := Value;
end;

procedure TBairroDto.SetoMunicipio(const Value: TMunicipioDto);
begin
  FoMunicipio := Value;
end;

end.
