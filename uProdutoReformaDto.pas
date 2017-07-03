unit uProdutoReformaDto;

interface

uses
  System.SysUtils, uProdutoDto, uAmbienteReformaDto;

type
  TProdutoReformaDto = class
  private
    FObservacao: String;
    FoProduto: TProdutoDto;
    FTotal: String;
    Fid: Integer;
    FQuantidade: Integer;
    FoAmbienteReforma: TAmbienteReformaDto;
    procedure Setid(const Value: Integer);
    procedure SetObservacao(const Value: String);
    procedure SetoProduto(const Value: TProdutoDto);
    procedure SetQuantidade(const Value: Integer);
    procedure SetTotal(const Value: String);
    procedure SetoAmbienteReforma(const Value: TAmbienteReformaDto);
  public
    property id: Integer read Fid write Setid;
    property Quantidade: Integer read FQuantidade write SetQuantidade;
    property Total: String read FTotal write SetTotal;
    property Observacao: String read FObservacao write SetObservacao;
    property oProduto: TProdutoDto read FoProduto write SetoProduto;
    property oAmbienteReforma: TAmbienteReformaDto read FoAmbienteReforma
      write SetoAmbienteReforma;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TProdutoReformaDto }

constructor TProdutoReformaDto.Create;
begin
  FoProduto := TProdutoDto.Create;
  FoAmbienteReforma := TAmbienteReformaDto.Create;
end;

destructor TProdutoReformaDto.Destroy;
begin
  if Assigned(FoProduto) then
    FreeAndNil(FoProduto);

  if Assigned(FoAmbienteReforma) then
    FreeAndNil(FoAmbienteReforma);
  inherited;
end;

procedure TProdutoReformaDto.Setid(const Value: Integer);
begin
  Fid := Value;
end;

procedure TProdutoReformaDto.SetoAmbienteReforma(const Value
  : TAmbienteReformaDto);
begin
  FoAmbienteReforma := Value;
end;

procedure TProdutoReformaDto.SetObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TProdutoReformaDto.SetoProduto(const Value: TProdutoDto);
begin
  FoProduto := Value;
end;

procedure TProdutoReformaDto.SetQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
end;

procedure TProdutoReformaDto.SetTotal(const Value: String);
begin
  FTotal := Value;
end;

end.
