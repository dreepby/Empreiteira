unit uAmbienteRegra;

interface

uses
  uAmbienteDto, System.SysUtils, uAmbienteInterfaceModel;

type
  TAmbienteRegra = class
  public
    procedure Limpar(AAmbiente: TAmbienteDto);
    function VerificarExcluir(var AModel: IModelAmbienteInterface;
      AId: Integer): Boolean;
    function Deletar(const AModel: IModelAmbienteInterface;
      AId: Integer): Boolean;
    function Salvar(const AModel: IModelAmbienteInterface;
      AAmbiente: TAmbienteDto): Boolean;

  end;

implementation

{ TAmbienteRegra }

function TAmbienteRegra.Deletar(const AModel: IModelAmbienteInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.Deletar(AId);
end;

procedure TAmbienteRegra.Limpar(AAmbiente: TAmbienteDto);
begin
  AAmbiente.idAmbiente := 0;
  AAmbiente.Descricao := EmptyStr;
end;

function TAmbienteRegra.Salvar(const AModel: IModelAmbienteInterface;
  AAmbiente: TAmbienteDto): Boolean;
var
  VerificarID: Integer;
begin
  if AAmbiente.idAmbiente = 0 then
  begin
    if (AModel.VerificarAmbiente(AAmbiente, VerificarID) = False) then
    begin
      AAmbiente.idAmbiente := AModel.BuscarID;
      if (AModel.Inserir(AAmbiente)) then
        Result := True
      else
        raise Exception.Create('Ocorreu algum erro!')
    end
    else
      raise Exception.Create('Ambiente já cadastrado.')
  end
  else
  begin
    if AModel.VerificarAmbiente(AAmbiente, VerificarID) then
    begin
      if VerificarID = AAmbiente.idAmbiente then
        If AModel.Alterar(AAmbiente) then
          Result := True
        else
          raise Exception.Create('Ocorreu algum erro!')
      else
      begin
        raise Exception.Create('Ambiente já cadastrado.');
      end;
    end
    else
    begin
      If AModel.Alterar(AAmbiente) then
        Result := True
      else
        raise Exception.Create('Ocorreu algum erro!')
    end;
  end;
end;

function TAmbienteRegra.VerificarExcluir(var AModel: IModelAmbienteInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
