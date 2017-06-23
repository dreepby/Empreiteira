unit uReformaRegra;

interface

uses
  uReformaDto, System.SysUtils, uReformaModel, uReformaInterfaceModel,
  uClienteInterfaceModel, uClienteModel;

type
  TReformaRegra = class
  public
    procedure Limpar(var AReforma: TReformaDto);
    function VerificarExcluir(const AModel: IModelReformaInterface;
      AId: Integer): Boolean;
    function Deletar(const AModel: IModelReformaInterface;
      AId: Integer): Boolean;
    function Pesquisar(const AModel: IModelReformaInterface;
      ANome: String): Boolean;
    function Salvar(const AModel: IModelReformaInterface; AReforma: TReformaDto;
      AAmbientes: Array of Integer): Boolean;
    procedure SalvarAmbientes(AAmbientes: Array of Integer; AReforma: TReformaDto);
  end;

implementation

{ TReformaRegra }

function TReformaRegra.Deletar(const AModel: IModelReformaInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.Deletar(AId);
end;

procedure TReformaRegra.Limpar(var AReforma: TReformaDto);
begin
  AReforma.idReforma := 0;
  AReforma.observacao := EmptyStr;
  AReforma.dataDoPedido := 0;
  AReforma.dataDeEntrega := 0;
  AReforma.oCliente.idCliente := 0;
  AReforma.oCliente.Nome := EmptyStr;
  AReforma.oEscritor.idUsuario := 0;
  AReforma.oEscritor.Nome := EmptyStr;
  AReforma.oAtendente.idUsuario := 0;
  AReforma.oAtendente.Nome := EmptyStr;
  AReforma.total := 0;
end;

function TReformaRegra.Pesquisar(const AModel: IModelReformaInterface;
  ANome: String): Boolean;
begin

end;

function TReformaRegra.Salvar(const AModel: IModelReformaInterface;
  AReforma: TReformaDto; AAmbientes: Array of Integer): Boolean;
var
  iCodigoCPF, iCodigoCnpj: Integer;
  oClienteModel: IModelClienteInterface;
begin
  if AReforma.dataDoPedido > AReforma.dataDeEntrega then
    raise Exception.Create
      ('A data do pedido não pode ser depois da data de entrega.')
  else
  begin
    oClienteModel := TClienteModel.Create;
    iCodigoCPF := oClienteModel.BuscarRegistroIdCpf(AReforma.oCliente.Cpf);
    iCodigoCnpj := oClienteModel.BuscarRegistroIdCnpj(AReforma.oCliente.Cnpj);
    if (iCodigoCPF > 0) and (iCodigoCnpj > 0) then
    begin
      if iCodigoCPF = iCodigoCnpj then
      begin
        AReforma.oCliente.idCliente := iCodigoCPF;
        if AReforma.idReforma > 0 then
        begin
          if AModel.Alterar(AReforma, AAmbientes) then
            Result := True
          else
            raise Exception.Create('Ocorreu algum erro.');
        end
        else
        begin
          AReforma.idReforma := AModel.BuscarID;
          if AModel.Inserir(AReforma, AAmbientes) then
            Result := True
          else
            raise Exception.Create('Ocorreu algum erro.');
        end;
      end
      else
        raise Exception.Create('CPF e CNPJ não correspondem ao mesmo cliente.');
    end
    else
    begin
      if iCodigoCPF > 0 then
        AReforma.oCliente.idCliente := iCodigoCPF
      else
        AReforma.oCliente.idCliente := iCodigoCnpj;
      if AReforma.idReforma > 0 then
      begin
        if AModel.Alterar(AReforma, AAmbientes) then
          Result := True
        else
          raise Exception.Create('Ocorreu algum erro.');
      end
      else
      begin
        AReforma.idReforma := AModel.BuscarID;
        if AModel.Inserir(AReforma, AAmbientes) then
          Result := True
        else
          raise Exception.Create('Ocorreu algum erro.');
      end;

    end;
  end;
end;

procedure TReformaRegra.SalvarAmbientes(AAmbientes: array of Integer;
  AReforma: TReformaDto);
var
  i: Integer;
begin
  i := Length(AAmbientes);

  for I := 0 to i do
    //
end;

function TReformaRegra.VerificarExcluir(const AModel: IModelReformaInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
