unit uEstadoRegra;

interface

uses
  uEstadoDto, System.SysUtils, uEstadoModel, uEstadoInterfaceModel;

type
  TEstadoRegra = class

  public
    procedure Limpar(var AEstado: TEstadoDto);
    function Salvar(var AModel: IModelEstadoInterface;
      AEstado: TEstadoDto): String;
    function VerificarExcluir(var AModel: IModelEstadoInterface;
      AId: Integer): Boolean;
    function Deletar(var AModel: IModelEstadoInterface; AId: Integer): Boolean;
  end;

implementation

{ TEstadoRegra }

function TEstadoRegra.Deletar(var AModel: IModelEstadoInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.Deletar(AId);
end;

procedure TEstadoRegra.Limpar(var AEstado: TEstadoDto);
begin
  AEstado.IdUF := 0;
  AEstado.Nome := EmptyStr;
  AEstado.UF := EmptyStr;
end;

function TEstadoRegra.Salvar(var AModel: IModelEstadoInterface;
  AEstado: TEstadoDto): String;
var
  VerificarID: Integer;
begin
  if Length(Trim(AEstado.UF)) = 2 then
  begin
    if AEstado.IdUF = 0 then
    begin
      if (AModel.VerificarUF(AEstado, VerificarID) = False) then
      begin
        AEstado.IdUF := AModel.BuscarID;
        if (AModel.Inserir(AEstado)) then
          Result := 'Sucesso!'
        else
          Result := 'Ocorreu algum erro!'
      end
      else
        Result := 'Estado já cadastrado.'
    end
    else
    begin
      if AModel.VerificarUF(AEstado, VerificarID) then
      begin
        if VerificarID = AEstado.IdUF then
          If AModel.Alterar(AEstado) then
            Result := 'Sucesso!'
          else
            Result := 'Ocorreu algum erro!'
        else
        begin
          Result := 'Estado já cadastrado.';
        end;
      end
      else
      begin
        If AModel.Alterar(AEstado) then
          Result := 'Sucesso!'
        else
          Result := 'Ocorreu algum erro!'
      end;
    end;
  end
  else
    Result := 'Campo UF deve conter 2 letras.';
end;

function TEstadoRegra.VerificarExcluir(var AModel: IModelEstadoInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
