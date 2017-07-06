unit uProdutoRegra;

interface

uses
  uProdutoDto, System.SysUtils, uProdutoInterfaceModel,
  uProdutoAmbienteInterfaceModel, uProdutoAmbienteModel, uProdutoAmbienteDto,
  uArrayAmbientes;

type
  TProdutoRegra = class
  private
    function SalvarProduto(const AModel: IModelProdutoInterface;
      const AModelProdutoAmbiente: IModelProdutoAmbienteInterface;
      AProduto: TProdutoDto; AAmbientes: array of Integer): Boolean;
  public
    procedure Limpar(AProduto: TProdutoDto);
    function Salvar(const AModel: IModelProdutoInterface;
      const AModelProdutoAmbiente: IModelProdutoAmbienteInterface;
      AProduto: TProdutoDto; AAmbientes: array of Integer): Boolean;
    function BuscarProduto(const AModel: IModelProdutoInterface;
      AProduto: TProdutoDto): Boolean;
    function SalvarAmbientes(AAmbientes: array of Integer;
      AProduto: TProdutoDto): Boolean;
    function Deletar(const AModel: IModelProdutoInterface;
      AProduto: Integer): Boolean;

  end;

implementation

{ TProdutoRegra }

function TProdutoRegra.BuscarProduto(const AModel: IModelProdutoInterface;
  AProduto: TProdutoDto): Boolean;
begin
  Result := AModel.BuscarProduto(AProduto);
end;

function TProdutoRegra.Deletar(const AModel: IModelProdutoInterface;
  AProduto: Integer): Boolean;
var
  oProdutoAmbienteModel: IModelProdutoAmbienteInterface;
begin
  oProdutoAmbienteModel := TProdutoAmbienteModel.Create;
  if oProdutoAmbienteModel.Deletar(AProduto) then
  begin
    if AModel.Deletar(AProduto) then
    begin
      Result := True;
    end
    else
      Result := False;
  end
  else
    Result := False;
end;

procedure TProdutoRegra.Limpar(AProduto: TProdutoDto);
begin
  AProduto.idProduto := 0;
  AProduto.Descricao := EmptyStr;
  AProduto.Preco := EmptyStr;
end;

function TProdutoRegra.Salvar(const AModel: IModelProdutoInterface;
  const AModelProdutoAmbiente: IModelProdutoAmbienteInterface;
  AProduto: TProdutoDto; AAmbientes: array of Integer): Boolean;
var
  VerificarID, iCount, i, iContadorFor2: Integer;
  ArrayAmbientesBanco: TAmbientesReformaArray;
  bVerifica: Boolean;
  id: Integer;
  oProdutoAmbienteModel: IModelProdutoAmbienteInterface;
begin
  oProdutoAmbienteModel := TProdutoAmbienteModel.Create;
  if AProduto.idProduto = 0 then
  begin
    if (AModel.VerificarProduto(AProduto, VerificarID) = False) then
    begin
      AProduto.idProduto := AModel.BuscarID;
      Result := SalvarProduto(AModel, AModelProdutoAmbiente, AProduto,
        AAmbientes);
    end
    else
      raise Exception.Create('Produto já cadastrado.')
  end
  else
  begin
    if AModel.VerificarProduto(AProduto, VerificarID) then
    begin
      if VerificarID = AProduto.idProduto then
        If oProdutoAmbienteModel.Deletar(AProduto.idProduto) then
        begin
          if AModel.Deletar(AProduto.idProduto) then
            Result := SalvarProduto(AModel, AModelProdutoAmbiente, AProduto,
              AAmbientes);
        end
        else
          raise Exception.Create('Ocorreu algum erro!')
      else
      begin
        raise Exception.Create('Produto já cadastrado.');
      end;
    end
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

function TProdutoRegra.SalvarProduto(const AModel: IModelProdutoInterface;
  const AModelProdutoAmbiente: IModelProdutoAmbienteInterface;
  AProduto: TProdutoDto; AAmbientes: array of Integer): Boolean;
begin
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
end;

end.
