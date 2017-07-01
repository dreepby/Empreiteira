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
  uClienteInterfaceModel, uClienteModel, FireDAC.Comp.Client;

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
    oListaTodosProdutos: TObjectDictionary<string, TProdutoDto>;
    iClickSalvar: Integer;
    oClienteModel: IModelClienteInterface;
    iCodigoAmbiente: Integer;
    AmbientesSelecionados: Array of Integer;

    frmReforma: TfrmReforma;
    oClienteDto: TClienteDto;
    oCLienteRegra: TClienteRegra;
    oProdutoModel: IModelProdutoInterface;
    oControlerListagemClientes: TListagemClientesControler;
    oProdutoDto: TProdutoDto;

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
    function popularCheckListBox: Boolean;
    function PopularComboBoxAtendenteUsuario: Boolean;
    procedure PrencherDadosDoProduto(AIdAmbiente: Integer);
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
    procedure CalcularTotalAmbiente;
    procedure CalcularTotalPedido;
    procedure CancelarProduto(Sender: TObject);
    procedure OnKeyPressEdtCpfCnpj(Sender: TObject; var Key: Char);
    procedure OnKeyPressDtpPedido(Sender: TObject; var Key: Char);
    procedure OnKeyPressDtpEntrega(Sender: TObject; var Key: Char);
    procedure OnkeyPressCbAtendente(Sender: TObject; var Key: Char);
    procedure OnKeyPressCbUsuario(Sender: TObject; var Key: Char);
    procedure OnKeyPressMoObservacao(Sender: TObject; var Key: Char);
    procedure OnkeyPressCbproduto(Sender: TObject; var Key: Char);
    procedure OnKeyPressEdtQuantidade(Sender: TObject; var Key: Char);
    procedure OnKeyPressEdtPreco(Sender: TObject; var Key: Char);
    procedure OnKeyPressEdtTotalProduto(Sender: TObject; var Key: Char);
    procedure OnKeyPressMoObservacaoProduto(Sender: TObject; var Key: Char);
    procedure AtualizarInformacoesPedido;
    procedure FormActivate(Sender: TObject);
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
var
  sDia, sMes, sAno: string;
  Data: Tdatetime;
begin
  if (not(Assigned(frmReforma))) then
  begin
    frmReforma := TfrmReforma.Create(nil);

    if frmReforma.FDMemTable1.Active then
      frmReforma.FDMemTable1.EmptyDataSet;

    frmReforma.FDMemTable1.CreateDataSet;
    frmReforma.OnActivate := FormActivate;
    frmReforma.cbProduto.OnKeyPress := OnkeyPressCbproduto;
    frmReforma.edtQuantidade.OnKeyPress := OnKeyPressEdtQuantidade;
    frmReforma.edtTotalProduto.OnKeyPress := OnKeyPressEdtTotalProduto;
    frmReforma.edtPreco.OnKeyPress := OnKeyPressEdtPreco;
    frmReforma.moObservacaoProduto.OnKeyPress := OnKeyPressMoObservacaoProduto;
    frmReforma.dtpPedido.OnKeyPress := OnKeyPressDtpPedido;
    frmReforma.dtpEntrega.OnKeyPress := OnKeyPressDtpEntrega;
    frmReforma.cbAtendente.OnKeyPress := OnkeyPressCbAtendente;
    frmReforma.cbUsuario.OnKeyPress := OnKeyPressCbUsuario;
    frmReforma.moObservacao.OnKeyPress := OnKeyPressMoObservacao;
    frmReforma.edtCpfCnpj.OnKeyPress := OnKeyPressEdtCpfCnpj;
    frmReforma.btnCancelarProduto.OnClick := CancelarProduto;
    frmReforma.btnAlterarProdutos.OnClick := AlterarProduto;
    frmReforma.btnExcluirProdutos.OnClick := ExcluirProduto;
    frmReforma.dtpPedido.OnKeyPress := OnKeyPressDtpPedido;
    frmReforma.dtpEntrega.OnKeyPress := OnKeyPressDtpEntrega;
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
    sDia := formatdatetime('1', date);
    sMes := formatdatetime('mm', date);
    sAno := formatdatetime('yyyy', date);
    sDia := formatdatetime('dd', date);
    sMes := formatdatetime('mm', date);
    sAno := formatdatetime('yyyy', date);
    Data := strtodate(sDia + '/' + sMes + '/' + sAno);
    frmReforma.dtpPedido.date := Data;
    frmReforma.dtpEntrega.date := Data;
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
            frmReforma.btnAlterarProdutos.Enabled := True;
            frmReforma.btnExcluirProdutos.Enabled := True;
            CalcularTotalAmbiente;
            CalcularTotalPedido;
            frmReforma.FDMemTable1.Filter := 'idAmbiente = ' +
              IntToStr(iCodigoAmbiente);
            frmReforma.FDMemTable1.Filtered := True;
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
      ShowMessage('A quantidade minima do produto é 1.');
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
  if not(Assigned(oProdutoDto)) then
    oProdutoDto := TProdutoDto.Create;

  oProdutoDto.Descricao := frmReforma.dbgProdutos.Fields[0].AsString;

  frmReforma.cbProduto.ItemIndex := frmReforma.cbProduto.Items.IndexOf
    (frmReforma.dbgProdutos.Fields[0].AsString);
  frmReforma.edtQuantidade.Text := frmReforma.dbgProdutos.Fields[1].AsString;
  frmReforma.edtPreco.Text := frmReforma.dbgProdutos.Fields[2].AsString;
  frmReforma.edtTotalProduto.Text := frmReforma.dbgProdutos.Fields[3].AsString;
  frmReforma.moObservacaoProduto.Lines.Text := frmReforma.dbgProdutos.Fields
    [4].AsString;
  frmReforma.btnAdicionar.Caption := 'Salvar';
  frmReforma.btnAdicionar.OnClick := SalvarAlteracaoProduto;
  frmReforma.cbProduto.Enabled := False;
end;

procedure TReformaControler.AtualizaCliente(const ACNPJ: String);
begin
  if not(ACNPJ = EmptyStr) then
  begin
    frmReforma.edtCpfCnpj.Text := ACNPJ;
  end;
end;

procedure TReformaControler.AtualizarInformacoesPedido;
var
  iCodigoUsuario, iCodigoAtendente, i, iCount, i2, iCount2, iCodigoAmbienteBD,
    iCodigoProduto: Integer;
  oProduto: TProdutoDto;
  bVerifica: Boolean;
  sTeste: String;
begin
  iCodigoUsuario := 0;
  iCodigoAtendente := 0;
  if frmReforma.cbUsuario.ItemIndex > -1 then
    iCodigoUsuario := Integer(frmReforma.cbUsuario.Items.Objects
      [frmReforma.cbUsuario.ItemIndex]);
  if frmReforma.cbAtendente.ItemIndex > -1 then
    iCodigoAtendente := Integer(frmReforma.cbAtendente.Items.Objects
      [frmReforma.cbAtendente.ItemIndex]);

  if PopularComboBoxAtendenteUsuario then
  begin
    if (frmReforma.cbAtendente.Items.Count > 0) and (iCodigoAtendente > 0) then
      frmReforma.cbAtendente.ItemIndex :=
        frmReforma.cbAtendente.Items.IndexOfObject(TObject(iCodigoAtendente));

    if (frmReforma.cbUsuario.Items.Count > 0) and (iCodigoUsuario > 0) then
      frmReforma.cbUsuario.ItemIndex := frmReforma.cbUsuario.Items.IndexOfObject
        (TObject(iCodigoUsuario));
  end;

  if popularCheckListBox then
  begin
    iCount := Length(AmbientesSelecionados);
    if iCount > 0 then
    begin
      if frmReforma.cltAmbientes.Items.Count > 0 then
      begin
        for i := 0 to iCount - 1 do
        begin
          for i2 := 0 to frmReforma.cltAmbientes.Items.Count - 1 do
          begin
            iCodigoAmbienteBD :=
              Integer(frmReforma.cltAmbientes.Items.Objects[i2]);
            if iCodigoAmbienteBD = AmbientesSelecionados[i] then
            begin
              if iCodigoAmbiente = iCodigoAmbienteBD then
                frmReforma.cltAmbientes.ItemIndex :=
                  frmReforma.cltAmbientes.Items.IndexOfObject
                  (TObject(iCodigoAmbienteBD));

              frmReforma.cltAmbientes.Checked
                [frmReforma.cltAmbientes.Items.IndexOfObject
                (TObject(iCodigoAmbienteBD))] := True;
              Break;
            end;
          end;
        end;
      end;
    end;
  end;

  if frmReforma.cbProduto.ItemIndex > -1 then
    iCodigoProduto := Integer(frmReforma.cbProduto.Items.Objects
      [frmReforma.cbProduto.ItemIndex]);

  PrencherDadosDoProduto(iCodigoAmbiente);
  iCount := frmReforma.cbProduto.Items.Count;
  if iCount > 0 then
  begin
    for i := 0 to iCount - 1 do
    begin
      if Integer(frmReforma.cbProduto.Items.Objects[i]) = iCodigoProduto then
      begin
        frmReforma.cbProduto.ItemIndex :=
          frmReforma.cbProduto.Items.IndexOfObject(TObject(iCodigoProduto));
        OnSelectCbProduto(TObject(0));
        CalcularTotalDoProduto;
      end;
    end;
  end;
  oListaTodosProdutos.Clear;
  oProdutoModel.ADDListaHash(oListaTodosProdutos);
  frmReforma.FDMemTable1.DisableControls;

  frmReforma.FDMemTable1.Filtered := False;
  if (frmReforma.FDMemTable1.RecordCount > 0) then
  begin
    frmReforma.FDMemTable1.First;
    while not(frmReforma.FDMemTable1.Eof) do
    begin
      bVerifica := False;
      for oProduto in oListaTodosProdutos.Values do
      begin
        if oProduto.idProduto = frmReforma.FDMemTable1idProduto.AsInteger then
        begin
          bVerifica := True;
          frmReforma.FDMemTable1.Edit;
          frmReforma.FDMemTable1precouni.AsFloat := StrToFloat(oProduto.Preco);
          frmReforma.FDMemTable1produto.AsString := oProduto.Descricao;
          frmReforma.FDMemTable1total.AsFloat :=
            frmReforma.FDMemTable1Quantidade.AsInteger *
            StrToFloat(oProduto.Preco);
          frmReforma.FDMemTable1.Post;
          Break;
        end;
      end;
      if not(bVerifica) then
        frmReforma.FDMemTable1.Delete;
      frmReforma.FDMemTable1.Next;
    end;
  end;

  frmReforma.FDMemTable1.EnableControls;
  frmReforma.FDMemTable1.Filter := EmptyStr;
  frmReforma.FDMemTable1.Filtered := True;  
  frmReforma.FDMemTable1.Filter := 'idAmbiente = ' + IntToStr(iCodigoAmbiente);
  frmReforma.FDMemTable1.Filtered := True;

  CalcularTotalAmbiente;
  CalcularTotalPedido;
end;

procedure TReformaControler.CalcularTotalAmbiente;
var
  cTotal: Currency;
begin
  cTotal := 0;
  if not(frmReforma.FDMemTable1.IsEmpty) then
  begin
    frmReforma.FDMemTable1.First;
    while not(frmReforma.FDMemTable1.Eof) do
    begin
      cTotal := cTotal + frmReforma.FDMemTable1total.AsFloat;
      frmReforma.FDMemTable1.Next;
    end;
  end;
  frmReforma.edtTotal.Text := 'R$ ' + CurrToStr(cTotal);
end;

procedure TReformaControler.CalcularTotalDoProduto;
begin
  frmReforma.edtTotalProduto.Text :=
    FloatToStr(StrToIntDef(frmReforma.edtQuantidade.Text, 0) *
    StrToFloatDef(frmReforma.edtPreco.Text, 0));
end;

procedure TReformaControler.CalcularTotalPedido;
var
  i, iCount: Integer;
  cTotal: Currency;
begin
  cTotal := 0;
  frmReforma.FDMemTable1.DisableControls;
  iCount := Length(AmbientesSelecionados) - 1;
  
  for i := 0 to iCount do
  begin
    frmReforma.FDMemTable1.Filter := 'idAmbiente = ' +
      IntToStr(AmbientesSelecionados[i]);
    frmReforma.FDMemTable1.Filtered := True;
    if not(frmReforma.FDMemTable1.IsEmpty) then
    begin
      frmReforma.FDMemTable1.First;
      while not(frmReforma.FDMemTable1.Eof) do
      begin
        cTotal := cTotal + frmReforma.FDMemTable1total.AsFloat;
        frmReforma.FDMemTable1.Next;
      end;
      frmReforma.valorPedido.Caption := CurrToStr(cTotal);
    end;
  end;                   
  frmReforma.FDMemTable1.EnableControls;
   frmReforma.FDMemTable1.Filter := 'idAmbiente = ' +
      IntToStr(iCodigoAmbiente);
    frmReforma.FDMemTable1.Filtered := True;
end;

procedure TReformaControler.Cancelar(Sender: TObject);
begin
  if iClickSalvar = 1 then
  begin
    frmReforma.pageControl2.TabIndex := 0;
    iClickSalvar := 0;
    frmReforma.BtnCancelar.Caption := '&Cancelar';
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
    frmReforma.cbAtendente.ItemIndex := -1;
    frmReforma.cbUsuario.ItemIndex := -1;
    oReformaRegra.Limpar(oReformaDto);
    frmReforma.edtPesquisa.Enabled := True;
  end;
end;

procedure TReformaControler.CancelarProduto(Sender: TObject);
begin
  frmReforma.cbProduto.Enabled := True;
  frmReforma.cbProduto.ItemIndex := -1;
  frmReforma.cbProduto.SetFocus;
  frmReforma.edtQuantidade.Text := IntToStr(1);
  frmReforma.edtPreco.Text := IntToStr(0);
  frmReforma.edtTotalProduto.Text := IntToStr(0);
  frmReforma.btnAdicionar.OnClick := Adicionar;
  frmReforma.btnAdicionar.Caption := 'Adicionar';
  frmReforma.moObservacaoProduto.Lines.Text := EmptyStr;
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
  oListaTodosProdutos := TObjectDictionary<string, TProdutoDto>.Create
    ([doOwnsValues]);
end;

destructor TReformaControler.Destroy;
begin

  if Assigned(oClienteDto) then
    FreeAndNil(oClienteDto);

  if Assigned(oProdutoDto) then
    FreeAndNil(oProdutoDto);

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

  if Assigned(oListaTodosProdutos) then
  begin
    oListaTodosProdutos.Clear;
    FreeAndNil(oListaTodosProdutos);
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
      oListaProdutos.Items[frmReforma.dbgProdutos.Fields[0].AsString]
      .idProduto);
    CalcularTotalAmbiente;
    CalcularTotalPedido;

    if frmReforma.FDMemTable1.IsEmpty then
    begin
      frmReforma.btnAlterarProdutos.Enabled := False;
      frmReforma.btnExcluirProdutos.Enabled := False;
    end
    else
    begin
      frmReforma.btnAlterarProdutos.Enabled := True;
      frmReforma.btnExcluirProdutos.Enabled := True;
    end;
  end;
end;

procedure TReformaControler.fecharReforma(Sender: TObject);
begin
  if (not(Assigned(frmReforma))) then
    Exit;

  oReformaRegra.Limpar(oReformaDto);
  frmReforma.Close;
  FreeAndNil(frmReforma);
end;

procedure TReformaControler.FormActivate(Sender: TObject);
begin
  if frmReforma.edtPesquisa.Enabled then
    ListarReformas
  else
    AtualizarInformacoesPedido;
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
  frmReforma.edtPesquisa.Enabled := False;
  frmReforma.dtpPedido.SetFocus;
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
var
  iCodigoCliente: Integer;
begin
  oClienteDto.CpfCnpj := Trim(frmReforma.edtCpfCnpj.Text);
  if oClienteModel.VerificarCliente(oClienteDto, iCodigoCliente) then
  begin
    try
      if oReformaRegra.VerificarCamposPedido(frmReforma, oReformaDto) then
      begin
        if frmReforma.pageControl2.TabIndex = 0 then
        begin
          frmReforma.BtnCancelar.Caption := '&Cancelar';
          iClickSalvar := 0
        end
        else
        begin
          frmReforma.BtnCancelar.Caption := '&Voltar';
          iClickSalvar := 1;
        end;
      end;
    except
      on E: Exception do
      begin
        frmReforma.pageControl2.TabIndex := 0;
        ShowMessage(E.Message);
        iClickSalvar := 0;
      end;
    end;
  end
  else
  begin
    frmReforma.pageControl2.TabIndex := 0;
    frmReforma.edtCpfCnpj.SetFocus;
    ShowMessage('CPF/CNPJ não encontrado.');
  end;
end;

procedure TReformaControler.OnClickCltAmbiente(Sender: TObject);
var
  i, iCount, iCountArray: Integer;
begin
  // frmReforma.FDMemTable1.EnableControls;
  iCodigoAmbiente := 0;
  frmReforma.cbProduto.Enabled := True;
  frmReforma.cltAmbientes.Checked[frmReforma.cltAmbientes.ItemIndex] :=
    not(frmReforma.cltAmbientes.Checked[frmReforma.cltAmbientes.ItemIndex]);

  frmReforma.btnAdicionar.OnClick := Adicionar;
  frmReforma.btnAdicionar.Caption := 'Adicionar';
  iCount := frmReforma.cltAmbientes.Items.Count - 1;
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
    if frmReforma.FDMemTable1.IsEmpty then
    begin
      frmReforma.btnAlterarProdutos.Enabled := False;
      frmReforma.btnExcluirProdutos.Enabled := False;
    end
    else
    begin
      frmReforma.btnAlterarProdutos.Enabled := True;
      frmReforma.btnExcluirProdutos.Enabled := True;
    end;
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
    frmReforma.FDMemTable1.Filter := 'idAmbiente = ' + IntToStr(0);
    frmReforma.FDMemTable1.Filtered := True;
    frmReforma.btnAlterarProdutos.Enabled := False;
    frmReforma.btnExcluirProdutos.Enabled := False;
  end;
  CalcularTotalAmbiente;
  CalcularTotalPedido;
  frmReforma.FDMemTable1.Filter := 'idAmbiente = ' + IntToStr(iCodigoAmbiente);
  frmReforma.FDMemTable1.Filtered := True;
end;

procedure TReformaControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if frmReforma.edtPesquisa.Enabled then
  begin
    if Key = VK_F2 then
      frmReforma.edtPesquisa.SetFocus;

    if Key = VK_F5 then
      ListarReformas;
  end
  else
  begin
    if Key = VK_F5 then
      AtualizarInformacoesPedido;
  end;
end;

procedure TReformaControler.OnkeyPressCbAtendente(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    frmReforma.cbUsuario.SetFocus;
end;

procedure TReformaControler.OnkeyPressCbproduto(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    frmReforma.edtQuantidade.SetFocus;
end;

procedure TReformaControler.OnKeyPressCbUsuario(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    frmReforma.moObservacao.SetFocus;
end;

procedure TReformaControler.OnKeyPressDtpEntrega(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    frmReforma.edtCpfCnpj.SetFocus;
end;

procedure TReformaControler.OnKeyPressDtpPedido(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    frmReforma.dtpEntrega.SetFocus;
end;

procedure TReformaControler.OnKeyPressEdtCpfCnpj(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    frmReforma.btnPesquisarCliente.Click;

end;

procedure TReformaControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin

end;

procedure TReformaControler.OnKeyPressEdtPreco(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    frmReforma.moObservacaoProduto.SetFocus;
end;

procedure TReformaControler.OnKeyPressEdtQuantidade(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    frmReforma.moObservacaoProduto.SetFocus;
end;

procedure TReformaControler.OnKeyPressEdtTotalProduto(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    frmReforma.moObservacaoProduto.SetFocus;
end;

procedure TReformaControler.OnKeyPressMoObservacao(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    frmReforma.BtnSalvar.Click;

end;

procedure TReformaControler.OnKeyPressMoObservacaoProduto(Sender: TObject;
  var Key: Char);
begin

  if Key = #13 then
    frmReforma.btnAdicionar.Click;
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

function TReformaControler.popularCheckListBox: Boolean;
var
  oAmbienteModel: IModelAmbienteInterface;
  oIndice: TAmbienteDto;
begin
  Result := False;
  oAmbienteModel := TAmbienteModel.Create;
  oListaAmbientes.Clear;
  frmReforma.cltAmbientes.Clear;
  if (oAmbienteModel.ADDListaHash(oListaAmbientes)) then
  begin
    Result := True;
    for oIndice in oListaAmbientes.Values do
      frmReforma.cltAmbientes.AddItem(oIndice.Descricao,
        TObject(oIndice.idAmbiente));
  end;
end;

function TReformaControler.PopularComboBoxAtendenteUsuario: Boolean;
var
  oIndice: TUsuarioDto;
  oModelUsuario: IModelUsuarioInterface;
begin
  Result := False;
  oModelUsuario := TUsuarioModel.Create;
  oListaUsuarios.Clear;
  frmReforma.cbAtendente.Clear;
  frmReforma.cbUsuario.Clear;
  if (oModelUsuario.ADDListaHash(oListaUsuarios)) then
  begin
    Result := True;
    for oIndice in oListaUsuarios.Values do
    begin
      frmReforma.cbAtendente.AddItem(oIndice.Nome + ' - ' + oIndice.Cpf,
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
  if (oProdutoModel.BuscarProdutosPorAmbiente(AIdAmbiente, oListaProdutos)) then
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
  frmReforma.BtnSalvar.Enabled := False;
  if iClickSalvar >= 2 then
    iClickSalvar := 0;

  iClickSalvar := iClickSalvar + 1;

  if iClickSalvar = 1 then
  begin
    oClienteDto.CpfCnpj := Trim(frmReforma.edtCpfCnpj.Text);
    if oClienteModel.VerificarCliente(oClienteDto, iCodigoCliente) then
    begin
      oReformaDto.dataDoPedido := frmReforma.dtpPedido.date;
      oReformaDto.dataDeEntrega := frmReforma.dtpEntrega.date;
      try
        if oReformaRegra.VerificarCamposPedido(frmReforma, oReformaDto) then
        begin
          frmReforma.BtnCancelar.Caption := '&Voltar';
          oReformaDto.oCliente.idCliente := iCodigoCliente;
          frmReforma.pageControl2.TabIndex := 1;
        end;
      except
        on E: Exception do
        begin
          ShowMessage(E.Message);
          iClickSalvar := 0;
        end;
      end;
    end
    else
    begin
      frmReforma.edtCpfCnpj.SetFocus;
      ShowMessage('CPF/CNPJ não encontrado.');
    end;
  end
  else
  begin

  end;
  frmReforma.BtnSalvar.Enabled := True;
end;

procedure TReformaControler.SalvarAlteracaoProduto(Sender: TObject);
begin
  frmReforma.btnAdicionar.Caption := 'Adicionar';
  frmReforma.btnAdicionar.OnClick := Adicionar;
  oReformaRegra.ExcluirProduto(frmReforma.FDMemTable1, iCodigoAmbiente,
    oListaProdutos.Items[oProdutoDto.Descricao].idProduto);
  frmReforma.cbProduto.Enabled := True;
  Adicionar(TObject(0));
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
