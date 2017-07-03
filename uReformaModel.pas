unit uReformaModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uReformaDto, uClassSingletonConexao,
  System.Generics.Collections, uReformaInterfaceModel;

type
  TReformaModel = class(TInterfacedObject, IModelReformaInterface)
  private
    oQueryListarReformas: TFDQuery;
  public
    function BuscarID: Integer;
    function Alterar(var AReforma: TReformaDto): Boolean;
    function Inserir(var AReforma: TReformaDto): Boolean;
    function ListarReformas(var DsTabela: TDataSource): Boolean;
    function Deletar(const AID: Integer): Boolean;
    function VerificarExcluir(AID: Integer): Boolean;
    function BuscarRegistro(var AReforma: TReformaDto): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TReformaModel }

function TReformaModel.Alterar(var AReforma: TReformaDto): Boolean;
begin

end;

function TReformaModel.BuscarID: Integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(IdReforma) as ID from Reforma');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TReformaModel.BuscarRegistro(var AReforma: TReformaDto): Boolean;
var
  oQuery: TFDQuery;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select r.observacao, r.datadopedido, r.datadeentrega, c.cpfcnpj, Escritor_idusuario, atendente_idusuario, total from Reforma r inner join cliente c on r.pedinte_idcliente = c.idcliente');
    if (not(oQuery.IsEmpty)) then
    begin
      Result := True;
      AReforma.observacao := oQuery.FieldByName('observacao').AsString;
      AReforma.dataDoPedido := oQuery.FieldByName('datadopedido').AsDateTime;
      AReforma.dataDeEntrega := oQuery.FieldByName('datadeentrega').AsDateTime;
      AReforma.oCliente.CpfCnpj := oQuery.FieldByName('cpfcnpj').AsString;
      AReforma.oEscritor.idUsuario := oQuery.FieldByName('Escritor_idusuario').AsInteger;
      AReforma.oAtendente.idUsuario := oQuery.FieldByName('atendente_idusuario').AsInteger;
      AReforma.Total := oQuery.FieldByName('Total').AsString;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

constructor TReformaModel.Create;
begin
  oQueryListarReformas := TFDQuery.Create(nil);
end;

function TReformaModel.Deletar(const AID: Integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from reforma where idreforma = ' + IntToStr(AID)) > 0;
end;

destructor TReformaModel.Destroy;
begin
  oQueryListarReformas.Close;

  if Assigned(oQueryListarReformas) then
    FreeAndNil(oQueryListarReformas);

  inherited;
end;

function TReformaModel.Inserir(var AReforma: TReformaDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into reforma (idReforma, observacao, datadopedido, datadeentrega,'
    + ' pedinte_idCliente, escritor_idusuario, atendente_idUsuario, total) values ('
    + IntToStr(AReforma.idReforma) + ', ' + QuotedStr(AReforma.observacao) +
    ', ' + QuotedStr(FormatDateTime('yyyy/mm/dd', AReforma.dataDoPedido)) + ', '
    + QuotedStr(FormatDateTime('yyyy/mm/dd', AReforma.dataDeEntrega)) + ', ' +
    IntToStr(AReforma.oCliente.idCliente) + ', ' +
    IntToStr(AReforma.oEscritor.idUsuario) + ', ' +
    IntToStr(AReforma.oAtendente.idUsuario) + ', ' +
    QuotedStr(AReforma.Total) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

function TReformaModel.ListarReformas(var DsTabela: TDataSource): Boolean;
begin
  oQueryListarReformas.Connection := TSingletonConexao.GetInstancia;
  oQueryListarReformas.Open
    ('SELECT r.idReforma , r.DataDoPedido , r.DataDeEntrega, c.nome as cliente, CONCAT("R$ ", r.Total) as total, r.observacao  from reforma r INNER JOIN cliente c ON pedinte_idcliente = c.idCliente ');
  DsTabela.DataSet := oQueryListarReformas;
  Result := oQueryListarReformas.IsEmpty;
end;

function TReformaModel.VerificarExcluir(AID: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open
      ('select idAmbienteReforma from AmbienteReforma where ambiente_idReforma = '
      + IntToStr(AID));
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
