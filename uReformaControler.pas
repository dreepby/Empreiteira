unit uReformaControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uReformaDto,
  uReformaModel, uReforma, uReformaRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows,
  uInterfaceControler, uReformaInterfaceModel,
  uAmbienteInterfaceModel, uAmbienteModel, uAmbienteDto, uClienteDto,
  uClienteRegra, uUsuarioDto, uUsuarioModel, uUsuarioIntefaceModel,
  uAmbienteReformaModel, uAmbienteReformaInterfaceModel, uProdutoInterfaceModel,
  uProdutoModel, uProdutoDto, uListagemClientesController,
  uClienteInterfaceModel, uClienteModel;

type
  TReformaControler = class(TInterfacedObject, IControlerInterface)
  private
    oReformaModel: IModelReformaInterface;
    oReformaDto: TReformaDto;
    oReformaRegra: TReformaRegra;
    oListaReformas: TObjectDictionary<string, TReformaDto>;
    oListaAmbientes: TObjectDictionary<string, TAmbienteDto>;
    oListaAmbientesReformas: TObjectDictionary<string, TAmbienteDto>;
    oListaUsuarios: TObjectDictionary<string, TUsuarioDto>;
    oListaProdutos: TObjectDictionary<string, TProdutoDto>;
    iClickSalvar: Integer;
    oClienteModel: IModelClienteInterface;
    iCodigoAmbiente: Integer;
    AmbientesSelecionados: Array of Integer;

    frmReforma: TfrmReforma;
    oClienteDto: TClienteDto;
    oCLienteRegra: TClienteRegra;
    oProdutoModel: IModelProdutoInterface;
    oControlerListagemClientes: TListagemClientesControler;

    procedure Excluir(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure ListarReformas;
    procedure Alterar(Sender: TObject);
    procedure fecharReforma(Sender: TObject);
    procedure Pesquisar(Sender: TObject);
    procedure OnKeyPressEdtPesquisa(Sender: TObject; var Key: Char);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure popularCheckListBox;
    procedure PopularComboBoxAtendenteUsuario;
    procedure PrencherDadosDoProduto(AIdAmbiente: Integer);
    procedure ListarProdutosAmbiente;
    procedure OnSelectCbProduto(Sender: TObject);
    procedure CalcularTotalDoProduto;
    procedure AbrirListagemClientes(Sender: TObject);
    procedure AtualizaCliente(const ACNPJ: String);
    procedure TrazerFormParaFrente;
    procedure OnChangePageControl2(Sender: TObject);
    procedure OnClickCltAmbiente(Sender: TObject);
    procedure OnChangeEdtQuantidade(Sender: TObject);
    procedure Adicionar(Sender: TObject);
    procedure ExcluirProduto(Sender: TObject);
    procedure AlterarProduto(Sender: TObject);
    procedure SalvarAlteracaoProduto(Sender: TObject);
  public
    procedure abrirForm;

    constructor Create;
    destructor Destroy; override;
  end;

var
  oReformaControler: TReformaControler;

implementation

{ TReformaControler }

procedure TReformaControler.abrirForm;
begin
  if (not(Assigned(frmReforma))) then
  begin
    frmReforma := TfrmReforma.Create(nil);

    if frmReforma.FDMemTable1.Active then
      frmReforma.FDMemTable1.EmptyDataSet;

    frmReforma.FDMemTable1.CreateDataSet;
    frmReforma.btnAlterarProdutos.OnClick := AlterarProduto;
    frmReforma.btnExcluirProdutos.OnClick := ExcluirProduto;
    frmReforma.FDMemTable1.Filtered := True;
    frmReforma.PageControl1.TabIndex := 0;
    frmReforma.pageControl2.TabIndex := 0;
    frmReforma.btnAdicionar.OnClick := Adicionar;
    frmReforma.edtQuantidade.OnChange := OnChangeEdtQuantidade;
    frmReforma.cltAmbientes.OnClick := OnClickCltAmbiente;
    frmReforma.tsDados.Enabled := False;
    frmReforma.BtnSalvar.Enabled := False;
    frmReforma.BtnCancelar.Enabled := False;
    frmReforma.BtnFechar.OnClick := fecharReforma;
    frmReforma.BtnSalvar.OnClick := Salvar;
    frmReforma.btnInserir.OnClick := Inserir;
    frmReforma.BtnAlterar.OnClick := Alterar;
    frmReforma.BtnCancelar.OnClick := Cancelar;
    frmReforma.btnExcluir.OnClick := Excluir;
    frmReforma.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
    frmReforma.OnKeyDown := OnKeyDownForm;
    frmReforma.cbProduto.OnSelect := OnSelectCbProduto;
    frmReforma.btnPesquisarCliente.OnClick := AbrirListagemClientes;
    frmReforma.pageControl2.OnChange := OnChangePageControl2;
    frmReforma.moObservacaoProduto.Lines.Text := EmptyStr;
    ListarReformas;
    frmReforma.Show;
  end
  else
    TrazerFormParaFrente;
end;

procedure TReformaControler.AbrirListagemClientes(Sender: TObject);
var
  sRetorno: String;
begin
  oControlerListagemClientes.abrirForm(frmReforma, AtualizaCliente,
    TrazerFormParaFrente);
end;

procedure TReformaControler.Adicionar(Sender: TObject);
begin
  if frmReforma.cbProduto.ItemIndex >= 0 then
  begin
    if StrToInt(frmReforma.edtQuantidade.Text) > 0 then
    begin
      try
        if oReformaRegra.VerificarMemTableProduto(frmReforma.FDMemTable1,
          Integer(frmReforma.cbProduto.Items.Objects
          [frmReforma.cbProduto.ItemIndex]), iCodigoAmbiente) then
        begin
          try
            frmReforma.FDMemTable1.Insert;
            frmReforma.FDMemTable1Quantidade.AsInteger :=
              StrToInt(frmReforma.edtQuantidade.Text);
            frmReforma.FDMemTable1idProduto.AsInteger :=
              Integer(frmReforma.cbProduto.Items.Objects
              [frmReforma.cbProduto.ItemIndex]);
            frmReforma.FDMemTable1produto.AsString := frmReforma.cbProduto.Items
              [frmReforma.cbProduto.ItemIndex];
            frmReforma.FDMemTable1observacao.AsString :=
              frmReforma.moObservacaoProduto.Lines.Text;
            frmReforma.FDMemTable1total.AsFloat :=
              StrToCurr(frmReforma.edtTotalProduto.Text);
            frmReforma.FDMemTable1produto.AsString := frmReforma.cbProduto.Items
              [frmReforma.cbProduto.ItemIndex];
            frmReforma.FDMemTable1precouni.AsFloat :=
              StrToFloat(frmReforma.edtPreco.Text);
            frmReforma.FDMemTable1idAmbiente.AsInteger := iCodigoAmbiente;
            frmReforma.FDMemTable1.Post;
          finally
            frmReforma.cbProduto.ItemIndex := -1;
            frmReforma.edtQuantidade.Text := IntToStr(1);
            frmReforma.edtPreco.Text := IntToStr(0);
            frmReforma.edtTotalProduto.Text := IntToStr(0);
            frmReforma.moObservacaoProduto.Lines.Text := EmptyStr;
            frmReforma.cbProduto.SetFocus;
          end;
        end;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    end
    else
    begin
      frmReforma.edtQuantidade.SetFocus;
      ShowMessage('A quantidade minima uma.');
    end;
  end
  else
  begin
    frmReforma.cbProduto.SetFocus;
    ShowMessage('Selecione um produto.');
  end;

end;

procedure TReformaControler.Alterar(Sender: TObject);
begin

end;

procedure TReformaControler.AlterarProduto(Sender: TObject);
begin
  frmReforma.cbProduto.ItemIndex := frmReforma.cbProduto.Items.IndexOf
    (frmReforma.dbgProdutos.Fields[0].AsString);
  frmReforma.edtQuantidade.Text := frmReforma.dbgProdutos.Fields[1].AsString;
  frmReforma.edtPreco.Text := frmReforma.dbgProdutos.Fields[2].AsString;
  frmReforma.edtTotalProduto.Text := frmReforma.dbgProdutos.Fields[3].AsString;
  frmReforma.moObservacaoProduto.Lines.Text := frmReforma.dbgProdutos.Fields[4].AsString;
  frmReforma.btnAdicionar.Caption := 'Salvar';
   frmReforma.btnAdicionar.OnClick := SalvarAlteracaoProduto;
end;

procedure TReformaControler.AtualizaCliente(const ACNPJ: String);
begin
  if not(ACNPJ = EmptyStr) then
  begin
    frmReforma.edtCpfCnpj.Text := ACNPJ;
  end;
end;

procedure TReformaControler.CalcularTotalDoProduto;
begin
  frmReforma.edtTotalProduto.Text :=
    FloatToStr(StrToIntDef(frmReforma.edtQuantidade.Text, 0) *
    StrToFloatDef(frmReforma.edtPreco.Text, 0));

end;

procedure TReformaControler.Cancelar(Sender: TObject);
begin
  if iClickSalvar = 1 then
  begin
    frmReforma.pageControl2.TabIndex := 0;
    iClickSalvar := 0;
    frmReforma.BtnCancelar.Caption := 'Cancelar';
  end
  else
  begin
    frmReforma.tsTabela.Enabled := True;
    frmReforma.PageControl1.ActivePage := frmReforma.tsTabela;
    frmReforma.tsDados.Enabled := False;
    frmReforma.btnInserir.Enabled := True;
    frmReforma.BtnAlterar.Enabled := True;
    frmReforma.btnExcluir.Enabled := True;
    frmReforma.BtnSalvar.Enabled := False;
    frmReforma.BtnCancelar.Enabled := False;
    frmReforma.Caption := 'Listagem de Reformas';
    frmReforma.edtCpfCnpj.Text := EmptyStr;
    frmReforma.moObservacao.Lines.Text := EmptyStr;
    frmReforma.cbAtedente.ItemIndex := -1;
    frmReforma.cbUsuario.ItemIndex := -1;
    oReformaRegra.Limpar(oReformaDto);
  end;
end;

constructor TReformaControler.Create;
begin
  oClienteDto := TClienteDto.Create;
  oReformaModel := TReformaModel.Create;
  oReformaDto := TReformaDto.Create;
  oReformaRegra := TReformaRegra.Create;
  oListaReformas := TObjectDictionary<string, TReformaDto>.Create
    ([doOwnsValues]);
  oListaAmbientes := TObjectDictionary<string, TAmbienteDto>.Create
    ([doOwnsValues]);
  oListaUsuarios := TObjectDictionary<string, TUsuarioDto>.Create
    ([doOwnsValues]);
  oCLienteRegra := TClienteRegra.Create;
  oControlerListagemClientes := TListagemClientesControler.Create;
  oClienteModel := TClienteModel.Create;
end;

destructor TReformaControler.Destroy;
begin

  if Assigned(oClienteDto) then
    FreeAndNil(oClienteDto);

  if Assigned(oControlerListagemClientes) then
    FreeAndNil(oControlerListagemClientes);

  if Assigned(oReformaRegra) then
    FreeAndNil(oReformaRegra);

  if Assigned(oListaReformas) then
  begin
    oListaReformas.Clear;
    FreeAndNil(oListaReformas);
  end;

  if Assigned(oListaUsuarios) then
  begin
    oListaUsuarios.Clear;
    FreeAndNil(oListaUsuarios);
  end;

  if Assigned(oListaProdutos) then
  begin
    oListaProdutos.Clear;
    FreeAndNil(oListaProdutos);
  end;

  if Assigned(oListaAmbientes) then
  begin
    oListaAmbientes.Clear;
    FreeAndNil(oListaAmbientes);
  end;

  if Assigned(oListaAmbientesReformas) then
  begin
    oListaAmbientesReformas.Clear;
    FreeAndNil(oListaAmbientesReformas);
  end;

  if Assigned(oReformaDto) then
    FreeAndNil(oReformaDto);

  if Assigned(frmReforma) then
  begin
    frmReforma.Close;
    FreeAndNil(frmReforma);
  end;

  if Assigned(oCLienteRegra) then
    FreeAndNil(oCLienteRegra);
  inherited;
end;

procedure TReformaControler.Excluir(Sender: TObject);
begin
  if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oReformaRegra.VerificarExcluir(oReformaModel,
      frmReforma.DBGrid1.Fields[0].AsInteger) then
    begin
      if oReformaRegra.Deletar(oReformaModel,
        frmReforma.DBGrid1.Fields[0].AsInteger) then
      begin
        ShowMessage('Excluido com sucesso.');
        ListarReformas;
      end
      else
        ShowMessage('Houve algum erro!!');
    end
    else
      ShowMessage
        ('Impossível excluir, pois existe um ou mais registros vinculados com esse!');
  end;
end;

procedure TReformaControler.ExcluirProduto(Sender: TObject);
begin
  if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    oReformaRegra.ExcluirProduto(frmReforma.FDMemTable1, iCodigoAmbiente,
      oListaProdutos.Items[frmReforma.dbgProdutos.Fields[0].AsString].idProduto)
  end;
end;

procedure TReformaControler.fecharReforma(Sender: TObject);
begin
  if (not(Assigned(frmReforma))) then
    exit;

  oReformaRegra.Limpar(oReformaDto);
  frmReforma.Close;
  FreeAndNil(frmReforma);
end;

procedure TReformaControler.Inserir(Sender: TObject);
begin
  frmReforma.tsDados.Enabled := True;
  frmReforma.Caption := 'Cadastro de Reforma';
  frmReforma.PageControl1.ActivePage := frmReforma.tsDados;
  frmReforma.tsTabela.Enabled := False;
  frmReforma.btnInserir.Enabled := False;
  frmReforma.BtnAlterar.Enabled := False;
  frmReforma.btnExcluir.Enabled := False;
  frmReforma.BtnSalvar.Enabled := True;
  frmReforma.BtnCancelar.Enabled := True;
  frmReforma.pageControl2.ActivePage := frmReforma.tsPedido;
  popularCheckListBox;
  PopularComboBoxAtendenteUsuario;
end;

procedure TReformaControler.ListarProdutosAmbiente;
begin

end;

procedure TReformaControler.ListarReformas;
begin
  oReformaModel.ListarReformas(frmReforma.dsTabela);
end;

procedure TReformaControler.OnChangeEdtQuantidade(Sender: TObject);
begin
  CalcularTotalDoProduto;
end;

procedure TReformaControler.OnChangePageControl2(Sender: TObject);
begin
  if frmReforma.pageControl2.TabIndex = 0 then
  begin
    frmReforma.BtnCancelar.Caption := 'Cancelar';
    iClickSalvar := 0
  end
  else
  begin
    frmReforma.BtnCancelar.Caption := 'Voltar';
    iClickSalvar := 1;
  end;
end;

procedure TReformaControler.OnClickCltAmbiente(Sender: TObject);
var
  i, iCount, iCountArray: Integer;
begin
  frmReforma.cltAmbientes.Checked[frmReforma.cltAmbientes.ItemIndex] :=
    not(frmReforma.cltAmbientes.Checked[frmReforma.cltAmbientes.ItemIndex]);

  iCount := frmReforma.cltAmbientes.Items.count - 1;
  iCountArray := 0;
  SetLength(AmbientesSelecionados, 0);

  for i := 0 to iCount do
  begin
    if frmReforma.cltAmbientes.Checked[i] = True then
    begin
      SetLength(AmbientesSelecionados, iCountArray + 1);
      AmbientesSelecionados[iCountArray] := oListaAmbientes.Items
        [frmReforma.cltAmbientes.Items[i]].idAmbiente;
      iCountArray := iCountArray + 1;
    end;
  end;

  if frmReforma.cltAmbientes.Checked[frmReforma.cltAmbientes.ItemIndex] then
  begin
    iCodigoAmbiente := Integer(frmReforma.cltAmbientes.Items.Objects
      [frmReforma.cltAmbientes.ItemIndex]);
    frmReforma.FDMemTable1.Filter := 'idAmbiente = ' +
      IntToStr(iCodigoAmbiente);
    frmReforma.FDMemTable1.Filtered := True;
    PrencherDadosDoProduto(iCodigoAmbiente);
  end
  else
  begin
    frmReforma.edtQuantidade.Text := IntToStr(1);
    frmReforma.edtPreco.Text := IntToStr(0);
    frmReforma.edtTotal.Text := IntToStr(0);
    frmReforma.cbProduto.Clear;
    frmReforma.edtTotalProduto.Text := IntToStr(0);
    frmReforma.moObservacaoProduto.Lines.Text := EmptyStr;
  end;
end;

procedure TReformaControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    frmReforma.edtPesquisa.SetFocus;

  if Key = VK_F5 then
    ListarReformas;
end;

procedure TReformaControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin

end;

procedure TReformaControler.OnSelectCbProduto(Sender: TObject);
begin
  frmReforma.edtPreco.Text := oListaProdutos.Items
    [frmReforma.cbProduto.Items[frmReforma.cbProduto.ItemIndex]].Preco;
  CalcularTotalDoProduto;
end;

procedure TReformaControler.Pesquisar(Sender: TObject);
begin

end;

procedure TReformaControler.popularCheckListBox;
var
  oAmbienteModel: IModelAmbienteInterface;
  oIndice: TAmbienteDto;
begin
  oAmbienteModel := TAmbienteModel.Create;
  oListaAmbientes.Clear;
  frmReforma.cltAmbientes.Clear;
  if (oAmbienteModel.ADDListaHash(oListaAmbientes)) then
  begin
    for oIndice in oListaAmbientes.Values do
      frmReforma.cltAmbientes.AddItem(oIndice.Descricao,
        TObject(oIndice.idAmbiente));
  end;
end;

procedure TReformaControler.PopularComboBoxAtendenteUsuario;
var
  oIndice: TUsuarioDto;
  oModelUsuario: IModelUsuarioInterface;
begin
  oModelUsuario := TUsuarioModel.Create;
  oListaUsuarios.Clear;
  frmReforma.cbAtedente.Clear;
  frmReforma.cbUsuario.Clear;
  if (oModelUsuario.ADDListaHash(oListaUsuarios)) then
  begin
    for oIndice in oListaUsuarios.Values do
    begin
      frmReforma.cbAtedente.AddItem(oIndice.Nome + ' - ' + oIndice.Cpf,
        TObject(oIndice.idUsuario));
      frmReforma.cbUsuario.AddItem(oIndice.Nome + ' - ' + oIndice.Cpf,
        TObject(oIndice.idUsuario));
    end;
  end;
end;

procedure TReformaControler.PrencherDadosDoProduto(AIdAmbiente: Integer);
var
  oIndice: TProdutoDto;
begin
  if not(Assigned(oProdutoModel)) then
    oProdutoModel := TProdutoModel.Create;

  if not(Assigned(oListaProdutos)) then
    oListaProdutos := TObjectDictionary<string, TProdutoDto>.Create
      ([doOwnsValues]);

  oListaProdutos.Clear;
  frmReforma.cbProduto.Clear;
  if (not(oProdutoModel.BuscarProdutosPorAmbiente(AIdAmbiente, oListaProdutos)))
  then
    ShowMessage('Nenhum produto cadastrado nesse ambiente.')
  else
  begin
    for oIndice in oListaProdutos.Values do
    begin
      frmReforma.cbProduto.AddItem(oIndice.Descricao,
        TObject(oIndice.idProduto));
    end;
    frmReforma.edtQuantidade.Text := IntToStr(1);
    frmReforma.edtPreco.Text := IntToStr(0);
    frmReforma.moObservacaoProduto.Text := EmptyStr;
    CalcularTotalDoProduto;
    frmReforma.cbProduto.SetFocus;
  end;
end;

procedure TReformaControler.Salvar(Sender: TObject);
var
  iCodigoCliente: Integer;
begin
  if iClickSalvar >= 2 then
    iClickSalvar := 0;

  iClickSalvar := iClickSalvar + 1;

  if iClickSalvar = 1 then
  begin
    oClienteDto.CpfCnpj := Trim(frmReforma.edtCpfCnpj.Text);
    if oClienteModel.VerificarCliente(oClienteDto, iCodigoCliente) then
    begin
      frmReforma.BtnCancelar.Caption := 'Voltar';
      oReformaDto.oCliente.idCliente := iCodigoCliente;
      frmReforma.pageControl2.TabIndex := 1;
    end
    else
      ShowMessage('Cliente não encontrado');
  end
  else
  begin

  end;

end;

procedure TReformaControler.SalvarAlteracaoProduto(Sender: TObject);
begin
  frmReforma.btnAdicionar.Caption := 'Adicionar';
  frmReforma.btnAdicionar.OnClick := Adicionar;
  //oReformaRegra.ExcluirProduto(frmReforma.FDMemTable1, iCodigoAmbiente, );
end;

procedure TReformaControler.TrazerFormParaFrente;
begin
  frmReforma.Enabled := True;
  frmReforma.Show;
end;

initialization

finalization

if Assigned(oReformaControler) then
  FreeAndNil(oReformaControler);

end.
