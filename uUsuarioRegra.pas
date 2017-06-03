unit uUsuarioRegra;

interface

uses

  System.SysUtils, uUsuarioDto, uUsuarioModel;

type
  TUsuarioRegra = class
  public
    procedure Limpar(AMunicipio: TUsuarioDto);
    function VerificarExcluir(var AModel: TUsuarioModel;
      AId: Integer): Boolean;
    function Deletar(var AModel: TUsuarioModel; AId: Integer): Boolean;
    function Pesquisar(var AModel: TUsuarioModel; ANome: String): Boolean;
    function Salvar(var AModel: TUsuarioModel;
      AMunicipio: TUsuarioDto): String;
  end;

implementation

{ TUsuarioRegra }

function TUsuarioRegra.Deletar(var AModel: TUsuarioModel;
  AId: Integer): Boolean;
begin

end;

procedure TUsuarioRegra.Limpar(AMunicipio: TUsuarioDto);
begin

end;

function TUsuarioRegra.Pesquisar(var AModel: TUsuarioModel;
  ANome: String): Boolean;
begin

end;

function TUsuarioRegra.Salvar(var AModel: TUsuarioModel;
  AMunicipio: TUsuarioDto): String;
begin

end;

function TUsuarioRegra.VerificarExcluir(var AModel: TUsuarioModel;
  AId: Integer): Boolean;
begin

end;

end.
