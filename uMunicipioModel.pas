unit uMunicipioModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uMunicipioDto, uClassSingletonConexao, System.Generics.Collections;

type
  TMunicipioModel = class
  private
    oQueryListarMunicipios: TFDQuery;
  public
    function BuscarID: Integer;
    function Alterar(var AMunicipio: TMunicipioDto): Boolean;
    function Inserir(var AMunicipio: TMunicipioDto): Boolean;
    procedure ListarMunicipios(var DsEstado: TDataSource);
    function Deletar(const AIDMunicipio: Integer): Boolean;
    function Pesquisar(ANome: String): Boolean;
    function VerificarMunicipio(AMunicipio: TMunicipioDto; out AId: integer): Boolean;
    function VerificarExcluir(AId: integer): Boolean;
    function ADDListaHash(var oMunicipio: TObjectDictionary<string,
      TMunicipioDto>): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TMunicipioModel }

function TMunicipioModel.ADDListaHash(
  var oMunicipio: TObjectDictionary<string, TMunicipioDto>): Boolean;
var
  oMunicipioDTO: TMunicipioDto;
  oQuery: TFDQuery;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select * from municipio');

    if (not(oQuery.IsEmpty)) then
    begin
      oQuery.First;
      while (not(oQuery.Eof)) do
      begin
        // Instancia do objeto
        oMunicipioDTO := TMunicipioDto.Create;

        // Atribui os valores
        oMunicipioDTO.idMunicipio := oQuery.FieldByName('idMunicipio').AsInteger;
        oMunicipioDTO.Nome := oQuery.FieldByName('Nome').AsString;
        oMunicipioDTO.oEstado.IdUF := oQuery.FieldByName('Municipio_idUF').AsInteger;

        // Adiciona o objeto na lista hash
        oMunicipio.Add(oMunicipioDTO.Nome, oMunicipioDTO);

        // Vai para o pr�ximo registro
        oQuery.Next;
      end;
      Result := True;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;

end;

function TMunicipioModel.Alterar(var AMunicipio: TMunicipioDto): Boolean;
var
  sSql: String;
begin
  sSql := 'update municipio set nome = ' + QuotedStr(AMunicipio.Nome) +
    '     , municipio_idUf = ' + IntToStr(AMunicipio.oEstado.IdUF) +
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

function TMunicipioModel.Deletar(const AIDMunicipio: Integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from municipio where idmunicipio = ' + IntToStr(AIDMunicipio)) > 0;
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
    + IntToStr(AMunicipio.oEstado.IdUF) + ')';

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

function TMunicipioModel.VerificarExcluir(AId: integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select idBairro from bairro where bairro_idMunicipio = ' + IntToStr(AId));
    if (oQuery.IsEmpty) then
      Result := True
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TMunicipioModel.VerificarMunicipio(AMunicipio: TMunicipioDto; out AId: integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select IdMunicipio from Municipio where Nome=' +
      QuotedStr(AMunicipio.Nome) + ' AND Municipio_idUF='+IntToStr(AMunicipio.oEstado.IdUF));
    if (not(oQuery.IsEmpty)) then
    begin
      AId := oQuery.FieldByName('IdMunicipio').AsInteger;
      Result := True;
    end
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

end.
