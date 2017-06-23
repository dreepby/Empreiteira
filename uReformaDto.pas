unit uReformaDto;

interface

uses
  uClienteDto, uUsuarioDto, System.SysUtils;

type
  TReformaDto = class
  private
    FdataDeEntrega: TDate;
    FoEscritor: TUsuarioDto;
    Fobservacao: String;
    FoAtendente: TUsuarioDto;
    FidReforma: Integer;
    Ftotal: double;
    FoCliente: TClienteDto;
    FdataDoPedido: TDate;
    procedure SetdataDeEntrega(const Value: TDate);
    procedure SetdataDoPedido(const Value: TDate);
    procedure SetidReforma(const Value: Integer);
    procedure SetoAtendente(const Value: TUsuarioDto);
    procedure Setobservacao(const Value: String);
    procedure SetoCliente(const Value: TClienteDto);
    procedure SetoEscritor(const Value: TUsuarioDto);
    procedure Settotal(const Value: double);
  public
    property idReforma: Integer read FidReforma write SetidReforma;
    property observacao: String read Fobservacao write Setobservacao;
    property dataDoPedido: TDate read FdataDoPedido write SetdataDoPedido;
    property dataDeEntrega: TDate read FdataDeEntrega
      write SetdataDeEntrega;
    property oCliente: TClienteDto read FoCliente write SetoCliente;
    property oEscritor: TUsuarioDto read FoEscritor write SetoEscritor;
    property oAtendente: TUsuarioDto read FoAtendente write SetoAtendente;
    property total: double read Ftotal write Settotal;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TReformaDto }

constructor TReformaDto.Create;
begin
  FoEscritor := TUsuarioDto.Create;
  FoAtendente := TUsuarioDto.Create;
  FoCliente := TClienteDto.Create;
end;

destructor TReformaDto.Destroy;
begin
  if Assigned(FoEscritor) then
    FreeAndNil(FoEscritor);

  if Assigned(FoAtendente) then
    FreeAndNil(FoAtendente);

  if Assigned(FoCliente) then
    FreeAndNil(FoCliente);

  inherited;
end;

procedure TReformaDto.SetdataDeEntrega(const Value: TDate);
begin
  FdataDeEntrega := Value;
end;

procedure TReformaDto.SetdataDoPedido(const Value: TDate);
begin
  FdataDoPedido := Value;
end;

procedure TReformaDto.SetidReforma(const Value: Integer);
begin
  FidReforma := Value;
end;

procedure TReformaDto.SetoAtendente(const Value: TUsuarioDto);
begin
  FoAtendente := Value;
end;

procedure TReformaDto.Setobservacao(const Value: String);
begin
  Fobservacao := Value;
end;

procedure TReformaDto.SetoCliente(const Value: TClienteDto);
begin
  FoCliente := Value;
end;

procedure TReformaDto.SetoEscritor(const Value: TUsuarioDto);
begin
  FoEscritor := Value;
end;

procedure TReformaDto.Settotal(const Value: double);
begin
  Ftotal := Value;
end;

end.
