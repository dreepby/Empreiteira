unit uProdutoDto;

interface

type
  TProdutoDto = class
  private
    FidProduto: integer;
    FDescricao: String;
    FPreco: String;
    procedure SetDescricao(const Value: String);
    procedure SetidProduto(const Value: integer);
    procedure SetPreco(const Value: String);

  public
    property idProduto: integer read FidProduto write SetidProduto;
    property Descricao: String read FDescricao write SetDescricao;
    property Preco: String read FPreco write SetPreco;


  end;

implementation

{ TProdutoDto }

procedure TProdutoDto.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TProdutoDto.SetidProduto(const Value: integer);
begin
  FidProduto := Value;
end;

procedure TProdutoDto.SetPreco(const Value: String);
begin
  FPreco := Value;
end;

end.
