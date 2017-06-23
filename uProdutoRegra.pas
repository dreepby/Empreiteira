unit uProdutoRegra;

interface

uses
  uProdutoDto, System.SysUtils, uProdutoInterfaceModel,
  uProdutoAmbienteInterfaceModel, uProdutoAmbienteModel, uProdutoAmbienteDto;

type
  TProdutoRegra = class
  public
    procedure Limpar(AProduto: TProdutoDto);
    function VerificarExcluir(var AModel: IModelProdutoInterface;
      AId: Integer): Boolean;
    function Filtrar(const AModel: IModelProdutoInterface;
      ATexto: String): Boolean;
    function Deletar(const AModel: IModelProdutoInterface;
      AId: Integer): Boolean;
    function Salvar(const AModel: IModelProdutoInterface;
      AProduto: TProdutoDto): Boolean;
    function BuscarProduto(const AModel: IModelProdutoInterface;
      AProduto: TProdutoDto): Boolean;
    function SalvarAmbientes(AAmbientes: array of Integer;
      AProduto: TProdutoDto): Boolean;

  end;

implementation

{ TProdutoRegra }

function TProdutoRegra.BuscarProduto(const AModel: IModelProdutoInterface;
  AProduto: TProdutoDto): Boolean;
begin
  Result := AModel.BuscarProduto(AProduto);
end;

function TProdutoRegra.Deletar(const AModel: IModelProdutoInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.Deletar(AId);
end;

function TProdutoRegra.Filtrar(const AModel: IModelProdutoInterface;
  ATexto: String): Boolean;
begin
  begin
    if Trim(ATexto) = EmptyStr then
      raise Exception.Create('Campo de pesquisa vazio.')
    else
    begin
      Result := AModel.Localizar(ATexto);
    end;
    if not(Result) then
      raise Exception.Create('Nenhum registro encontrado.');
  end;
end;

procedure TProdutoRegra.Limpar(AProduto: TProdutoDto);
begin
  AProduto.idProduto := 0;
  AProduto.Descricao := EmptyStr;
  AProduto.Preco := EmptyStr;
end;

function TProdutoRegra.Salvar(const AModel: IModelProdutoInterface;
  AProduto: TProdutoDto): Boolean;
var
  VerificarID: Integer;
begin
  if AProduto.idProduto = 0 then
  begin
    if (AModel.VerificarProduto(AProduto, VerificarID) = False) then
    begin
      AProduto.idProduto := AModel.BuscarID;
      if (AModel.Inserir(AProduto)) then
        Result := True
      else
        raise Exception.Create('Ocorreu algum erro!')
    end
    else
      raise Exception.Create('Produto j� cadastrado.')
  end
  else
  begin
    if AModel.VerificarProduto(AProduto, VerificarID) then
    begin
      if VerificarID = AProduto.idProduto then
        If AModel.Alterar(AProduto) then
          Result := True
        else
          raise Exception.Create('Ocorreu algum erro!')
      else
      begin
        raise Exception.Create('Produto j� cadastrado.');
      end;
    end
    else
    begin
      If AModel.Alterar(AProduto) then
        Result := True
      else
        raise Exception.Create('Ocorreu algum erro!')
    end;
  end;

end;

function TProdutoRegra.SalvarAmbientes(AAmbientes: array of Integer;
  AProduto: TProdutoDto): Boolean;
var
  i: Integer;
  oProdutoAmbienteModel: IModelProdutoAmbienteInterface;
  oProdutoAmbienteDto: TProdutoAmbienteDto;
begin
  Result := False;
  oProdutoAmbienteDto := TProdutoAmbienteDto.Create;
  i := Length(AAmbientes);
  oProdutoAmbienteModel := TProdutoAmbienteModel.Create;
  oProdutoAmbienteDto.oProduto.idProduto := AProduto.idProduto;
  for i := 0 to i do
  begin
    // chamar fun��o buscarid do model produtoAmbiente e colocar na property IdAmbienteProduto
    oProdutoAmbienteDto. := AAmbientes[i];
    oProdutoAmbienteDto.oAmbiente.idAmbiente := AAmbientes[i];
    if oProdutoAmbienteModel.Inserir() then
      Result := True
    else
      exit;
  end;
  if Assigned(oProdutoAmbienteDto) then
    FreeAndNil(oProdutoAmbienteDto);
end;

function TProdutoRegra.VerificarExcluir(var AModel: IModelProdutoInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
