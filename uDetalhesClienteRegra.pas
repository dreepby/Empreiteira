unit uDetalhesClienteRegra;

interface

uses
  uClienteDto, System.SysUtils, uDetalhesClienteModel,
  uDetalhesClienteInterfaceModel;

type
  TDetalhesClienteRegra = class

  public
    procedure Limpar(var ACliente: TClienteDto);
    function Salvar(var AModel: IModelDetalhesClienteInterface;
      var ACliente: TClienteDto): Boolean;
    function Pesquisar(var AModel: IModelDetalhesClienteInterface;
      var ACliente: TClienteDto): Boolean;
  end;

implementation

{ TClienteDetalhesRegra }

procedure TDetalhesClienteRegra.Limpar(var ACliente: TClienteDto);
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

function TDetalhesClienteRegra.Pesquisar(var AModel
  : IModelDetalhesClienteInterface; var ACliente: TClienteDto): Boolean;
begin
  Result := AModel.BuscarRegistroCpfCnpj(ACliente);
end;

function TDetalhesClienteRegra.Salvar(var AModel
  : IModelDetalhesClienteInterface; var ACliente: TClienteDto): Boolean;
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

end.
