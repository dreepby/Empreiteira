unit uProdutoModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uProdutoDto, uClassSingletonConexao,
  uProdutoInterfaceModel, System.Generics.Collections;

type
  TProdutoModel = class(TInterfacedObject, IModelProdutoInterface)
  private
    oQueryListarProdutos: TFDQuery;
  public
    function BuscarID: Integer;
    function Alterar(var AProduto: TProdutoDto): Boolean;
    function Inserir(var AProduto: TProdutoDto): Boolean;
    procedure ListarProdutos(var DsProduto: TDataSource);
    function Deletar(const AIDProduto: Integer): Boolean;
    function VerificarProduto(AProduto: TProdutoDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Localizar(ATexto: String): Boolean;
    function BuscarProduto(AProduto: TProdutoDto): Boolean;
    function ADDListaHash(var oProduto: TObjectDictionary<string,
      TProdutoDto>): Boolean;
    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TProdutoModel }

function TProdutoModel.ADDListaHash(
  var oProduto: TObjectDictionary<string, TProdutoDto>): Boolean;
var
  oProdutoDTO: TProdutoDto;
  oQuery: TFDQuery;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select idProduto, Descricao, Preco from Produto');

    if (not(oQuery.IsEmpty)) then
    begin
      oQuery.First;
      while (not(oQuery.Eof)) do
      begin
        // Instancia do objeto
        oProdutoDTO := TProdutoDto.Create;

        // Atribui os valores
        oProdutoDTO.idProduto := oQuery.FieldByName('idProduto')
          .AsInteger;
        oProdutoDTO.Descricao := oQuery.FieldByName('Descricao').AsString;
        oProdutoDTO.Preco := oQuery.FieldByName('Preco')
          .AsString;

        // Adiciona o objeto na lista hash
        oProduto.Add(oProdutoDTO.Descricao, oProdutoDto);

        // Vai para o próximo registro
        oQuery.Next;
      end;
      Result := True;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;

end;

function TProdutoModel.Alterar(var AProduto: TProdutoDto): Boolean;
var
  sSql: String;
begin
  sSql := 'update produto set Descricao = ' + QuotedStr(AProduto.Descricao) +
    '     , Preco = ' + (AProduto.Preco) + ' where idProduto = ' +
    IntToStr(AProduto.idProduto);

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

function TProdutoModel.BuscarID: Integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(IdProduto) as ID' + '  from Produto');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;

end;

function TProdutoModel.BuscarProduto(AProduto: TProdutoDto): Boolean;
var
  oQuery: TFDQuery;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select Descricao, Preco from Produto where idProduto =' +
      IntToStr(AProduto.idProduto));
    if (not(oQuery.IsEmpty)) then
    begin
      Result := True;
      AProduto.Descricao := oQuery.FieldByName('Descricao').AsString;
      AProduto.Preco := oQuery.FieldByName('Preco').AsString;
    end;

  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;

end;

constructor TProdutoModel.Create;
begin
  oQueryListarProdutos := TFDQuery.Create(nil);
end;

function TProdutoModel.Deletar(const AIDProduto: Integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from produto where idProduto = ' + IntToStr(AIDProduto)) > 0;
end;

destructor TProdutoModel.Destroy;
begin
  oQueryListarProdutos.Close;

  if Assigned(oQueryListarProdutos) then
    FreeAndNil(oQueryListarProdutos);

  inherited;
end;

function TProdutoModel.Inserir(var AProduto: TProdutoDto): Boolean;
var
  sSql: String;
  Preco: String;
begin
  sSql := 'insert into Produto (idProduto, Descricao, Preco) values (' +
    IntToStr(AProduto.idProduto) + ',' + QuotedStr(AProduto.Descricao) + ', ' +
    Preco + ');';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;

end;

procedure TProdutoModel.ListarProdutos(var DsProduto: TDataSource);
begin
  oQueryListarProdutos.Connection := TSingletonConexao.GetInstancia;
  oQueryListarProdutos.Open
    ('select idproduto, descricao, CONCAT("R$ ",Preco) as Preco from Produto');
  DsProduto.DataSet := oQueryListarProdutos;
end;

function TProdutoModel.Localizar(ATexto: String): Boolean;
begin

end;

function TProdutoModel.VerificarExcluir(AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select pa.idProduto_Ambiente from produto_ambiente pa  ' +
      'inner join produto p on p.idProduto = pa.Produto_idProduto and p.idProduto = '
      + IntToStr(AId) +
      ' left join produtoreforma pr on pr.Produto_idProduto = p.idProduto');
    if (oQuery.IsEmpty) then
      Result := True
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TProdutoModel.VerificarProduto(AProduto: TProdutoDto;
  out AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select idProduto from Produto where idProduto=' +
      (IntToStr(AProduto.idProduto)));
    if (not(oQuery.IsEmpty)) then
    begin
      AId := oQuery.FieldByName('IdProduto').AsInteger;
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
