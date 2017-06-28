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
  uProdutoModel, uProdutoDto, uListagemClientesController;

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

    frmReforma: TfrmReforma;
    oClienteDto: TClienteDto;
    oCLienteRegra: TClienteRegra;
    AmbientesReforma: Array of Integer;
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
    frmReforma := TfrmReforma.Create(nil);

  frmReforma.tsDados.Enabled := False;
  frmReforma.BtnSalvar.Enabled := False;
  frmReforma.BtnCancelar.Enabled := False;
  frmReforma.BtnFechar.OnClick := fecharReforma;
  frmReforma.BtnSalvar.OnClick := Salvar;
  frmReforma.btnInserir.OnClick := Inserir;
  frmReforma.BtnAlterar.OnClick := Alterar;
  frmReforma.BtnCancelar.OnClick := Cancelar;
  frmReforma.btnExcluir.OnClick := Excluir;
  frmReforma.btnPesquisa.OnClick := Pesquisar;
  frmReforma.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmReforma.OnKeyDown := OnKeyDownForm;
  frmReforma.cbProduto.OnSelect := OnSelectCbProduto;
  frmReforma.btnPesquisarCliente.OnClick := AbrirListagemClientes;
  ListarReformas;
  frmReforma.Show;
end;

procedure TReformaControler.AbrirListagemClientes(Sender: TObject);
var
  sRetorno: String;
begin
  oControlerListagemClientes.abrirForm(frmReforma, AtualizaCliente);
end;

procedure TReformaControler.Alterar(Sender: TObject);
begin

end;

procedure TReformaControler.AtualizaCliente(const ACNPJ: String);
begin
  if not(ACNPJ = EmptyStr) then
    frmReforma.edtCpfCnpj.Text := ACNPJ;
end;

procedure TReformaControler.CalcularTotalDoProduto;
begin
  frmReforma.edtTotalProduto.Text :=
    FloatToStr(StrToInt(frmReforma.edtQuantidade.Text) *
    StrToFloat(frmReforma.edtPreco.Text));
end;

procedure TReformaControler.Cancelar(Sender: TObject);
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
  oReformaRegra.Limpar(oReformaDto);
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
  sIndice: String;
begin
  oAmbienteModel := TAmbienteModel.Create;
  oListaAmbientes.Clear;
  frmReforma.cltAmbientes.Clear;
  if (oAmbienteModel.ADDListaHash(oListaAmbientes)) then
  begin
    for sIndice in oListaAmbientes.Keys do
      frmReforma.cltAmbientes.AddItem(sIndice, oListaAmbientes);
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
    CalcularTotalDoProduto;
  end;
end;

procedure TReformaControler.Salvar(Sender: TObject);
var
  iClick: Integer;
begin
  iClick := +1;
  if iClick = 1 then
  begin

  end
  else
  begin

  end;
end;

initialization

finalization

if Assigned(oReformaControler) then
  FreeAndNil(oReformaControler);

end.
