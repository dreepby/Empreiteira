unit uEstadoRegra;

interface

uses
  uEstadoDto, System.SysUtils, uEstadoModel;

type
  TEstadoRegra = class

  public
    procedure Limpar(var AEstado: TEstadoDto);
    function Salvar(var AModel: TEstadoModel; AEstado: TEstadoDto): String;
    function Pesquisar(var AModel: TEstadoModel; ANome: String): Boolean;
    function VerificarExcluir(var AModel: TEstadoModel; AId: Integer): Boolean;
    function Deletar(var AModel: TEstadoModel; AId: Integer): Boolean;
  end;

implementation

{ TEstadoRegra }

function TEstadoRegra.Deletar(var AModel: TEstadoModel; AId: Integer): Boolean;
begin
  Result := AModel.Deletar(AId);
end;

procedure TEstadoRegra.Limpar(var AEstado: TEstadoDto);
begin
  AEstado.IdUF := 0;
  AEstado.Nome := EmptyStr;
  AEstado.UF := EmptyStr;
end;

function TEstadoRegra.Pesquisar(var AModel: TEstadoModel;
  ANome: String): Boolean;
begin
  Result := AModel.Pesquisar(ANome);
end;

function TEstadoRegra.Salvar(var AModel: TEstadoModel;
  AEstado: TEstadoDto): String;
var
  VerificarID: Integer;
begin

  if AEstado.IdUF = 0 then
  begin
    if (AModel.VerificarUF(AEstado.UF, VerificarID) = False) then
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
    if AModel.VerificarUF(AEstado.UF, VerificarID) then
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
end;

function TEstadoRegra.VerificarExcluir(var AModel: TEstadoModel;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
