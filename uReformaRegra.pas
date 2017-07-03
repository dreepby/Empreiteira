unit uReformaRegra;

interface

uses
  uReformaDto, System.SysUtils, Data.Db, uReformaModel, uReformaInterfaceModel,
  uClienteInterfaceModel, uClienteModel, uAmbienteReformaDto,
  uAmbienteReformaInterfaceModel, uAmbienteReformaModel, FireDAC.Comp.Client,
  uReforma, System.Generics.Collections, uProdutoReformaDto,
  uProdutoReformaModel, uProdutoReformaInterfaceModel, uArrayDinamicoInteger;

type
  TReformaRegra = class
  public
    procedure Limpar(var AReforma: TReformaDto);
    function VerificarExcluir(const AModel: IModelReformaInterface;
      AId: Integer): Boolean;
    function Deletar(const AModel: IModelReformaInterface;
      AId: Integer): Boolean;
    function Salvar(const AModel: IModelReformaInterface; AReforma: TReformaDto;
      oListaAmbientesProdutosReformas: TObjectDictionary < Integer,
      TObjectDictionary < Integer, TProdutoReformaDto >> ): Boolean;
    function VerificarMemTableProduto(var AMemTable: TFDMemTable;
      const AIdProduto: Integer; const AIdAmbiente: Integer): Boolean;
    procedure ExcluirProduto(var AMemTable: TFDMemTable;
      const AIdAmbiente, AIdProduto: Integer);
    function VerificarCamposPedido(const AForm: TfrmReforma;
      const AReforma: TReformaDto): Boolean;
    function BuscarDadosRegra(var AModel: IModelReformaInterface;
      var oReformaDto: TReformaDto; var AListaAmbientesProdutosReformas
      : TObjectDictionary<Integer, TObjectDictionary<Integer,
      TProdutoReformaDto>>): Boolean;

  end;

implementation

{ TReformaRegra }

function TReformaRegra.BuscarDadosRegra(var AModel: IModelReformaInterface;
  var oReformaDto: TReformaDto;
  var AListaAmbientesProdutosReformas: TObjectDictionary<Integer, TObjectDictionary<Integer, TProdutoReformaDto>>): Boolean;
var
  oArrayAmbientesReformas: TArrayDinamico;
  oAmbienteReformaModel: IModelAmbienteReformaInterface;
begin
  if AModel.BuscarRegistro(oReformaDto) then
  begin
    Result := True;
  end
  else
    Result := False;
end;

function TReformaRegra.Deletar(const AModel: IModelReformaInterface;
  AId: Integer): Boolean;
var
  oAmbienteReformaModel: IModelAmbienteReformaInterface;
  oProdutoReformaModel: IModelProdutoReformaInterface;
  oArray: TArrayDinamico;
  i: Integer;
begin
  oAmbienteReformaModel := TAmbienteReformaModel.Create;
  oProdutoReformaModel := TProdutoReformaModel.Create;
  if oAmbienteReformaModel.BuscarArrayAmbientesReforma(AId, oArray) then
  begin
    for i := 0 to Length(oArray) - 1 do
    begin
      oProdutoReformaModel.Deletar(oArray[i]);
      if not(oAmbienteReformaModel.Deletar(oArray[i])) then
        raise Exception.Create('Ocorreu Algum erro.');
    end
  end;
  if AModel.Deletar(AId) then
    Result := True
  else
    raise Exception.Create('Ocorreu Algum erro.');
end;

procedure TReformaRegra.ExcluirProduto(var AMemTable: TFDMemTable;
  const AIdAmbiente, AIdProduto: Integer);
begin
  AMemTable.Filter := 'idProduto = ' + IntToStr(AIdProduto) +
    ' AND idAmbiente = ' + IntToStr(AIdAmbiente);
  AMemTable.Filtered := True;
  AMemTable.Delete;
  AMemTable.Filter := 'idAmbiente = ' + IntToStr(AIdAmbiente);
  AMemTable.Filtered := True;
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
  AReforma.total := EmptyStr;
end;

function TReformaRegra.Salvar(const AModel: IModelReformaInterface;
  AReforma: TReformaDto; oListaAmbientesProdutosReformas: TObjectDictionary <
  Integer, TObjectDictionary < Integer, TProdutoReformaDto >> ): Boolean;
var
  oAmbienteReformaModel: IModelAmbienteReformaInterface;
  oIndice: TObjectDictionary<Integer, TProdutoReformaDto>;
  oIndice2, oProdutoReformaDto: TProdutoReformaDto;
  oAmbienteReformaDto: TAmbienteReformaDto;
  iArray: TArray<Integer>;
  bVerifica: Boolean;
  oProdutoReformaModel: IModelProdutoReformaInterface;
begin
  oProdutoReformaModel := TProdutoReformaModel.Create;
  oAmbienteReformaDto := TAmbienteReformaDto.Create;
  oAmbienteReformaModel := TAmbienteReformaModel.Create;
  Result := False;
  if AReforma.dataDoPedido > AReforma.dataDeEntrega then
    raise Exception.Create
      ('A data do pedido não pode ser depois da data de entrega.')
  else
  begin
    if AReforma.idReforma = 0 then
    begin
      AReforma.idReforma := AModel.BuscarID;
      if AModel.Inserir(AReforma) then
      begin
        oAmbienteReformaDto.oReforma.idReforma := AReforma.idReforma;
        for oIndice in oListaAmbientesProdutosReformas.Values do
        begin
          bVerifica := False;
          iArray := oIndice.Keys.ToArray;
          oAmbienteReformaDto.oAmbiente.idAmbiente := oIndice.Items[iArray[0]]
            .oAmbienteReforma.oAmbiente.idAmbiente;
          for oIndice2 in oIndice.Values do
          begin
            oAmbienteReformaDto.IdAmbienteReforma :=
              oAmbienteReformaModel.BuscarID;

            if oAmbienteReformaModel.Inserir(oAmbienteReformaDto) then
            begin
              oIndice.Items[iArray[0]].oAmbienteReforma.IdAmbienteReforma :=
                oAmbienteReformaDto.IdAmbienteReforma;
              bVerifica := True;
              Break;
            end
            else
              raise Exception.Create('Ocorreu Algum erro!');
          end;
          if bVerifica then
          begin
            for oIndice2 in oIndice.Values do
            begin
              oProdutoReformaDto := oIndice2;
              oProdutoReformaDto.id := oProdutoReformaModel.BuscarID;
              oProdutoReformaDto.oAmbienteReforma.IdAmbienteReforma :=
                oAmbienteReformaDto.IdAmbienteReforma;
              if oProdutoReformaModel.Inserir(oProdutoReformaDto) then
              begin
                Result := True;
              end
              else
                raise Exception.Create('Ocorreu Algum erro!');
            end;
          end;
        end;
      end
      else
        raise Exception.Create('Houve algum erro.');
    end;
  end;
  if Assigned(oAmbienteReformaDto) then
    FreeAndNil(oAmbienteReformaDto);
end;

function TReformaRegra.VerificarCamposPedido(const AForm: TfrmReforma;
  const AReforma: TReformaDto): Boolean;
begin
  if AReforma.dataDoPedido > AReforma.dataDeEntrega then
    raise Exception.Create
      ('A data do pedido não pode ser depois da data de entrega.')
  else
  begin
    if AForm.cbAtendente.ItemIndex > -1 then
    begin
      if not(AForm.cbUsuario.ItemIndex > -1) then
      begin
        AForm.cbUsuario.SetFocus;
        raise Exception.Create('Selecione um usuario.');
      end
      else
        Result := True;
    end
    else
    begin
      raise Exception.Create('Selecione um atendente.');
    end;

  end;
end;

function TReformaRegra.VerificarExcluir(const AModel: IModelReformaInterface;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

function TReformaRegra.VerificarMemTableProduto(var AMemTable: TFDMemTable;
  const AIdProduto, AIdAmbiente: Integer): Boolean;
begin
  try
    Result := False;
    AMemTable.Filter := 'idProduto = ' + IntToStr(AIdProduto) +
      ' AND idAmbiente = ' + IntToStr(AIdAmbiente);
    AMemTable.Filtered := True;
    if AMemTable.IsEmpty then
      Result := True
    else
      raise Exception.Create('Produto já cadastrado.');
  finally
    AMemTable.Filter := 'idAmbiente = ' + IntToStr(AIdAmbiente);
  end;

end;

end.
