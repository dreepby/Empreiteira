unit uMunicipioModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uMunicipioDto, uClassSingletonConexao;

type
  TMunicipioModel = class
  private

  public
    function BuscarID: Integer;
    function Alterar(var AMunicipio: TMunicipioDto): Boolean;
    function Inserir(var AMunicipio: TMunicipioDto): Boolean;
  end;

implementation

{ TMunicipioModel }

function TMunicipioModel.Alterar(var AMunicipio: TMunicipioDto): Boolean;
var
  sSql: String;
begin
  sSql := 'update municipio set nome = ' + QuotedStr(AMunicipio.Nome)
    + '     , municipio_idUf = ' + IntToStr(AMunicipio.idUf) +
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

function TMunicipioModel.Inserir(var AMunicipio: TMunicipioDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into municipio (idMunicipio, Nome, Municipio_idUF) values (' +
    IntToStr(AMunicipio.idMunicipio) + ', ' + QuotedStr(AMunicipio.Nome) + ', ' +
    IntToStr(AMunicipio.idUf) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

end.
