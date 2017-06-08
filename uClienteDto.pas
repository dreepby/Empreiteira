unit uClienteDto;

interface

uses
  uBairroDto, System.SysUtils, uEstadoDto, uMunicipioDto;

type
  TClienteDto = class
  private
    FObservacao: String;
    FCnpj: String;
    FoBairro: TBairroDto;
    FCpf: String;
    FCep: String;
    FNumero: Integer;
    FComplemento: String;
    FidCliente: Integer;
    FTelefone: String;
    FRua: String;
    FCelular: String;
    FNome: String;
    FoEstado: TEstadoDto;
    FoMunicipio: TMunicipioDto;
    procedure SetCelular(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetCnpj(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetCpf(const Value: String);
    procedure SetidCliente(const Value: Integer);
    procedure SetNumero(const Value: Integer);
    procedure SetoBairro(const Value: TBairroDto);
    procedure SetObservacao(const Value: String);
    procedure SetRua(const Value: String);
    procedure SetTelefone(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetoEstado(const Value: TEstadoDto);
    procedure SetoMunicipio(const Value: TMunicipioDto);
  public
    property idCliente: Integer read FidCliente write SetidCliente;
    property Nome: String read FNome write SetNome;
    property Cpf: String read FCpf write SetCpf;
    property Cnpj: String read FCnpj write SetCnpj;
    property Telefone: String read FTelefone write SetTelefone;
    property Celular: String read FCelular write SetCelular;
    property Observacao: String read FObservacao write SetObservacao;
    property Rua: String read FRua write SetRua;
    property Numero: Integer read FNumero write SetNumero;
    property Complemento: String read FComplemento write SetComplemento;
    property Cep: String read FCep write SetCep;
    property oBairro: TBairroDto read FoBairro write SetoBairro;
    property oMunicipio: TMunicipioDto read FoMunicipio write SetoMunicipio;
    property oEstado: TEstadoDto read FoEstado write SetoEstado;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TClienteDto }

constructor TClienteDto.Create;
begin
  FoBairro := TBairroDto.Create;
  FoMunicipio := TMunicipioDto.Create;
  FoEstado := TEstadoDto.Create;
end;

destructor TClienteDto.Destroy;
begin
  if (Assigned(FoBairro)) then
    FreeAndNil(FoBairro);

  if (Assigned(FoMunicipio)) then
    FreeAndNil(FoMunicipio);

  if (Assigned(FoEstado)) then
    FreeAndNil(FoEstado);
  inherited;
end;

procedure TClienteDto.SetCelular(const Value: String);
begin
  FCelular := Value;
end;

procedure TClienteDto.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TClienteDto.SetCnpj(const Value: String);
begin
  FCnpj := Value;
end;

procedure TClienteDto.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TClienteDto.SetCpf(const Value: String);
begin
  FCpf := Value;
end;

procedure TClienteDto.SetidCliente(const Value: Integer);
begin
  FidCliente := Value;
end;

procedure TClienteDto.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TClienteDto.SetNumero(const Value: Integer);
begin
  FNumero := Value;
end;

procedure TClienteDto.SetoBairro(const Value: TBairroDto);
begin
  FoBairro := Value;
end;

procedure TClienteDto.SetObservacao(const Value: String);
begin
  FObservacao := Value;
end;

procedure TClienteDto.SetoEstado(const Value: TEstadoDto);
begin
  FoEstado := Value;
end;

procedure TClienteDto.SetoMunicipio(const Value: TMunicipioDto);
begin
  FoMunicipio := Value;
end;

procedure TClienteDto.SetRua(const Value: String);
begin
  FRua := Value;
end;

procedure TClienteDto.SetTelefone(const Value: String);
begin
  FTelefone := Value;
end;

end.
