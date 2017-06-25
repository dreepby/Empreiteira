unit uReformaControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uReformaDto,
  uReformaModel, uReforma, uReformaRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows,
  uInterfaceControler, uReformaInterfaceModel, uDetalhesClienteControler,
  uAmbienteInterfaceModel, uAmbienteModel, uAmbienteDto, uClienteDto,
  uClienteRegra, uUsuarioDto, uUsuarioModel, uUsuarioIntefaceModel,
  uAmbienteReformaModel, uAmbienteReformaInterfaceModel;

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
    frmReforma: TfrmReforma;
    oDetalhesClienteControler: TDetalhesClienteControler;
    oClienteDto: TClienteDto;
    oCLienteRegra: TClienteRegra;
    AmbientesReforma: Array of Integer;

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
    procedure PesquisarClientePorCpf(Sender: TObject);
    procedure PesquisarClientePorCnpj(Sender: TObject);
    procedure popularCheckListBox;
    procedure PopularComboBoxAtendenteUsuario;
    procedure PopularComboBoxAmbientes(AIdReforma: Integer);
    procedure PopularComboBoxProdutos;
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

  frmReforma.tsProdutos.TabVisible := False;
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
  frmReforma.btnPesquisarCpf.OnClick := PesquisarClientePorCpf;
  frmReforma.btnPesquisarCnpj.OnClick := PesquisarClientePorCnpj;
  ListarReformas;
  frmReforma.Show;
end;

procedure TReformaControler.Alterar(Sender: TObject);
begin

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
  oDetalhesClienteControler := TDetalhesClienteControler.Create;
  oCLienteRegra := TClienteRegra.Create;
end;

destructor TReformaControler.Destroy;
begin

  if Assigned(oClienteDto) then
    FreeAndNil(oClienteDto);

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

  if Assigned(oDetalhesClienteControler) then
    FreeAndNil(oDetalhesClienteControler);
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
  popularCheckListBox;
  PopularComboBoxAtendenteUsuario;
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

procedure TReformaControler.Pesquisar(Sender: TObject);
begin

end;

procedure TReformaControler.PesquisarClientePorCnpj(Sender: TObject);
begin
  oCLienteRegra.Limpar(oClienteDto);
  if frmReforma.edtCnpj.Text <> EmptyStr then
  begin
    oClienteDto.Cnpj := frmReforma.edtCnpj.Text;
    oDetalhesClienteControler.abrirForm(oClienteDto);
    frmReforma.edtCpf.Text := oClienteDto.Cpf;
    frmReforma.edtCnpj.Text := oClienteDto.Cnpj;
  end
  else
  begin
    if MessageDlg('Você deseja cadastrar um novo cliente?', mtinformation,
      [mbyes, mbno], 0) = mryes then
    begin
      oDetalhesClienteControler.ValoresCpfCnpj(oClienteDto);
      frmReforma.edtCpf.Text := oClienteDto.Cpf;
      frmReforma.edtCnpj.Text := oClienteDto.Cnpj;
      oDetalhesClienteControler.abrirFormCad(oClienteDto);
    end;
  end;
end;

procedure TReformaControler.PesquisarClientePorCpf(Sender: TObject);
begin
  oCLienteRegra.Limpar(oClienteDto);
  if frmReforma.edtCpf.Text <> EmptyStr then
  begin
    oClienteDto.Cpf := frmReforma.edtCpf.Text;
    oDetalhesClienteControler.abrirForm(oClienteDto);
    frmReforma.edtCpf.Text := oClienteDto.Cpf;
    frmReforma.edtCnpj.Text := oClienteDto.Cnpj;
  end
  else
  begin
    if MessageDlg('Você deseja cadastrar um novo cliente?', mtinformation,
      [mbyes, mbno], 0) = mryes then
    begin
      oDetalhesClienteControler.ValoresCpfCnpj(oClienteDto);
      frmReforma.edtCpf.Text := oClienteDto.Cpf;
      frmReforma.edtCnpj.Text := oClienteDto.Cnpj;
      oDetalhesClienteControler.abrirFormCad(oClienteDto);
    end;
  end;
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

procedure TReformaControler.PopularComboBoxAmbientes(AIdReforma: Integer);
var
  oAmbienteReformaModel: IModelAmbienteReformaInterface;
  oIndice: TAmbienteDto;
begin
  oAmbienteReformaModel := TAmbienteReformaModel.Create;
  frmReforma.cbAmbiente.Clear;
  oListaAmbientesReformas := TObjectDictionary<string, TAmbienteDto>.Create
    ([doOwnsValues]);

  if oAmbienteReformaModel.BuscarRegistrosReforma(oListaAmbientesReformas,
    oReformaDto.idReforma) then
  begin
    for oIndice in oListaAmbientesReformas.Values do
    begin
      frmReforma.cbAmbiente.AddItem(oIndice.Descricao,
        TObject(oIndice.idAmbiente));
      frmReforma.cbAmbiente.ItemIndex := 0;
    end;
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

procedure TReformaControler.PopularComboBoxProdutos;
var
  oAmbienteReformaModel: IModelAmbienteReformaInterface;
  oIndice: TAmbienteDto;
begin
  oAmbienteReformaModel := TAmbienteReformaModel.Create;
  frmReforma.cbAmbiente.Clear;
  oListaAmbientesReformas := TObjectDictionary<string, TAmbienteDto>.Create
    ([doOwnsValues]);

  if oAmbienteReformaModel.BuscarRegistrosReforma(oListaAmbientesReformas,
    oReformaDto.idReforma) then
  begin
    for oIndice in oListaAmbientesReformas.Values do
    begin
      frmReforma.cbAmbiente.AddItem(oIndice.Descricao,
        TObject(oIndice.idAmbiente));
      frmReforma.cbAmbiente.ItemIndex := 0;
    end;
  end;

end;

procedure TReformaControler.Salvar(Sender: TObject);
var
  sTeste: String;
  i: Integer;
  iCount: Integer;
  iCountArray: Integer;
begin
  iCount := frmReforma.cltAmbientes.Items.count - 1;
  iCountArray := 0;
  SetLength(AmbientesReforma, 0);

  for i := 0 to iCount do
  begin
    if frmReforma.cltAmbientes.Checked[i] = True then
    begin
      sTeste := sTeste + frmReforma.cltAmbientes.Items[i];
      SetLength(AmbientesReforma, iCountArray + 2);
      AmbientesReforma[iCountArray] := oListaAmbientes.Items
        [frmReforma.cltAmbientes.Items[i]].idAmbiente;
      iCountArray := iCountArray + 1;
    end;
  end;
  if sTeste = EmptyStr then
    ShowMessage('Selecione um ambiente.')
  else
  begin
    oReformaDto.dataDoPedido := frmReforma.dtpPedido.Date;
    oReformaDto.dataDeEntrega := frmReforma.dtpEntrega.Date;
    if frmReforma.cbAtedente.ItemIndex > -1 then
    begin
      if frmReforma.cbUsuario.ItemIndex > -1 then
      begin
        if (Trim(frmReforma.edtCpf.Text) = EmptyStr) and
          (Trim(frmReforma.edtCnpj.Text) = EmptyStr) then
          ShowMessage('Prencha todos os campos.')
        else
        begin
          oReformaDto.oCliente.Cpf := frmReforma.edtCpf.Text;
          oReformaDto.oCliente.Cnpj := frmReforma.edtCnpj.Text;
          oReformaDto.oEscritor.idUsuario :=
            Integer(frmReforma.cbUsuario.Items.Objects
            [frmReforma.cbUsuario.ItemIndex]);
          oReformaDto.oAtendente.idUsuario :=
            Integer(frmReforma.cbAtedente.Items.Objects
            [frmReforma.cbAtedente.ItemIndex]);
          oReformaDto.observacao := frmReforma.moObservacao.Lines.Text;
          try
            if oReformaRegra.Salvar(oReformaModel, oReformaDto, AmbientesReforma)
            then
            begin
              ListarReformas;
              frmReforma.tsPedido.TabVisible := False;
              frmReforma.tsProdutos.TabVisible := True;
              frmReforma.pageControl2.ActivePage := frmReforma.tsProdutos;
              PopularComboBoxAmbientes(oReformaDto.idReforma);

            end;
          except
            on E: Exception do
            begin
              oReformaRegra.Limpar(oReformaDto);
              ShowMessage(E.Message);
            end;

          end;
        end;
      end
      else
        ShowMessage('Selecione um usuario.');
    end
    else
      ShowMessage('Selecionae um atendente.');
  end;
end;

initialization

finalization

if Assigned(oReformaControler) then
  FreeAndNil(oReformaControler);

end.
