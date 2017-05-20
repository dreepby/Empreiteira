unit uMunicipioDto;

interface

uses
  uEstadoDto, System.SysUtils;

type
  TMunicipioDto = class
  private
    FidMunicipio: Integer;
    FidUf: Integer;
    FNome: String;
    FnomeUf: String;
    FoEstado: TEstadoDto;
    procedure SetidMunicipio(const Value: Integer);
    procedure SetNome(const Value: String);
    procedure SetoEstado(const Value: TEstadoDto);

  public
    property idMunicipio: Integer read FidMunicipio write SetidMunicipio;
    property Nome: String read FNome write SetNome;
    property oEstado: TEstadoDto read FoEstado write SetoEstado;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TMunicipioDto }

constructor TMunicipioDto.Create;
begin
  FoEstado := TEstadoDto.Create;
end;

destructor TMunicipioDto.Destroy;
begin
  if(Assigned(FoEstado)) then
    FreeAndNil(FoEstado);
  inherited;
end;

procedure TMunicipioDto.SetidMunicipio(const Value: Integer);
begin
  FidMunicipio := Value;
end;

procedure TMunicipioDto.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TMunicipioDto.SetoEstado(const Value: TEstadoDto);
begin
  FoEstado := Value;
end;

end.
