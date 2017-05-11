unit uMunicipioControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uMunicipioDto,
  uMunicipioModel, uMunicipio, uEstadoDto, uEstadoModel;

type
  TMunicipioControler = class
  private
    oListaEstados: TDictionary<string, TEstadoDto>;
    oModelEstado: TEstadoModel;
    oModelMunicipio: TMunicipioModel;
  public
    procedure Limpar(var AMunicipio: TMunicipioDto);

    procedure AbrirMunicipio();

    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TMunicipioControler }

procedure TMunicipioControler.AbrirMunicipio;
begin
  if (not(Assigned(frmMunicipio))) then
    frmMunicipio := TfrmMunicipio.Create(nil);
  Limpar(frmMunicipio.oMunicipio);
  frmMunicipio.Show;
end;


constructor TMunicipioControler.Create;
begin
  oModelMunicipio := TMunicipioModel.Create;
  oModelEstado := TEstadoModel.Create;
  oListaEstados := TDictionary<string, TEstadoDto>.Create;
end;

destructor TMunicipioControler.Destroy;
begin
   if Assigned(oModelMunicipio) then
    FreeAndNil(oModelMunicipio);

  if Assigned(oModelEstado) then
    FreeAndNil(oModelEstado);

  if Assigned(oListaEstados) then
  begin
    oListaEstados.Clear;
    FreeAndNil(oListaEstados);
  end;
  inherited;
end;

procedure TMunicipioControler.Limpar(var AMunicipio: TMunicipioDto);
begin
  AMunicipio.idMunicipio := 0;
  AMunicipio.Nome := EmptyStr;
  AMunicipio.idUf := 0;
end;

end.
