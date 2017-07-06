unit uRelatorioModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, System.Generics.Collections, uClassSingletonConexao;

type
  TRelatorioModel = class
  private
    oQueryListarRelatorio: TFDQuery;
  public
    function ListarRelatorio(var DsTabela: TDataSource; ASql: String; var MemTable: TFDMemTable): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

constructor TRelatorioModel.Create;
begin
  oQueryListarRelatorio := TFDQuery.Create(nil);
end;

destructor TRelatorioModel.Destroy;
begin
  oQueryListarRelatorio.Close;

  if Assigned(oQueryListarRelatorio) then
    FreeAndNil(oQueryListarRelatorio);
  inherited;
end;

function TRelatorioModel.ListarRelatorio(var DsTabela: TDataSource;
  ASql: String; var MemTable: TFDMemTable): Boolean;
var
  Sql: String;
begin
  if Length(ASql) > 0 then
  begin
    Sql := 'select r.idReforma, c.nome as cliente, c.cpfcnpj, r.datadopedido,'
      + ' r.datadeentrega, (select COUNT(idAmbienteReforma) from Ambientereforma'
      + ' where ambiente_idReforma = r.idReforma) as ambiente, r.total  as ' +
      'totalpedido, CONCAT("Rua: ",c.rua," Nº ", c.numero,", ",b.Nome, ", ",m.Nome, '
      + '" - ", u.uf) as local from reforma r inner join cliente c on ' +
      'r.pedinte_idCliente = c.idcliente inner join bairro b on c.cliente_idbairro '
      + '= b.idbairro inner join municipio m on b.bairro_idMunicipio = m.idMunicipio '
      + 'inner join uf u on m.Municipio_idUF = u.idUF ' + ASql;
  end
  else
  begin
    Sql := 'select r.idReforma, c.nome as cliente, c.cpfcnpj, r.datadopedido,'
      + ' r.datadeentrega, (select COUNT(idAmbienteReforma) from Ambientereforma'
      + ' where ambiente_idReforma = r.idReforma) as ambiente, r.total  as ' +
      'totalpedido, CONCAT("Rua: ",c.rua," Nº ", c.numero,", ",b.Nome, ", ",m.Nome, '
      + '" - ", u.uf) as local from reforma r inner join cliente c on ' +
      'r.pedinte_idCliente = c.idcliente inner join bairro b on c.cliente_idbairro '
      + '= b.idbairro inner join municipio m on b.bairro_idMunicipio = m.idMunicipio '
      + 'inner join uf u on m.Municipio_idUF = u.idUF ';
  end;
  oQueryListarRelatorio.Connection := TSingletonConexao.GetInstancia;
  oQueryListarRelatorio.Filtered := False;
  oQueryListarRelatorio.Open(Sql);
  DsTabela.DataSet := oQueryListarRelatorio;
  MemTable.Data := oQueryListarRelatorio.Data;
  Result := oQueryListarRelatorio.IsEmpty;
end;

end.
