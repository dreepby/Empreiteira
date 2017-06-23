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
    function Alterar(var AReforma: TReformaDto;
      AAmbientes: Array of Integer): Boolean;
    function Inserir(var AReforma: TReformaDto;
      AAmbientes: Array of Integer): Boolean;
    procedure ListarReformas(var DsTabela: TDataSource);
    function Deletar(const AID: Integer): Boolean;
    function Pesquisar(ANome: String): Boolean;
    function VerificarExcluir(AID: Integer): Boolean;
    function ADDListaHash(var oReforma: TObjectDictionary<string, TReformaDto>;
      const AID: Integer): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TReformaModel }

function TReformaModel.ADDListaHash(var oReforma
  : TObjectDictionary<string, TReformaDto>; const AID: Integer): Boolean;
begin

end;

function TReformaModel.Alterar(var AReforma: TReformaDto;
  AAmbientes: Array of Integer): Boolean;
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

constructor TReformaModel.Create;
begin
  oQueryListarReformas := TFDQuery.Create(nil);
end;

function TReformaModel.Deletar(const AID: Integer): Boolean;
begin

end;

destructor TReformaModel.Destroy;
begin
  oQueryListarReformas.Close;

  if Assigned(oQueryListarReformas) then
    FreeAndNil(oQueryListarReformas);

  inherited;
end;

function TReformaModel.Inserir(var AReforma: TReformaDto;
  AAmbientes: Array of Integer): Boolean;
begin

end;

procedure TReformaModel.ListarReformas(var DsTabela: TDataSource);
begin
  oQueryListarReformas.Connection := TSingletonConexao.GetInstancia;
  oQueryListarReformas.Open
    ('SELECT r.idReforma , r.DataDoPedido , r.DataDeEntrega, c.nome as cliente, CONCAT("R$ ", r.Total) as total, r.observacao  from reforma r INNER JOIN cliente c ON pedinte_idcliente = c.idCliente ');
  DsTabela.DataSet := oQueryListarReformas;
end;

function TReformaModel.Pesquisar(ANome: String): Boolean;
begin

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
