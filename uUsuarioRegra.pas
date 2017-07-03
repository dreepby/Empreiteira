unit uUsuarioRegra;

interface

uses

  System.SysUtils, uUsuarioDto, uUsuarioModel, uUsuarioIntefaceModel, Data.DB;

type
  TUsuarioRegra = class
  public
    procedure Limpar(AUsuario: TUsuarioDto);
    procedure ListarUsuarios(const AModel: IModelUsuarioInterface;
      var dsTabela: TDataSource);
    function VerificarExcluir(const AModel: IModelUsuarioInterface;
      AId: Integer): Boolean;
    function Deletar(const AModel: IModelUsuarioInterface;
      AId: Integer): Boolean;
    function Localizar(const AModel: IModelUsuarioInterface;
      ATexto, ACampo: String): Boolean;
    function Salvar(const AModel: IModelUsuarioInterface;
      AUsuario: TUsuarioDto): Boolean;
  end;

implementation

{ TUsuarioRegra }

function TUsuarioRegra.Deletar(const AModel: IModelUsuarioInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.Deletar(AId);
end;

procedure TUsuarioRegra.Limpar(AUsuario: TUsuarioDto);
begin
  AUsuario.idUsuario := 0;
  AUsuario.Nome := EmptyStr;
  AUsuario.CPF := EmptyStr
end;

procedure TUsuarioRegra.ListarUsuarios(const AModel: IModelUsuarioInterface;
  var dsTabela: TDataSource);
begin
  AModel.ListarUsuarios(dsTabela);
end;

function TUsuarioRegra.Localizar(const AModel: IModelUsuarioInterface;
  ATexto, ACampo: String): Boolean;
begin
  if Trim(ATexto) = EmptyStr then
    raise Exception.Create('Campo de pesquisa vazio.')
  else
  begin
    Result := AModel.Localizar(ATexto, ACampo);
  end;
  if not(Result) then
    raise Exception.Create('Nenhum registro encontrado.');
end;

function TUsuarioRegra.Salvar(const AModel: IModelUsuarioInterface;
  AUsuario: TUsuarioDto): Boolean;
var
  VerificarID: Integer;
begin
  if AUsuario.idUsuario = 0 then
  begin
    if (AModel.VerificarUsuario(AUsuario, VerificarID) = False) then
    begin
      AUsuario.idUsuario := AModel.BuscarID;
      if (AModel.Inserir(AUsuario)) then
        Result := True
      else
        raise Exception.Create('Ocorreu algum erro!')
    end
    else
      raise Exception.Create('Usuário já cadastrado.')
  end
  else
  begin
    if AModel.VerificarUsuario(AUsuario, VerificarID) then
    begin
      if VerificarID = AUsuario.idUsuario then
        If AModel.Alterar(AUsuario) then
          Result := True
        else
          raise Exception.Create('Ocorreu algum erro!')
      else
      begin
        raise Exception.Create('Usuário já cadastrado.');
      end;
    end
    else
    begin
      If AModel.Alterar(AUsuario) then
        Result := True
      else
        raise Exception.Create('Ocorreu algum erro!')
    end;
  end;
end;

function TUsuarioRegra.VerificarExcluir(const AModel: IModelUsuarioInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
