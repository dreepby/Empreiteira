unit uBairroRegra;

interface

uses
  uBairroDto, System.SysUtils, uBairroModel, uBairroInterfaceModel;

type
  TBairroRegra = class
  public
    procedure Limpar(ABairro: TBairroDto);
    function VerificarExcluir(var AModel: IModelBairroInterface; AId: Integer): Boolean;
    function Deletar(var AModel: IModelBairroInterface; AId: Integer): Boolean;
    function Salvar(var AModel: IModelBairroInterface; ABairro: TBairroDto): String;

  end;

implementation

{ TBairroRegra }

function TBairroRegra.Deletar(var AModel: IModelBairroInterface; AId: Integer): Boolean;
begin
  Result := AModel.Deletar(AId);
end;

procedure TBairroRegra.Limpar(ABairro: TBairroDto);
begin
  ABairro.idBairro := 0;
  ABairro.Nome := EmptyStr;
  ABairro.oMunicipio.idMunicipio := 0;
  ABairro.oMunicipio.Nome := EmptyStr;
end;

function TBairroRegra.Salvar(var AModel: IModelBairroInterface;
  ABairro: TBairroDto): String;
var
  VerificarID: Integer;
begin
    if ABairro.idBairro = 0 then
  begin
    if (AModel.VerificarBairro(ABairro, VerificarID) = False) then
    begin
      ABairro.idBairro := AModel.BuscarID;
      if (AModel.Inserir(ABairro)) then
        Result := 'Sucesso!'
      else
        Result := 'Ocorreu algum erro!'
    end
    else
      Result := 'Bairro já cadastrado.'
  end
  else
  begin
    if AModel.VerificarBairro(ABairro, VerificarID) then
    begin
      if VerificarID = ABairro.idBairro then
        If AModel.Alterar(ABairro) then
          Result := 'Sucesso!'
        else
          Result := 'Ocorreu algum erro!'
      else
      begin
        Result := 'Bairro já cadastrado.';
      end;
    end
    else
    begin
      If AModel.Alterar(ABairro) then
        Result := 'Sucesso!'
      else
        Result := 'Ocorreu algum erro!'
    end;
  end;
end;

function TBairroRegra.VerificarExcluir(var AModel: IModelBairroInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
