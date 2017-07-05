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
    function BuscarRegistro(const ACodigoAmbienteReforma: Integer;
      var oListaProdutosReforma: TObjectDictionary<Integer,
      TProdutoReformaDto>): Boolean;
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

function TProdutoReformaModel.BuscarRegistro(const ACodigoAmbienteReforma
  : Integer; var oListaProdutosReforma: TObjectDictionary<Integer,
  TProdutoReformaDto>): Boolean;
var
  oProdutoReformaDTO: TProdutoReformaDto;
  oQuery: TFDQuery;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select pr.idProdutoReforma, pr.Quantidade, pr.Total, ' +
      'pr.Observacao, pr.Produto_idProduto, p.Descricao as produto, pr.PrecoUni, ar.Ambiente_idAmbientes from '
      + 'produtoReforma pr inner join produto p on pr.produto_idProduto = ' +
      'p.idproduto inner join AmbienteReforma ar on ' +
      'pr.AmbienteReforma_idAmbienteReforma = ar.idAmbienteReforma where pr.AmbienteReforma_idAmbienteReforma = '
      + IntToStr(ACodigoAmbienteReforma));

    if (not(oQuery.IsEmpty)) then
    begin
      oQuery.First;
      while (not(oQuery.Eof)) do
      begin
        // Instancia do objeto
        oProdutoReformaDTO := TProdutoReformaDto.Create;

        // Atribui os valores
        oProdutoReformaDTO.id := oQuery.FieldByName('idProdutoReforma')
          .AsInteger;
        oProdutoReformaDTO.Quantidade := oQuery.FieldByName('Quantidade')
          .AsInteger;
        oProdutoReformaDTO.Total :=
          CurrToStr(Round(oQuery.FieldByName('Total').AsCurrency * 100) / 100);
        oProdutoReformaDTO.Observacao :=
          oQuery.FieldByName('Observacao').AsString;
        oProdutoReformaDTO.oProduto.idProduto :=
          oQuery.FieldByName('Produto_idProduto').AsInteger;
        oProdutoReformaDTO.oProduto.Descricao :=
          oQuery.FieldByName('produto').AsString;
        oProdutoReformaDTO.oAmbienteReforma.oAmbiente.idAmbiente :=
          oQuery.FieldByName('Ambiente_idAmbientes').AsInteger;
        oProdutoReformaDTO.PrecoUni :=
          CurrToStr(Round(oQuery.FieldByName('PrecoUni').AsCurrency *
          100) / 100);

        // Adiciona o objeto na lista hash
        oListaProdutosReforma.Add(oProdutoReformaDTO.oProduto.idProduto,
          oProdutoReformaDTO);

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
  sSql := 'insert into ProdutoReforma (idProdutoReforma, Quantidade, total, observacao, Produto_idProduto, AmbienteReforma_idAmbienteReforma, PrecoUni) values ('
    + IntToStr(AProdutoReforma.id) + ', ' + IntToStr(AProdutoReforma.Quantidade)
    + ', ' + QuotedStr(AProdutoReforma.Total) + ', ' +
    QuotedStr(AProdutoReforma.Observacao) + ', ' +
    IntToStr(AProdutoReforma.oProduto.idProduto) + ', ' +
    IntToStr(AProdutoReforma.oAmbienteReforma.IdAmbienteReforma) + ', ' +
    QuotedStr(AProdutoReforma.PrecoUni) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

end.
