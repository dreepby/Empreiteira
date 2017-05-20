unit uMunicipioControlerInserirAlterar;

interface

Uses
  System.SysUtils, Data.DB, System.Generics.Collections, uMunicipioDto,
  uMunicipioModel, uEstadoDto, uEstadoModel;

type
  TMunicipioControlerInserirAlterar = class
  private
    oListaEstados: TDictionary<string, TEstadoDto>;
    oModelEstado: TEstadoModel;
    oModelMunicipio: TMunicipioModel;
  public
    function ADDListaHash(var oEstado: TObjectDictionary<string,
      TEstadoDto>): Boolean;
    procedure Limpar(var AMunicipio: TMunicipioDto);
    function Salvar(var AMunicipio: TMunicipioDto): Boolean;
    function Alterar(var AMunicipio: TMunicipioDto): Boolean;
    function VerificarMunicipio(AMunicipio: TMunicipioDto):Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TMunicipioControlerInserirAlterar }

function TMunicipioControlerInserirAlterar.ADDListaHash
  (var oEstado: TObjectDictionary<string, TEstadoDto>): Boolean;
begin
  Result := oModelEstado.ADDListaHash(oEstado);
end;

function TMunicipioControlerInserirAlterar.Alterar(var AMunicipio
  : TMunicipioDto): Boolean;
begin
  Result := oModelMunicipio.Alterar(AMunicipio);
end;

constructor TMunicipioControlerInserirAlterar.Create;
begin
  oModelMunicipio := TMunicipioModel.Create;
  oModelEstado := TEstadoModel.Create;
  oListaEstados := TDictionary<string, TEstadoDto>.Create;
end;

destructor TMunicipioControlerInserirAlterar.Destroy;
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

procedure TMunicipioControlerInserirAlterar.Limpar(var AMunicipio
  : TMunicipioDto);
begin
  AMunicipio.idMunicipio := 0;
  AMunicipio.Nome := EmptyStr;
  AMunicipio.idUf := 0;
end;

function TMunicipioControlerInserirAlterar.Salvar(var AMunicipio
  : TMunicipioDto): Boolean;
begin
  AMunicipio.idMunicipio := oModelMunicipio.BuscarID;
  Result := oModelMunicipio.Inserir(AMunicipio);
end;



function TMunicipioControlerInserirAlterar.VerificarMunicipio(
  AMunicipio: TMunicipioDto): Boolean;
begin
  Result := oModelMunicipio.VerificarMunicipio(AMunicipio);
end;

end.
