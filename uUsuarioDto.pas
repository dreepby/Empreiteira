unit uUsuarioDto;

interface

uses
  System.SysUtils;

type
  TUsuarioDto = class
  private
    FidUsuario: Integer;
    FNome: String;
    FCPF: string;
    procedure SetidUsuario(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetCPF(const Value: string);

  public
      property idUsuario: integer read FidUsuario write SetidUsuario;
      property Nome: string read FNome write SetNome;
      property CPF: string read FCPF write SetCPF;

  end;

implementation

{ TUsuarioDto }



procedure TUsuarioDto.SetCPF(const Value: string);
begin
  FCPF := Value;
end;

procedure TUsuarioDto.SetidUsuario(const Value: integer);
begin
  FidUsuario := Value;
end;

procedure TUsuarioDto.SetNome(const Value: string);
begin
  FNome := Value;
end;

end.
