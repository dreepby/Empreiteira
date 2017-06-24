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

function TProdutoModel.ADDListaHash(var oProduto
  : TObjectDictionary<string, TProdutoDto>): Boolean;
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
        oProdutoDTO.idProduto := oQuery.FieldByName('idProduto').AsInteger;
        oProdutoDTO.Descricao := oQuery.FieldByName('Descricao').AsString;
        oProdutoDTO.Preco := oQuery.FieldByName('Preco').AsString;

        // Adiciona o objeto na lista hash
        oProduto.Add(oProdutoDTO.Descricao, oProdutoDTO);

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
var
  i, iCount: Integer;
  sSql: String;
  iCodigos: Array of Integer;
  oQuery: TFDQuery;
  bValida: Boolean;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open
      ('SELECT idProduto_Ambiente FROM produto_ambiente WHERE Produto_idProduto = '
      + IntToStr(AIDProduto));
    if (not(oQuery.IsEmpty)) then
    begin
      SetLength(iCodigos, oQuery.RecordCount);
      iCount := 0;
      oQuery.First;
      while (not(oQuery.Eof)) do
      begin
        iCodigos[iCount] := oQuery.FieldByName('idProduto_Ambiente').AsInteger;
        oQuery.Next;
        if not(oQuery.Eof) then
          iCount := +1;
      end;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
  for i := 0 to iCount do
  begin
    bValida := TSingletonConexao.GetInstancia.ExecSQL
      ('delete from produto_ambiente where idProduto_ambiente = ' +
      IntToStr(iCodigos[i])) > 0;

    if bValida = False then
      exit;
  end;
  if bValida then
  begin
    Result := TSingletonConexao.GetInstancia.ExecSQL
      ('delete from produto where idProduto = ' + IntToStr(AIDProduto)) > 0;
  end;
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

begin

  sSql := 'insert into Produto (idProduto, Descricao, Preco) values (' +
    IntToStr(AProduto.idProduto) + ',' + QuotedStr(AProduto.Descricao) + ', ' +
    AProduto.Preco + ')';

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
  aDados: array of Integer;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select p.idproduto from produto p  ' +
      'inner join ProdutoReforma pr on pr.produto_idproduto = p.idproduto');
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
