unit uBairrosControlerInserirAlterar;

interface

Uses
  System.SysUtils, Data.DB, System.Generics.Collections, uMunicipioDto,
  uBairrosModel, uBairrosDto, uMunicipioModel;

type
  TBairrosControlerInserirAlterar = class
  private
    oModelBairros: TBairrosModel;
    oModelMunicipio: TMunicipioModel;
  public
    procedure Limpar(var ABairros: TBairrosDto);
    function Salvar(var ABairros: TBairrosDto): Boolean;
    function Alterar(var ABairros: TBairrosDto): Boolean;
    function VerificarBairros(ABairros: TBairrosDto): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBairrosControlerInserirAlterar }

function TBairrosControlerInserirAlterar.Alterar(var ABairros
  : TBairrosDto): Boolean;
begin
  Result := oModelBairros.Alterar(ABairros);
end;

constructor TBairrosControlerInserirAlterar.Create;
begin
  oModelMunicipio := TMunicipioModel.Create;
  oModelBairros := TBairrosModel.Create;
end;

destructor TBairrosControlerInserirAlterar.Destroy;
begin

  if Assigned(oModelMunicipio) then
    FreeAndNil(oModelMunicipio);

  if Assigned(oModelBairros) then
    FreeAndNil(oModelBairros);
  inherited;
  inherited;
end;

procedure TBairrosControlerInserirAlterar.Limpar(var ABairros: TBairrosDto);
begin
  ABairros.idBairro := 0;
  ABairros.Nome := EmptyStr;
  ABairros.idMunicipio := 0;
end;

function TBairrosControlerInserirAlterar.Salvar(var ABairros
  : TBairrosDto): Boolean;
begin
  ABairros.idBairro := oModelBairros.BuscarID;
  Result := oModelBairros.Inserir(ABairros);
end;

function TBairrosControlerInserirAlterar.VerificarBairros
  (ABairros: TBairrosDto): Boolean;
begin
  Result := oModelBairros.VerificarBairro(ABairros);
end;

end.
