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
    function VerificarExcluir(AId: integer): Boolean;
    function Deletar(const ID: integer): Boolean;
    function BuscarID: integer;
    function VerificarProdutoAmbiente(AProdutoAmbiente: TProdutoAmbienteDto;
      out AId: integer): Boolean;
    procedure BuscarAmbientes(const ID: integer;
      var oAmbientes: TAmbientesReformaArray);
    function CompararAmbientesTabela(const IDP, IDA: integer): integer;
    function BuscarAmbientesArray(var AAmbientesArray: TAmbientesReformaArray;
      const ID: integer): Boolean;
  end;

implementation

{ TProdutoAmbienteModel }

procedure TProdutoAmbienteModel.BuscarAmbientes(const ID: integer;
  var oAmbientes: TAmbientesReformaArray);
var
  iCount: integer;
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
        iCount := iCount + 1;
        oQuery.Next;
      end;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TProdutoAmbienteModel.CompararAmbientesTabela(const IDP,
  IDA: integer): integer;

var
  oQuery: TFDQuery;
  sSql: String;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TSingletonConexao.GetInstancia;
  sSql := 'select idProduto_Ambiente from Produto_Ambiente where Produto_idProduto = '
    + IntToStr(IDP) + ' and ambientes_idAmbientes = ' + IntToStr(IDA);
  oQuery.Open(sSql);
  if (not(oQuery.IsEmpty)) then
    Result := oQuery.FieldByName('idProduto_Ambiente').AsInteger
  else
    Result := 0;

end;

function TProdutoAmbienteModel.BuscarAmbientesArray(var AAmbientesArray
  : TAmbientesReformaArray; const ID: integer): Boolean;
var
  iCount: integer;
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  oQuery.Connection := TSingletonConexao.GetInstancia;
  oQuery.Open
    ('select Ambientes_idAmbientes as ID from Produto_Ambiente where produto_idproduto = '
    + IntToStr(ID));
  if (not(oQuery.IsEmpty)) then
  begin
    SetLength(AAmbientesArray, oQuery.RecordCount);
    iCount := 0;
    oQuery.First;
    begin
      Result := True;
      while not(oQuery.Eof) do
      begin
        AAmbientesArray[iCount] := oQuery.FieldByName('ID').AsInteger;
        oQuery.Next;
        iCount := +1;
      end;
    end
  end
  else
    Result := False;

end;

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

function TProdutoAmbienteModel.Deletar(const ID: integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from Produto_Ambiente where Produto_idProduto = ' + IntToStr(ID)) > 0;
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

function TProdutoAmbienteModel.VerificarExcluir(AId: integer): Boolean;
begin

end;

function TProdutoAmbienteModel.VerificarProdutoAmbiente(AProdutoAmbiente
  : TProdutoAmbienteDto; out AId: integer): Boolean;
begin

end;

end.
