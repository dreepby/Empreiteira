unit uProdutoReformaModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, System.Generics.Collections,
  uProdutoReformaDto, uClassSingletonConexao, uProdutoReformaInterfaceModel;

type
  TProdutoReformaModel = class(TInterfacedObject, IModelProdutoReformaInterface)
  public
    function BuscarID: Integer;
    function Inserir(var AProdutoReforma: TProdutoReformaDto): Boolean;
    procedure Deletar(const ACodigoAmbienteReforma: Integer);
  end;

implementation

{ TProdutoReformaModel }

function TProdutoReformaModel.BuscarID: Integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(IdProdutoReforma) as ID from ProdutoReforma');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

procedure TProdutoReformaModel.Deletar(const ACodigoAmbienteReforma: Integer);
begin
  TSingletonConexao.GetInstancia.ExecSQL
    ('delete from ProdutoReforma where AmbienteReforma_idAmbienteReforma = ' +
    IntToStr(ACodigoAmbienteReforma));
end;

function TProdutoReformaModel.Inserir(var AProdutoReforma
  : TProdutoReformaDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into ProdutoReforma (idProdutoReforma, Quantidade, total, observacao, Produto_idProduto, AmbienteReforma_idAmbienteReforma) values ('
    + IntToStr(AProdutoReforma.id) + ', ' + IntToStr(AProdutoReforma.Quantidade)
    + ', ' + QuotedStr(AProdutoReforma.Total) + ', ' +
    QuotedStr(AProdutoReforma.Observacao) + ', ' +
    IntToStr(AProdutoReforma.oProduto.idProduto) + ', ' +
    IntToStr(AProdutoReforma.oAmbienteReforma.IdAmbienteReforma) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

end.
