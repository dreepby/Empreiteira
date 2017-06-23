unit uProdutoAmbienteDto;

interface

uses
  System.Classes, System.SysUtils, uProdutoDto, uAmbienteDto;

type
  TProdutoAmbienteDto = class
  private
    FoProduto: TProdutoDto;
    FIdProdutoAmbiente: Integer;
    FoAmbiente: TAmbienteDto;

    procedure SetoAmbiente(const Value: TAmbienteDto);
    procedure SetoProduto(const Value: TProdutoDto);
    procedure SetIdProdutoAmbiente(const Value: Integer);
  public
    property IdProdutoAmbiente: Integer  read FIdProdutoAmbiente write SetIdProdutoAmbiente;
    property oProduto: TProdutoDto read FoProduto write SetoProduto;
    property oAmbiente: TAmbienteDto read FoAmbiente write SetoAmbiente;

    constructor Create;
    destructor Destroy; override;

  end;

implementation

{ TProdutoAmbienteDto }

constructor TProdutoAmbienteDto.Create;
begin
  FoProduto := TProdutoDto.Create;
  FoAmbiente := TAmbienteDto.Create;
end;

destructor TProdutoAmbienteDto.Destroy;
begin
  if Assigned(FoProduto) then
    FreeAndNil(FoProduto);

  if Assigned(FoAmbiente) then
    FreeAndNil(FoAmbiente);

  inherited;
end;





procedure TProdutoAmbienteDto.SetIdProdutoAmbiente(const Value: Integer);
begin
  FIdProdutoAmbiente := Value;
end;

procedure TProdutoAmbienteDto.SetoAmbiente(const Value: TAmbienteDto);
begin
  FoAmbiente := Value;
end;

procedure TProdutoAmbienteDto.SetoProduto(const Value: TProdutoDto);
begin
  FoProduto := Value;
end;

end.
