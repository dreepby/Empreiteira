unit uClienteRegra;

interface

uses
  uClienteDto, System.SysUtils, uClienteInterfaceModel, uMunicipioDto,
  uMunicipioInterfaceModel, uMunicipioModel, System.Generics.Collections,
  uEstadoDto, uEstadoInterfaceModel, uBairroInterfaceModel, uBairroDto;

type
  TClienteRegra = class
  public
    procedure Limpar(ACliente: TClienteDto);
    function VerificarExcluir(const AModel: IModelClienteInterface;
      AId: Integer): Boolean;
    function Deletar(var AModel: IModelClienteInterface; AId: Integer): Boolean;
    function Localizar(const AModel: IModelClienteInterface;
      ATexto, ACampo: String): Boolean;
    procedure DesativarFiltro(const AModel: IModelClienteInterface);
    function Salvar(var AModel: IModelClienteInterface;
      ACliente: TClienteDto): Boolean;
    function PopularListaMunicipios(const AModel: IModelMunicipioInterface;
      var ALista: TObjectDictionary<string, TMunicipioDto>;
      const AId: Integer): Boolean;
    function PopularListaEstados(const AModel: IModelEstadoInterface;
      var ALista: TObjectDictionary<string, TEstadoDto>): Boolean;
    function PopularListaBairros(const AModel: IModelBairroInterface;
      var ALista: TObjectDictionary<string, TBairroDto>;
      const AId: Integer): Boolean;
    function BuscarRegistro(const AModel: IModelClienteInterface;
      var ACliente: TClienteDto): Boolean;
  end;

implementation

{ TClienteRegra }

function TClienteRegra.BuscarRegistro(const AModel: IModelClienteInterface;
  var ACliente: TClienteDto): Boolean;
begin
  Result := AModel.BuscarRegistro(ACliente);
end;

function TClienteRegra.Deletar(var AModel: IModelClienteInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.Deletar(AId);
end;

procedure TClienteRegra.DesativarFiltro(const AModel: IModelClienteInterface);
begin
  AModel.DesativarFiltro;
end;

procedure TClienteRegra.Limpar(ACliente: TClienteDto);
begin
  ACliente.idCliente := 0;
  ACliente.Nome := EmptyStr;
  ACliente.Cpf := EmptyStr;
  ACliente.Cnpj := EmptyStr;
  ACliente.Telefone := EmptyStr;
  ACliente.Celular := EmptyStr;
  ACliente.Observacao := EmptyStr;
  ACliente.Rua := EmptyStr;
  ACliente.Numero := 0;
  ACliente.Complemento := EmptyStr;
  ACliente.Cep := EmptyStr;
  ACliente.oBairro.idBairro := 0;
  ACliente.oBairro.Nome := EmptyStr;
  ACliente.oMunicipio.idMunicipio := 0;
  ACliente.oMunicipio.Nome := EmptyStr;
  ACliente.oEstado.IdUF := 0;
  ACliente.oEstado.Nome := EmptyStr;
end;

function TClienteRegra.Localizar(const AModel: IModelClienteInterface;
  ATexto, ACampo: String): Boolean;
begin
  if Trim(ACampo) = EmptyStr then
    raise Exception.Create
      ('Por favor selecione o campo que você deseja pesquisar.')
  else
  begin
    if ACampo = 'Nome do cliente' then
      ACampo := 'Nome'
    else if ACampo = 'Rua' then
      ACampo := 'Endereco'
    else if ACampo = 'Estado' then
      ACampo := 'Municipio';
    Result := AModel.Localizar(ATexto, ACampo);
  end;
  if not(Result) then
    raise Exception.Create('Nenhum registro encontrado.');
end;

function TClienteRegra.PopularListaBairros(const AModel: IModelBairroInterface;
  var ALista: TObjectDictionary<string, TBairroDto>;
  const AId: Integer): Boolean;
begin
  Result := AModel.ADDListaHash(ALista, AId);
end;

function TClienteRegra.PopularListaEstados(const AModel: IModelEstadoInterface;
  var ALista: TObjectDictionary<string, TEstadoDto>): Boolean;
begin
  Result := AModel.ADDListaHash(ALista);
end;

function TClienteRegra.PopularListaMunicipios(const AModel
  : IModelMunicipioInterface;
  var ALista: TObjectDictionary<string, TMunicipioDto>;
  const AId: Integer): Boolean;
begin
  Result := AModel.ADDListaHash(ALista, AId);
end;

function TClienteRegra.Salvar(var AModel: IModelClienteInterface;
  ACliente: TClienteDto): Boolean;
var
  VerificarID: Integer;
begin
  if ACliente.idCliente = 0 then
  begin
    if (AModel.VerificarCliente(ACliente, VerificarID) = False) then
    begin
      ACliente.idCliente := AModel.BuscarID;
      if (AModel.Inserir(ACliente)) then
        Result := True
      else
        raise Exception.Create('Ocorreu algum erro!')
    end
    else
      raise Exception.Create('Cliente já cadastrado.')
  end
  else
  begin
    if AModel.VerificarCliente(ACliente, VerificarID) then
    begin
      if VerificarID = ACliente.idCliente then
        If AModel.Alterar(ACliente) then
          Result := True
        else
          raise Exception.Create('Ocorreu algum erro!')
      else
      begin
        raise Exception.Create('Cliente já cadastrado.');
      end;
    end
    else
    begin
      If AModel.Alterar(ACliente) then
        Result := True
      else
        raise Exception.Create('Ocorreu algum erro!')
    end;
  end;
end;

function TClienteRegra.VerificarExcluir(const AModel: IModelClienteInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
