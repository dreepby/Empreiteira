unit uMunicipioRegra;

interface

uses
  uMunicipioDto, System.SysUtils, uMunicipioModel, uMunicipioInterfaceModel;

type
  TMunicipioRegra = class
  public
    procedure Limpar(AMunicipio: TMunicipioDto);
    function VerificarExcluir(var AModel: IModelMunicipioInterface;
      AId: Integer): Boolean;
    function Deletar(var AModel: IModelMunicipioInterface; AId: Integer): Boolean;
    function Pesquisar(var AModel: IModelMunicipioInterface; ANome: String): Boolean;
    function Salvar(var AModel: IModelMunicipioInterface; AMunicipio: TMunicipioDto): String;
  end;

implementation

{ TMunicipioRegra }

function TMunicipioRegra.Deletar(var AModel: IModelMunicipioInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.Deletar(AId);
end;

procedure TMunicipioRegra.Limpar(AMunicipio: TMunicipioDto);
begin
  AMunicipio.idMunicipio := 0;
  AMunicipio.Nome := EmptyStr;
  AMunicipio.oEstado.IdUF := 0;
  AMunicipio.oEstado.Nome := EmptyStr;
  AMunicipio.oEstado.UF := EmptyStr;
end;

function TMunicipioRegra.Pesquisar(var AModel: IModelMunicipioInterface;
  ANome: String): Boolean;
begin
  Result := AModel.Pesquisar(ANome);
end;

function TMunicipioRegra.Salvar(var AModel: IModelMunicipioInterface;
  AMunicipio: TMunicipioDto): String;
var
  VerificarID: Integer;
begin

  if AMunicipio.idMunicipio = 0 then
  begin
    if (AModel.VerificarMunicipio(AMunicipio, VerificarID) = False) then
    begin
      AMunicipio.idMunicipio := AModel.BuscarID;
      if (AModel.Inserir(AMunicipio)) then
        Result := 'Sucesso!'
      else
        Result := 'Ocorreu algum erro!'
    end
    else
      Result := 'Municipio já cadastrado.'
  end
  else
  begin
    if AModel.VerificarMunicipio(AMunicipio, VerificarID) then
    begin
      if VerificarID = AMunicipio.idMunicipio then
        If AModel.Alterar(AMunicipio) then
          Result := 'Sucesso!'
        else
          Result := 'Ocorreu algum erro!'
      else
      begin
        Result := 'Municipio já cadastrado.';
      end;
    end
    else
    begin
      If AModel.Alterar(AMunicipio) then
        Result := 'Sucesso!'
      else
        Result := 'Ocorreu algum erro!'
    end;

  end;
end;

function TMunicipioRegra.VerificarExcluir(var AModel: IModelMunicipioInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
