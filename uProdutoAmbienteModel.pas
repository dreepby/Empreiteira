unit uProdutoAmbienteModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, System.Generics.Collections,
  uProdutoAmbienteDto, uClassSingletonConexao, uProdutoAmbienteInterfaceModel;

type
  TProdutoAmbienteModel = class(TInterfacedObject,
    IModelProdutoAmbienteInterface)
  public
    function Inserir(var AProdutoAmbiente: TProdutoAmbienteDto): Boolean;
    function VerificarExcluir(AId: integer): Boolean;
    function Deletar(const AProdutoAmbiente: integer): Boolean;
    function BuscarID: integer;
    function VerificarProdutoAmbiente(AProdutoAmbiente: TProdutoAmbienteDto;
      out AId: integer): Boolean;

  end;

implementation

{ TProdutoAmbienteModel }

function TProdutoAmbienteModel.BuscarID: integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(idProduto_Ambiente) as ID from Produto_Ambiente');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TProdutoAmbienteModel.Deletar(const AProdutoAmbiente: integer)
  : Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from Produto_Ambiente where idProduto_Ambiente = ' +
    IntToStr(AProdutoAmbiente)) > 0;
end;

function TProdutoAmbienteModel.Inserir(var AProdutoAmbiente
  : TProdutoAmbienteDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into ProdutoAmbiente (idProduto_Ambiente, Produto_IdProduto, Produto_IdAmbientes) values ('
    + IntToStr(AProdutoAmbiente.IdProduto) + ', ' + QuotedStr(AProdutoAmbiente.oProduto.idProduto) + ', ' +
    QuotedStr(AProdutoAmbiente.oAmbiente.idAmbiente) + ')';
end;

function TProdutoAmbienteModel.VerificarExcluir(AId: integer): Boolean;
begin

end;

function TProdutoAmbienteModel.VerificarProdutoAmbiente(AProdutoAmbiente
  : TProdutoAmbienteDto; out AId: integer): Boolean;
begin

end;

end.
