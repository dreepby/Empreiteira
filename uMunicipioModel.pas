unit uMunicipioModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uMunicipioDto, uClassSingletonConexao;

type
  TMunicipioModel = class
  private
    oQueryListarMunicipios: TFDQuery;
  public
    function BuscarID: Integer;
    function Alterar(var AMunicipio: TMunicipioDto): Boolean;
    function Inserir(var AMunicipio: TMunicipioDto): Boolean;
    procedure ListarMunicipios(var DsEstado: TDataSource);
    function Deletar(const AIDUF: Integer): Boolean;
    function Pesquisar(ANome: String): Boolean;
    function VerificarMunicipio(AMunicipio: TMunicipioDto): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TMunicipioModel }

function TMunicipioModel.Alterar(var AMunicipio: TMunicipioDto): Boolean;
var
  sSql: String;
begin
  sSql := 'update municipio set nome = ' + QuotedStr(AMunicipio.Nome) +
    '     , municipio_idUf = ' + IntToStr(AMunicipio.idUf) +
    ' where idMunicipio = ' + IntToStr(AMunicipio.idMunicipio);

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

function TMunicipioModel.BuscarID: Integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(IdMunicipio) as ID' + '  from Municipio');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

constructor TMunicipioModel.Create;
begin
  oQueryListarMunicipios := TFDQuery.Create(nil);
end;

function TMunicipioModel.Deletar(const AIDUF: Integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from municipio where idmunicipio = ' + IntToStr(AIDUF)) > 0;
end;

destructor TMunicipioModel.Destroy;
begin
  oQueryListarMunicipios.Close;

  if Assigned(oQueryListarMunicipios) then
    FreeAndNil(oQueryListarMunicipios);
  inherited;
end;

function TMunicipioModel.Inserir(var AMunicipio: TMunicipioDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into municipio (idMunicipio, Nome, Municipio_idUF) values (' +
    IntToStr(AMunicipio.idMunicipio) + ', ' + QuotedStr(AMunicipio.Nome) + ', '
    + IntToStr(AMunicipio.idUf) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

procedure TMunicipioModel.ListarMunicipios(var DsEstado: TDataSource);
begin
  oQueryListarMunicipios.Connection := TSingletonConexao.GetInstancia;
  oQueryListarMunicipios.Open
    ('select m.idMunicipio, m.Nome,u.nome as estado from municipio as m inner join uf as u on m.Municipio_idUF=u.iduf');
  DsEstado.DataSet := oQueryListarMunicipios;
end;

function TMunicipioModel.Pesquisar(ANome: String): Boolean;
begin
  oQueryListarMunicipios.Open
    ('select m.idMunicipio, m.Nome,u.nome as estado from municipio as m inner join uf as u on m.Municipio_idUF=u.iduf WHERE m.Nome LIKE "%'
    + ANome + '%"');
  if (not(oQueryListarMunicipios.IsEmpty)) then
  begin
    Result := True;
  end
  else
  begin
    Result := False;
    oQueryListarMunicipios.Open
      ('select m.idMunicipio, m.Nome,u.nome as estado from municipio as m inner join uf as u on m.Municipio_idUF=u.iduf');
  end;
end;

function TMunicipioModel.VerificarMunicipio(AMunicipio: TMunicipioDto): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select IdMunicipio from Municipio where Nome=' +
      QuotedStr(AMunicipio.Nome) + ' AND Municipio_idUF='+IntToStr(AMunicipio.idUf));
    if (oQuery.IsEmpty) then
      Result := True
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

end.
