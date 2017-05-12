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
    procedure ListarMunicipios(var DsEstado: TDataSource);
    function Excluir(id: Integer): Boolean;
    function Pesquisar(ANome : String): Boolean;
    procedure AbrirMunicipioUpdate(AMunicipio: TMunicipioDto);

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

procedure TMunicipioControler.AbrirMunicipioUpdate(AMunicipio: TMunicipioDto);
begin
  if (not(Assigned(frmMunicipio))) then
    frmMunicipio := TfrmMunicipio.Create(nil);
  frmMunicipio.Caption := 'Alteração de Municipio';
  frmMunicipio.Panel3.Caption := 'Alterar';
  frmMunicipio.edtNome.Text := AMunicipio.Nome;
  frmMunicipio.cbUf.ItemIndex := frmMunicipio.cbUf.Items.IndexOf(AMunicipio.nomeUf);
  frmMunicipio.oMunicipio.idMunicipio := AMunicipio.idMunicipio;
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

function TMunicipioControler.Excluir(id: Integer): Boolean;
begin
  if id > 0 then
    Result := oModelMunicipio.Deletar(id)
  else
    Result := False;
end;

procedure TMunicipioControler.Limpar(var AMunicipio: TMunicipioDto);
begin
  AMunicipio.idMunicipio := 0;
  AMunicipio.Nome := EmptyStr;
  AMunicipio.idUf := 0;
end;

procedure TMunicipioControler.ListarMunicipios(var DsEstado: TDataSource);
begin
  oModelMunicipio.ListarMunicipios(DsEstado);
end;

function TMunicipioControler.Pesquisar(ANome: String): Boolean;
begin
  Result := oModelMunicipio.Pesquisar(ANome);
end;

end.
