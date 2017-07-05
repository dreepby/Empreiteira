unit uProdutoRegra;

interface

uses
  uProdutoDto, System.SysUtils, uProdutoInterfaceModel,
  uProdutoAmbienteInterfaceModel, uProdutoAmbienteModel, uProdutoAmbienteDto,
  uArrayAmbientes;

type
  TProdutoRegra = class
  public
    procedure Limpar(AProduto: TProdutoDto);
    function VerificarExcluir(var AModel: IModelProdutoInterface;
      AId: Integer): Boolean;
    function Filtrar(const AModel: IModelProdutoInterface;
      ATexto: String): Boolean;
    function Localizar(const AModel: IModelProdutoInterface;
      ATexto: String): Boolean;
    function Deletar(const AModel: IModelProdutoInterface;
      AId: Integer): Boolean;
    function Salvar(const AModel: IModelProdutoInterface;
      const AModelProdutoAmbiente: IModelProdutoAmbienteInterface;
      AProduto: TProdutoDto; AAmbientes: array of Integer): Boolean;
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
var
  AModelAmbiente: TProdutoAmbienteModel;
begin
  AModelAmbiente.Deletar(AId);
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

function TProdutoRegra.Localizar(const AModel: IModelProdutoInterface;
  ATexto: String): Boolean;
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

function TProdutoRegra.Salvar(const AModel: IModelProdutoInterface;
  const AModelProdutoAmbiente: IModelProdutoAmbienteInterface;
  AProduto: TProdutoDto; AAmbientes: array of Integer): Boolean;
var
  VerificarID, iCount, i, iContadorFor2: Integer;
  ArrayAmbientesBanco: TAmbientesReformaArray;
  bVerifica: Boolean;
  id: Integer;
begin
  if AProduto.idProduto = 0 then
  begin
    if (AModel.VerificarProduto(AProduto, VerificarID) = False) then
    begin
      if AModel.VerificarNome(AProduto.Descricao) then
        raise Exception.Create('Já existe um produto com este nome!');

      AProduto.idProduto := AModel.BuscarID;
      if (AModel.Inserir(AProduto)) then
      begin
        begin
          if SalvarAmbientes(AAmbientes, AProduto) then
            Result := True

          else
          begin
            AModel.Deletar(AProduto.idProduto);
            raise Exception.Create('Selecione algum ambiente!')
          end;

        end;
      end
      else
        raise Exception.Create('Ocorreu algum erro! ')
    end
    else
      raise Exception.Create('Produto já cadastrado.')
  end
  else
  begin
    if AModel.VerificarProduto(AProduto, VerificarID) then
    begin
      if VerificarID = AProduto.idProduto then
        If AModel.Alterar(AProduto) then
        begin
          AModelProdutoAmbiente.BuscarAmbientes(AProduto.idProduto,
            ArrayAmbientesBanco);
          iCount := Length(ArrayAmbientesBanco) - 1;
          for i := 0 to iCount do
          begin
            id := AModelProdutoAmbiente.CompararAmbientesTabela
              (AProduto.idProduto, ArrayAmbientesBanco[i]);
            AModelProdutoAmbiente.Deletar(id);
          end;

          if SalvarAmbientes(AAmbientes, AProduto) then
            Result := True
          else
            raise Exception.Create('Selecione ao menos um ambiente')
        end
        else
          raise Exception.Create('Ocorreu algum erro!')
      else
      begin
        raise Exception.Create('Produto já cadastrado.');
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
  i, count: Integer;
  oProdutoAmbienteModel: IModelProdutoAmbienteInterface;
  oProdutoAmbienteDto: TProdutoAmbienteDto;
begin
  oProdutoAmbienteDto := TProdutoAmbienteDto.Create;
  count := Length(AAmbientes) - 1;
  oProdutoAmbienteModel := TProdutoAmbienteModel.Create;
  oProdutoAmbienteDto.oProduto.idProduto := AProduto.idProduto;
  for i := 0 to count do
  begin
    oProdutoAmbienteDto.IdProdutoAmbiente := oProdutoAmbienteModel.BuscarID;
    oProdutoAmbienteDto.oAmbiente.idAmbiente := AAmbientes[i];
    if oProdutoAmbienteModel.Inserir(oProdutoAmbienteDto) then
      Result := True
    else
    begin
      Result := False;
      exit;
    end;
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
