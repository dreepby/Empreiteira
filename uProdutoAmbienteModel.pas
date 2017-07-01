unit uProdutoAmbienteModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, System.Generics.Collections,
  uProdutoAmbienteDto, uClassSingletonConexao, uProdutoAmbienteInterfaceModel,
  uArrayAmbientes;

type
  TProdutoAmbienteModel = class(TInterfacedObject,
    IModelProdutoAmbienteInterface)
  public
    function Inserir(var AProdutoAmbiente: TProdutoAmbienteDto): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Deletar(const AProdutoAmbiente: Integer): Boolean;
    function BuscarID: Integer;
    function VerificarProdutoAmbiente(AProdutoAmbiente: TProdutoAmbienteDto;
      out AId: Integer): Boolean;
    procedure BuscarAmbientes(const ID: Integer;
      var oAmbientes: TAmbientesReformaArray);
  end;

implementation

{ TProdutoAmbienteModel }

procedure TProdutoAmbienteModel.BuscarAmbientes(const ID: Integer;
  var oAmbientes: TAmbientesReformaArray);
var
  iCount: Integer;
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open
      ('select pa.Ambientes_idAmbientes as ID from produto_ambiente pa where ' +
      ' pa.Produto_idProduto = ' + IntToStr(ID));
    if (not(oQuery.IsEmpty)) then
    begin
      SetLength(oAmbientes, oQuery.RecordCount);
      iCount := 0;
      oQuery.First;
      while (not(oQuery.Eof)) do
      begin
        oAmbientes[iCount] := oQuery.FieldByName('ID').AsInteger;
        oQuery.Next;
        if not(oQuery.Eof) then
          iCount := +1;
      end;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TProdutoAmbienteModel.BuscarID: Integer;
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

function TProdutoAmbienteModel.Deletar(const AProdutoAmbiente: Integer)
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

  sSql := 'insert into Produto_Ambiente (idProduto_Ambiente, Produto_IdProduto, Ambientes_IdAmbientes) values ('
    + IntToStr(AProdutoAmbiente.IdProdutoAmbiente) + ', ' +
    IntToStr(AProdutoAmbiente.oProduto.idProduto) + ', ' +
    IntToStr(AProdutoAmbiente.oAmbiente.idAmbiente) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;



function TProdutoAmbienteModel.VerificarExcluir(AId: Integer): Boolean;
begin

end;

function TProdutoAmbienteModel.VerificarProdutoAmbiente(AProdutoAmbiente
  : TProdutoAmbienteDto; out AId: Integer): Boolean;
begin

end;

end.
