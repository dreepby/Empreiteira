unit uClienteControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uClienteDto,
  uCliente, uClienteModel, uClienteRegra,
  uMunicipioDto, uBairroDto,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows, uInterfaceControler,
  uClienteInterfaceModel, uMunicipioInterfaceModel, uMunicipioModel, uEstadoDto,
  uEstadoModel, uEstadoInterfaceModel, uBairroModel, uBairroInterfaceModel;

type
  TClienteControler = class(TInterfacedObject, IControlerInterface)
  private
    frmCliente: TfrmCliente;
    oClienteModel: IModelClienteInterface;
    oClienteDto: TClienteDto;
    oClienteRegra: TClienteRegra;
    oListaEstados: TObjectDictionary<string, TEstadoDto>;
    oListaMunicipios: TObjectDictionary<string, TMunicipioDto>;
    oListaBairros: TObjectDictionary<string, TBairroDto>;
    sCampo: String;

    procedure Excluir(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure Alterar(Sender: TObject);
    procedure fecharCliente(Sender: TObject);
    procedure OnKeyPressEdtPesquisa(Sender: TObject; var Key: Char);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListarClientes;
    procedure LimparCamposForm;
    procedure AtivarBotoesInserir;
    procedure AtivarBotoesListagem;
    procedure OnSelectCbEstado(Sender: TObject);
    procedure PopularComboBoxEstado;
    procedure PopularComboBoxMunicipio(AID: Integer);
    procedure PopularComboBoxBairro(AID: Integer);
    procedure OnSelectCbMunicipio(Sender: TObject);
    procedure OnChangeEdtPesquisa(Sender: TObject);
    procedure OnSelectCbPesquisa(Sender: TObject);
    procedure OnExitEdtCpfCnpj(Sender: TObject);
  public
    procedure abrirForm;
    procedure AbrirFormModoAdicao;
    procedure AbrirFormAlterar(AIdCliente: Integer);

    constructor Create;
    destructor Destroy; override;
  end;

var
  oClienteControler: TClienteControler;

implementation

{ TClienteControler }

procedure TClienteControler.AbrirFormModoAdicao;
begin
  abrirForm;
  Inserir(Self);
end;

procedure TClienteControler.abrirForm;
begin
  if (not(Assigned(frmCliente))) then
    frmCliente := TfrmCliente.Create(nil);

  OnSelectCbPesquisa(Self);
  frmCliente.edtCpfCnpj.OnExit := OnExitEdtCpfCnpj;
  frmCliente.PageControl1.TabIndex := 0;
  frmCliente.cbPesquisa.OnSelect := OnSelectCbPesquisa;
  frmCliente.edtPesquisa.OnChange := OnChangeEdtPesquisa;
  frmCliente.PageControl1.TabIndex := 0;
  frmCliente.moObservacao.Lines.Text := EmptyStr;
  frmCliente.tsDados.Enabled := False;
  frmCliente.BtnFechar.OnClick := fecharCliente;
  frmCliente.BtnSalvar.OnClick := Salvar;
  frmCliente.btnInserir.OnClick := Inserir;
  frmCliente.BtnAlterar.OnClick := Alterar;
  frmCliente.BtnCancelar.OnClick := Cancelar;
  frmCliente.btnExcluir.OnClick := Excluir;
  frmCliente.cbEstado.OnSelect := OnSelectCbEstado;
  frmCliente.cbMunicipio.OnSelect := OnSelectCbMunicipio;
  ListarClientes;
  frmCliente.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmCliente.OnKeyDown := OnKeyDownForm;
  AtivarBotoesListagem;
  frmCliente.cbMunicipio.Enabled := False;
  frmCliente.cbBairro.Enabled := False;
  frmCliente.Show;
end;

procedure TClienteControler.AbrirFormAlterar(AIdCliente: Integer);
begin
  abrirForm;

  PopularComboBoxEstado;
  oClienteDto.idCliente := AIdCliente;

  if oClienteRegra.BuscarRegistro(oClienteModel, oClienteDto) then
  begin
    frmCliente.edtNome.Text := oClienteDto.Nome;
    frmCliente.edtCpfCnpj.Text := oClienteDto.CpfCnpj;
    frmCliente.edtCelular.Text := oClienteDto.Celular;
    frmCliente.edtTelefone.Text := oClienteDto.Telefone;
    frmCliente.edtRua.Text := oClienteDto.Rua;
    frmCliente.edtComplemento.Text := oClienteDto.Complemento;
    frmCliente.edtNumero.Text := IntToStr(oClienteDto.Numero);
    frmCliente.edtCep.Text := oClienteDto.Cep;
    frmCliente.moObservacao.Lines.Text := oClienteDto.Observacao;
    frmCliente.cbEstado.ItemIndex := frmCliente.cbEstado.Items.IndexOf
      (oClienteDto.oEstado.Nome);
    PopularComboBoxMunicipio(oListaEstados.Items[frmCliente.cbEstado.Items
      [frmCliente.cbEstado.ItemIndex]].IdUF);
    frmCliente.cbMunicipio.ItemIndex := frmCliente.cbMunicipio.Items.IndexOf
      (oClienteDto.oMunicipio.Nome);
    PopularComboBoxBairro(oListaMunicipios.Items[frmCliente.cbMunicipio.Items
      [frmCliente.cbMunicipio.ItemIndex]].idMunicipio);
    frmCliente.cbBairro.ItemIndex := frmCliente.cbBairro.Items.IndexOf
      (oClienteDto.oBairro.Nome);
  end
  else
  begin
    oClienteRegra.Limpar(oClienteDto);
    ListarClientes;
    AtivarBotoesListagem;
    frmCliente.tsTabela.Enabled := True;
    frmCliente.PageControl1.ActivePage := frmCliente.tsTabela;
    frmCliente.tsDados.Enabled := False;
    frmCliente.Caption := 'Listagem de Clientes';
    ShowMessage('Nenhum registro encontrado');
  end;

  frmCliente.tsDados.Enabled := True;
  frmCliente.Caption := 'Alteração de Cliente';
  frmCliente.PageControl1.ActivePage := frmCliente.tsDados;
  frmCliente.tsTabela.Enabled := False;
  AtivarBotoesInserir;
end;

procedure TClienteControler.Alterar(Sender: TObject);
begin

  PopularComboBoxEstado;
  oClienteDto.idCliente := frmCliente.DBGrid1.Fields[0].AsInteger;

  if oClienteRegra.BuscarRegistro(oClienteModel, oClienteDto) then
  begin
    frmCliente.edtNome.Text := oClienteDto.Nome;
    frmCliente.edtCpfCnpj.Text := oClienteDto.CpfCnpj;
    frmCliente.edtCelular.Text := oClienteDto.Celular;
    frmCliente.edtTelefone.Text := oClienteDto.Telefone;
    frmCliente.edtRua.Text := oClienteDto.Rua;
    frmCliente.edtComplemento.Text := oClienteDto.Complemento;
    frmCliente.edtNumero.Text := IntToStr(oClienteDto.Numero);
    frmCliente.edtCep.Text := oClienteDto.Cep;
    frmCliente.moObservacao.Lines.Text := oClienteDto.Observacao;
    frmCliente.cbEstado.ItemIndex := frmCliente.cbEstado.Items.IndexOf
      (oClienteDto.oEstado.Nome);
    PopularComboBoxMunicipio(oListaEstados.Items[frmCliente.cbEstado.Items
      [frmCliente.cbEstado.ItemIndex]].IdUF);
    frmCliente.cbMunicipio.ItemIndex := frmCliente.cbMunicipio.Items.IndexOf
      (oClienteDto.oMunicipio.Nome);
    PopularComboBoxBairro(oListaMunicipios.Items[frmCliente.cbMunicipio.Items
      [frmCliente.cbMunicipio.ItemIndex]].idMunicipio);
    frmCliente.cbBairro.ItemIndex := frmCliente.cbBairro.Items.IndexOf
      (oClienteDto.oBairro.Nome);

    frmCliente.tsDados.Enabled := True;
    frmCliente.Caption := 'Alteração de Cliente';
    frmCliente.PageControl1.ActivePage := frmCliente.tsDados;
    frmCliente.tsTabela.Enabled := False;
    AtivarBotoesInserir;
  end
  else
  begin
    oClienteRegra.Limpar(oClienteDto);
    ListarClientes;
    AtivarBotoesListagem;
    frmCliente.tsTabela.Enabled := True;
    frmCliente.PageControl1.ActivePage := frmCliente.tsTabela;
    frmCliente.tsDados.Enabled := False;
    frmCliente.Caption := 'Listagem de Clientes';
    ShowMessage('Nenhum registro encontrado');
  end;

  frmCliente.tsDados.Enabled := True;
  frmCliente.Caption := 'Alteração de Cliente';
  frmCliente.PageControl1.ActivePage := frmCliente.tsDados;
  frmCliente.tsTabela.Enabled := False;
  AtivarBotoesInserir;
end;

procedure TClienteControler.AtivarBotoesInserir;
begin
  frmCliente.btnInserir.Enabled := False;
  frmCliente.BtnAlterar.Enabled := False;
  frmCliente.btnExcluir.Enabled := False;
  frmCliente.BtnSalvar.Enabled := True;
  frmCliente.BtnCancelar.Enabled := True;
end;

procedure TClienteControler.AtivarBotoesListagem;
begin
  frmCliente.btnInserir.Enabled := True;
  frmCliente.BtnAlterar.Enabled := True;
  frmCliente.btnExcluir.Enabled := True;
  frmCliente.BtnSalvar.Enabled := False;
  frmCliente.BtnCancelar.Enabled := False;
end;

procedure TClienteControler.Cancelar(Sender: TObject);
begin
  frmCliente.tsTabela.Enabled := True;
  frmCliente.PageControl1.ActivePage := frmCliente.tsTabela;
  frmCliente.tsDados.Enabled := False;
  LimparCamposForm;
  frmCliente.Caption := 'Listagem de Clientes';
  AtivarBotoesListagem;
  oClienteRegra.Limpar(oClienteDto);
end;

constructor TClienteControler.Create;
begin
  oListaEstados := TObjectDictionary<string, TEstadoDto>.Create([doOwnsValues]);
  oListaMunicipios := TObjectDictionary<string, TMunicipioDto>.Create
    ([doOwnsValues]);
  oListaBairros := TObjectDictionary<string, TBairroDto>.Create([doOwnsValues]);
  oClienteModel := TClienteModel.Create;
  oClienteRegra := TClienteRegra.Create;
  oClienteDto := TClienteDto.Create;
end;

destructor TClienteControler.Destroy;
begin
  if Assigned(frmCliente) then
  begin
    frmCliente.Close;
    FreeAndNil(frmCliente);
  end;

  if Assigned(oListaMunicipios) then
  begin
    oListaMunicipios.Clear;
    FreeAndNil(oListaMunicipios);
  end;

  if Assigned(oListaEstados) then
  begin
    oListaEstados.Clear;
    FreeAndNil(oListaEstados);
  end;

  if Assigned(oListaBairros) then
  begin
    oListaBairros.Clear;
    FreeAndNil(oListaBairros);
  end;

  if Assigned(oClienteRegra) then
    FreeAndNil(oClienteRegra);

  if Assigned(oClienteDto) then
    FreeAndNil(oClienteDto);

  inherited;
end;

procedure TClienteControler.Excluir(Sender: TObject);
begin
  if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oClienteRegra.VerificarExcluir(oClienteModel,
      frmCliente.DBGrid1.Fields[0].AsInteger) then
    begin
      if oClienteRegra.Deletar(oClienteModel,
        frmCliente.DBGrid1.Fields[0].AsInteger) then
      begin
        ShowMessage('Excluido com sucesso.');
        ListarClientes;
      end
      else
        ShowMessage('Houve algum erro!!');
    end
    else
      ShowMessage
        ('Impossível excluir, pois existe um ou mais registros vinculados com esse!');
  end;
end;

procedure TClienteControler.fecharCliente(Sender: TObject);
begin
  if (not(Assigned(frmCliente))) then
    exit;

  if Assigned(oClienteDto) then
    oClienteRegra.Limpar(oClienteDto);

  frmCliente.Close;
  FreeAndNil(frmCliente);
end;

procedure TClienteControler.Inserir(Sender: TObject);
begin
  PopularComboBoxEstado;
  frmCliente.tsDados.Enabled := True;
  frmCliente.Caption := 'Cadastro de Cliente';
  frmCliente.PageControl1.ActivePage := frmCliente.tsDados;
  frmCliente.tsTabela.Enabled := False;
  AtivarBotoesInserir;
  frmCliente.edtCpfCnpj.SetFocus;
  frmCliente.cbMunicipio.Clear;
  frmCliente.cbMunicipio.Enabled := False;
  frmCliente.cbBairro.Clear;
  frmCliente.cbBairro.Enabled := False;
end;

procedure TClienteControler.LimparCamposForm;
begin
  frmCliente.edtNome.Text := EmptyStr;
  frmCliente.edtCpfCnpj.Text := EmptyStr;
  frmCliente.edtTelefone.Text := EmptyStr;
  frmCliente.edtCelular.Text := EmptyStr;
  frmCliente.moObservacao.Lines.Text := EmptyStr;
  frmCliente.edtRua.Text := EmptyStr;
  frmCliente.edtNumero.Text := EmptyStr;
  frmCliente.edtComplemento.Text := EmptyStr;
  frmCliente.edtCep.Text := EmptyStr;
  frmCliente.cbEstado.ItemIndex := -1;
  frmCliente.cbMunicipio.ItemIndex := -1;
  frmCliente.cbBairro.ItemIndex := -1;
  frmCliente.cbMunicipio.Enabled := False;
  frmCliente.cbBairro.Enabled := False;
end;

procedure TClienteControler.ListarClientes;
begin
  oClienteModel.ListarClientes(frmCliente.dsTabela);
end;

procedure TClienteControler.OnChangeEdtPesquisa(Sender: TObject);
begin
  oClienteRegra.Localizar(oClienteModel, frmCliente.edtPesquisa.Text, sCampo);
end;

procedure TClienteControler.OnExitEdtCpfCnpj(Sender: TObject);
var
  iCodigoCliente: Integer;
begin
  if oClienteDto.idCliente <= 0 then
  begin
    oClienteDto.CpfCnpj := Trim(frmCliente.edtCpfCnpj.Text);
    if oClienteModel.VerificarCliente(oClienteDto, iCodigoCliente) then
      ShowMessage('CPF/CNPJ já cadastrado.');
  end;
end;

procedure TClienteControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    frmCliente.edtPesquisa.SetFocus;

  if Key = VK_F5 then
    ListarClientes;
end;

procedure TClienteControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin

  if Key = #8 then
  begin
    if Length(Trim(frmCliente.edtPesquisa.Text)) = 1 then
      oClienteRegra.DesativarFiltro(oClienteModel)
    else if Length(Trim(frmCliente.edtPesquisa.Text)) = 0 then
      oClienteRegra.DesativarFiltro(oClienteModel)
  end;
end;

procedure TClienteControler.OnSelectCbEstado(Sender: TObject);
begin
  PopularComboBoxMunicipio(oListaEstados.Items[frmCliente.cbEstado.Items
    [frmCliente.cbEstado.ItemIndex]].IdUF);
end;

procedure TClienteControler.OnSelectCbMunicipio(Sender: TObject);
begin
  PopularComboBoxBairro(oListaMunicipios.Items[frmCliente.cbMunicipio.Items
    [frmCliente.cbMunicipio.ItemIndex]].idMunicipio);
end;

procedure TClienteControler.OnSelectCbPesquisa(Sender: TObject);
begin
  if frmCliente.cbPesquisa.Items[frmCliente.cbPesquisa.ItemIndex] = 'Nome do cliente'
  then
    sCampo := 'Nome'
  else if frmCliente.cbPesquisa.Items[frmCliente.cbPesquisa.ItemIndex] = 'CPF/CNPJ'
  then
    sCampo := 'CPFCNPJ'
  else
    sCampo := frmCliente.cbPesquisa.Items[frmCliente.cbPesquisa.ItemIndex];

  if Trim(frmCliente.edtPesquisa.Text) <> EmptyStr then
    OnChangeEdtPesquisa(Sender);
end;

procedure TClienteControler.PopularComboBoxBairro(AID: Integer);
var
  sIndice: String;
  oBairroModel: IModelBairroInterface;
begin
  oBairroModel := TBairroModel.Create;
  oListaBairros.Clear;
  frmCliente.cbBairro.Clear;
  frmCliente.cbBairro.Enabled := True;
  if (oClienteRegra.PopularListaBairros(oBairroModel, oListaBairros, AID)) then
  begin
    for sIndice in oListaBairros.Keys do
      frmCliente.cbBairro.AddItem(sIndice, oListaBairros);
  end;
end;

procedure TClienteControler.PopularComboBoxEstado;
var
  oEstadoModel: IModelEstadoInterface;
  sIndice: String;
begin
  oEstadoModel := TEstadoModel.Create;
  oListaEstados.Clear;
  frmCliente.cbEstado.Clear;
  frmCliente.cbMunicipio.Clear;
  if (oClienteRegra.PopularListaEstados(oEstadoModel, oListaEstados)) then
  begin
    for sIndice in oListaEstados.Keys do
      frmCliente.cbEstado.AddItem(sIndice, oListaEstados);
  end;
end;

procedure TClienteControler.PopularComboBoxMunicipio(AID: Integer);
var
  sIndice: String;
  oMunicipioModel: IModelMunicipioInterface;
begin
  oMunicipioModel := TMunicipioModel.Create;
  oListaMunicipios.Clear;
  frmCliente.cbMunicipio.Clear;
  frmCliente.cbMunicipio.Enabled := True;
  if (oClienteRegra.PopularListaMunicipios(oMunicipioModel, oListaMunicipios,
    AID)) then
  begin
    for sIndice in oListaMunicipios.Keys do
      frmCliente.cbMunicipio.AddItem(sIndice, oListaMunicipios);
  end;
end;

procedure TClienteControler.Salvar(Sender: TObject);
var
  bVerificaTelefoneCelular: Boolean;
begin
  oClienteDto.CpfCnpj := Trim(frmCliente.edtCpfCnpj.Text);
  oClienteDto.Nome := Trim(frmCliente.edtNome.Text);
  oClienteDto.Observacao := Trim(frmCliente.moObservacao.Lines.Text);
  oClienteDto.Celular := Trim(frmCliente.edtCelular.Text);
  oClienteDto.Telefone := Trim(frmCliente.edtTelefone.Text);
  oClienteDto.Rua := Trim(frmCliente.edtRua.Text);
  oClienteDto.Cep := Trim(frmCliente.edtCep.Text);

  if (oClienteDto.Telefone <> EmptyStr) or (oClienteDto.Celular <> EmptyStr)
  then
    bVerificaTelefoneCelular := True
  else
    bVerificaTelefoneCelular := False;

  if (oClienteDto.Nome <> EmptyStr) and (oClienteDto.Rua <> EmptyStr) and
    (frmCliente.edtNumero.Text <> EmptyStr) and (oClienteDto.Cep <> EmptyStr)
  then
  begin
    if frmCliente.cbEstado.ItemIndex > -1 then
    begin
      if frmCliente.cbMunicipio.ItemIndex > -1 then
      begin
        if frmCliente.cbBairro.ItemIndex > -1 then
        begin
          if Trim(frmCliente.edtCpfCnpj.Text) <> EmptyStr then
          begin
            if bVerificaTelefoneCelular then
            begin
              oClienteDto.Numero := StrToInt(frmCliente.edtNumero.Text);
              oClienteDto.oBairro.idBairro := oListaBairros.Items
                [frmCliente.cbBairro.Items[frmCliente.cbBairro.ItemIndex]
                ].idBairro;
              oClienteDto.Complemento := Trim(frmCliente.edtComplemento.Text);
              try
                if (oClienteRegra.Salvar(oClienteModel, oClienteDto)) then
                begin
                  ShowMessage('Salvo com sucesso');
                  frmCliente.PageControl1.ActivePage := frmCliente.tsTabela;
                  frmCliente.tsTabela.Enabled := True;
                  AtivarBotoesListagem;
                  frmCliente.Caption := 'Listagem de Clientes';
                  LimparCamposForm;
                  ListarClientes;
                end;
              except
                on E: Exception do
                  ShowMessage(E.Message);
              end;
              oClienteRegra.Limpar(oClienteDto);
            end
            else
              ShowMessage('Deve ser cadastrado o Telefone ou Celular');
          end
          else
          begin
            frmCliente.edtCpfCnpj.SetFocus;
            ShowMessage('Deve ser cadastrado o CPF ou CNPJ.');
          end;
        end
        else
        begin
          frmCliente.cbBairro.SetFocus;
          ShowMessage('Selecione um bairro.');
        end;
      end
      else
      begin
        frmCliente.cbMunicipio.SetFocus;
        ShowMessage('Selecione um municipio.');
      end;
    end
    else
    begin
      ShowMessage('Selecione um estado.');
    end;
  end
  else
    ShowMessage('Prencha todos os campos.');
end;

initialization

finalization

if Assigned(oClienteControler) then
  FreeAndNil(oClienteControler);

end.
