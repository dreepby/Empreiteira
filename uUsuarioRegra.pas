unit uUsuarioRegra;

interface

uses

  System.SysUtils, uUsuarioDto, uUsuarioModel, uUsuarioIntefaceModel, Data.DB;

type
  TUsuarioRegra = class
  public
    procedure Limpar(AMunicipio: TUsuarioDto);
    procedure ListarUsuarios(const AModel: IModelUsuarioInterface;
      var dsTabela: TDataSource);
    function VerificarExcluir(const AModel: IModelUsuarioInterface;
      AId: Integer): Boolean;
    function Deletar(const AModel: IModelUsuarioInterface;
      AId: Integer): Boolean;
    function Pesquisar(const AModel: IModelUsuarioInterface;
      ANome: String): Boolean;
    function Salvar(const AModel: IModelUsuarioInterface;
      AMunicipio: TUsuarioDto): String;
  end;

implementation

{ TUsuarioRegra }

function TUsuarioRegra.Deletar(const AModel: IModelUsuarioInterface;
  AId: Integer): Boolean;
begin

end;

procedure TUsuarioRegra.Limpar(AMunicipio: TUsuarioDto);
begin

end;

procedure TUsuarioRegra.ListarUsuarios(const AModel: IModelUsuarioInterface;
  var dsTabela: TDataSource);
begin
  AModel.ListarUsuarios(DsTabela);
end;

function TUsuarioRegra.Pesquisar(const AModel: IModelUsuarioInterface;
  ANome: String): Boolean;
begin

end;

function TUsuarioRegra.Salvar(const AModel: IModelUsuarioInterface;
  AMunicipio: TUsuarioDto): String;
begin

end;

function TUsuarioRegra.VerificarExcluir(const AModel: IModelUsuarioInterface;
  AId: Integer): Boolean;
begin

end;

end.
