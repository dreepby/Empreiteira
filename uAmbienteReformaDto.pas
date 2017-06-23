unit uAmbienteReformaDto;

interface

uses
  System.SysUtils, uReformaDto, uAmbienteDto;

type
  TAmbienteReformaDto = class
  private
    FoAmbiente: TAmbienteDto;
    FoReforma: TReformaDto;
    FIdAmbienteReforma: Integer;
    procedure SetIdAmbienteReforma(const Value: Integer);
    procedure SetoAmbiente(const Value: TAmbienteDto);
    procedure SetoReforma(const Value: TReformaDto);
  public
    property IdAmbienteReforma: Integer read FIdAmbienteReforma
      write SetIdAmbienteReforma;
    property oReforma: TReformaDto read FoReforma write SetoReforma;
    property oAmbiente: TAmbienteDto read FoAmbiente write SetoAmbiente;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TAmbienteReformaDto }

constructor TAmbienteReformaDto.Create;
begin
  FoAmbiente := TAmbienteDto.Create;
  FoReforma := TReformaDto.Create;
end;

destructor TAmbienteReformaDto.Destroy;
begin
  if Assigned(FoAmbiente) then
    FreeAndNil(FoAmbiente);

  if Assigned(FoReforma) then
    FreeAndNil(FoReforma);
  inherited;
end;

procedure TAmbienteReformaDto.SetIdAmbienteReforma(const Value: Integer);
begin
  FIdAmbienteReforma := Value;
end;

procedure TAmbienteReformaDto.SetoAmbiente(const Value: TAmbienteDto);
begin
  FoAmbiente := Value;
end;

procedure TAmbienteReformaDto.SetoReforma(const Value: TReformaDto);
begin
  FoReforma := Value;
end;

end.
