unit uDetalhesClienteControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uClienteDto,
  uDetalhesCliente, uDetalhesClienteModel, uDetalhesClienteRegra,
  uMunicipioDto, uBairroDto,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows,
  uDetalhesClienteInterfaceModel, uMunicipioInterfaceModel, uMunicipioModel,
  uEstadoDto,
  uEstadoModel, uEstadoInterfaceModel, uBairroModel, uBairroInterfaceModel;

type
  TDetalhesClienteControler = class
  private
    frmDetalhesCliente: TfrmDetalhesCliente;
    oDetalhesClienteModel: IModelDetalhesClienteInterface;
    oClienteDto: TClienteDto;
    oDetalhesClienteRegra: TDetalhesClienteRegra;
    oListaEstados: TObjectDictionary<string, TEstadoDto>;
    oListaMunicipios: TObjectDictionary<string, TMunicipioDto>;
    oListaBairros: TObjectDictionary<string, TBairroDto>;

    procedure Salvar(Sender: TObject);
    procedure FecharDetalhesUsuario(Sender: TObject);
    procedure OnSelectCbEstado(Sender: TObject);
    procedure PopularComboBoxEstado;
    procedure PopularComboBoxMunicipio(AID: Integer);
    procedure PopularComboBoxBairro(AID: Integer);
    procedure OnSelectCbMunicipio(Sender: TObject);
    procedure OnActivateForm(Sender: TObject);
    procedure VerificaçãoSalvar;
    procedure SetarFuncoesForm;
  public
    procedure abrirForm(var ACliente: TClienteDto);
    procedure abrirFormCad(var ACliente: TClienteDto);
    procedure ValoresCpfCnpj(var ACliente: TClienteDto);

    constructor Create;
    destructor Destroy; override;
  end;

var
  oDetalhesClienteControler: TDetalhesClienteControler;

implementation

{ TClienteControler }

procedure TDetalhesClienteControler.abrirForm(var ACliente: TClienteDto);
begin
  if oDetalhesClienteRegra.Pesquisar(oDetalhesClienteModel, ACliente) then
  begin
    if (not(Assigned(frmDetalhesCliente))) then
      frmDetalhesCliente := TfrmDetalhesCliente.Create(nil);
    PopularComboBoxEstado;
    frmDetalhesCliente.edtCodigo.Enabled := True;

    oClienteDto.idCliente := ACliente.idCliente;
    oClienteDto.Cpf := ACliente.Cpf;
    oClienteDto.Cnpj := ACliente.Cnpj;
    frmDetalhesCliente.edtCodigo.Text := IntToStr(ACliente.idCliente);
    frmDetalhesCliente.edtNome.Text := ACliente.Nome;
    frmDetalhesCliente.edtCnpj.Text := ACliente.Cnpj;
    frmDetalhesCliente.edtCpf.Text := ACliente.Cpf;
    frmDetalhesCliente.edtCelular.Text := ACliente.Celular;
    frmDetalhesCliente.edtTelefone.Text := ACliente.Telefone;
    frmDetalhesCliente.edtRua.Text := ACliente.Rua;
    frmDetalhesCliente.edtComplemento.Text := ACliente.Complemento;
    frmDetalhesCliente.edtNumero.Text := IntToStr(ACliente.Numero);
    frmDetalhesCliente.edtCep.Text := ACliente.Cep;
    frmDetalhesCliente.moObservacao.Lines.Text := ACliente.Observacao;

    frmDetalhesCliente.cbEstado.ItemIndex :=
      frmDetalhesCliente.cbEstado.Items.IndexOf(ACliente.oEstado.Nome);

    PopularComboBoxMunicipio(oListaEstados.Items
      [frmDetalhesCliente.cbEstado.Items
      [frmDetalhesCliente.cbEstado.ItemIndex]].IdUF);

    frmDetalhesCliente.cbMunicipio.ItemIndex :=
      frmDetalhesCliente.cbMunicipio.Items.IndexOf(ACliente.oMunicipio.Nome);

    PopularComboBoxBairro(oListaMunicipios.Items
      [frmDetalhesCliente.cbMunicipio.Items
      [frmDetalhesCliente.cbMunicipio.ItemIndex]].idMunicipio);

    frmDetalhesCliente.cbBairro.ItemIndex :=
      frmDetalhesCliente.cbBairro.Items.IndexOf(ACliente.oBairro.Nome);

    SetarFuncoesForm;
    frmDetalhesCliente.ShowModal;
    ACliente.Cpf := oClienteDto.Cpf;
    ACliente.Cnpj := oClienteDto.Cnpj;
    FreeAndNil(frmDetalhesCliente);
  end
  else
  begin
    if MessageDlg('Você deseja cadastrar um novo cliente?', mtinformation,
      [mbyes, mbno], 0) = mryes then
    begin
      if (not(Assigned(frmDetalhesCliente))) then
        frmDetalhesCliente := TfrmDetalhesCliente.Create(nil);
      PopularComboBoxEstado;

      oClienteDto.Cpf := ACliente.Cpf;
      oClienteDto.Cnpj := ACliente.Cnpj;
      SetarFuncoesForm;
      frmDetalhesCliente.ShowModal;
      ACliente.Cpf := oClienteDto.Cpf;
      ACliente.Cnpj := oClienteDto.Cnpj;
      FreeAndNil(frmDetalhesCliente);
    end;
  end;

end;

procedure TDetalhesClienteControler.abrirFormCad(var ACliente: TClienteDto);
begin
  if (not(Assigned(frmDetalhesCliente))) then
    frmDetalhesCliente := TfrmDetalhesCliente.Create(nil);
  PopularComboBoxEstado;

  SetarFuncoesForm;
  oClienteDto.Cpf := ACliente.Cpf;
  oClienteDto.Cnpj := ACliente.Cnpj;
  frmDetalhesCliente.ShowModal;
  ACliente.Cpf := oClienteDto.Cpf;
  ACliente.Cnpj := oClienteDto.Cnpj;
  FreeAndNil(frmDetalhesCliente);
end;

constructor TDetalhesClienteControler.Create;
begin
  oListaEstados := TObjectDictionary<string, TEstadoDto>.Create([doOwnsValues]);
  oListaMunicipios := TObjectDictionary<string, TMunicipioDto>.Create
    ([doOwnsValues]);
  oListaBairros := TObjectDictionary<string, TBairroDto>.Create([doOwnsValues]);
  oDetalhesClienteModel := TDetalhesClienteModel.Create;
  oDetalhesClienteRegra := TDetalhesClienteRegra.Create;
  oClienteDto := TClienteDto.Create;
end;

destructor TDetalhesClienteControler.Destroy;
begin
  if Assigned(frmDetalhesCliente) then
  begin
    frmDetalhesCliente.Close;
    FreeAndNil(frmDetalhesCliente);
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

  if Assigned(oDetalhesClienteRegra) then
    FreeAndNil(oDetalhesClienteRegra);

  if Assigned(oClienteDto) then
    FreeAndNil(oClienteDto);

  inherited;
end;

procedure TDetalhesClienteControler.FecharDetalhesUsuario(Sender: TObject);
begin
  if (not(Assigned(frmDetalhesCliente))) then
    exit;

  frmDetalhesCliente.Close;
end;

procedure TDetalhesClienteControler.OnActivateForm(Sender: TObject);
begin
  frmDetalhesCliente.edtNome.SetFocus;
end;

procedure TDetalhesClienteControler.OnSelectCbEstado(Sender: TObject);
begin
  PopularComboBoxMunicipio(oListaEstados.Items[frmDetalhesCliente.cbEstado.Items
    [frmDetalhesCliente.cbEstado.ItemIndex]].IdUF);
end;

procedure TDetalhesClienteControler.OnSelectCbMunicipio(Sender: TObject);
begin
  PopularComboBoxBairro(oListaMunicipios.Items
    [frmDetalhesCliente.cbMunicipio.Items
    [frmDetalhesCliente.cbMunicipio.ItemIndex]].idMunicipio);
end;

procedure TDetalhesClienteControler.PopularComboBoxBairro(AID: Integer);
var
  sIndice: String;
  oBairroModel: IModelBairroInterface;
begin
  oBairroModel := TBairroModel.Create;
  oListaBairros.Clear;
  frmDetalhesCliente.cbBairro.Clear;
  frmDetalhesCliente.cbBairro.Enabled := True;
  if (oBairroModel.ADDListaHash(oListaBairros, AID)) then
  begin
    for sIndice in oListaBairros.Keys do
      frmDetalhesCliente.cbBairro.AddItem(sIndice, oListaBairros);
  end;
end;

procedure TDetalhesClienteControler.PopularComboBoxEstado;
var
  oEstadoModel: IModelEstadoInterface;
  sIndice: String;
begin
  oEstadoModel := TEstadoModel.Create;
  oListaEstados.Clear;
  frmDetalhesCliente.cbEstado.Clear;
  frmDetalhesCliente.cbMunicipio.Clear;
  if (oEstadoModel.ADDListaHash(oListaEstados)) then
  begin
    for sIndice in oListaEstados.Keys do
      frmDetalhesCliente.cbEstado.AddItem(sIndice, oListaEstados);
  end;
end;

procedure TDetalhesClienteControler.PopularComboBoxMunicipio(AID: Integer);
var
  sIndice: String;
  oMunicipioModel: IModelMunicipioInterface;
begin
  oMunicipioModel := TMunicipioModel.Create;
  oListaMunicipios.Clear;
  frmDetalhesCliente.cbMunicipio.Clear;
  frmDetalhesCliente.cbMunicipio.Enabled := True;
  if (oMunicipioModel.ADDListaHash(oListaMunicipios, AID)) then
  begin
    for sIndice in oListaMunicipios.Keys do
      frmDetalhesCliente.cbMunicipio.AddItem(sIndice, oListaMunicipios);
  end;
end;

procedure TDetalhesClienteControler.Salvar(Sender: TObject);
var
  bVerificaCpfCnpj: Boolean;
  bVerificaTelefoneCelular: Boolean;
begin
  if oClienteDto.idCliente > 0 then
  begin
    if MessageDlg('Você deseja alterar esse registro?', mtinformation,
      [mbyes, mbno], 0) = mryes then
      VerificaçãoSalvar
  end
  else
    VerificaçãoSalvar;
end;

procedure TDetalhesClienteControler.SetarFuncoesForm;
begin
  frmDetalhesCliente.cbEstado.OnSelect := OnSelectCbEstado;
  frmDetalhesCliente.cbMunicipio.OnSelect := OnSelectCbMunicipio;
  frmDetalhesCliente.BtnFechar.OnClick := FecharDetalhesUsuario;
  frmDetalhesCliente.OnActivate := OnActivateForm;
  frmDetalhesCliente.BtnSalvar.OnClick := Salvar;
end;

procedure TDetalhesClienteControler.ValoresCpfCnpj(var ACliente: TClienteDto);
begin
  ACliente.Cpf := oClienteDto.Cpf;
  ACliente.Cnpj := oClienteDto.Cnpj;
  oDetalhesClienteRegra.Limpar(oClienteDto);
end;

procedure TDetalhesClienteControler.VerificaçãoSalvar;
var
  bVerificaCpfCnpj: Boolean;
  bVerificaTelefoneCelular: Boolean;
begin
  oClienteDto.Cpf := Trim(frmDetalhesCliente.edtCpf.Text);
  oClienteDto.Nome := Trim(frmDetalhesCliente.edtNome.Text);
  oClienteDto.Observacao := Trim(frmDetalhesCliente.moObservacao.Lines.Text);
  oClienteDto.Cnpj := Trim(frmDetalhesCliente.edtCnpj.Text);
  oClienteDto.Celular := Trim(frmDetalhesCliente.edtCelular.Text);
  oClienteDto.Telefone := Trim(frmDetalhesCliente.edtTelefone.Text);
  oClienteDto.Rua := Trim(frmDetalhesCliente.edtRua.Text);
  oClienteDto.Cep := Trim(frmDetalhesCliente.edtCep.Text);

  if (oClienteDto.Cpf <> EmptyStr) or (oClienteDto.Cnpj <> EmptyStr) then
    bVerificaCpfCnpj := True
  else
    bVerificaCpfCnpj := False;

  if (oClienteDto.Telefone <> EmptyStr) or (oClienteDto.Celular <> EmptyStr)
  then
    bVerificaTelefoneCelular := True
  else
    bVerificaTelefoneCelular := False;

  if (oClienteDto.Nome <> EmptyStr) and (oClienteDto.Rua <> EmptyStr) and
    (frmDetalhesCliente.edtNumero.Text <> EmptyStr) and
    (oClienteDto.Cep <> EmptyStr) then
  begin
    if frmDetalhesCliente.cbEstado.ItemIndex > -1 then
    begin
      if frmDetalhesCliente.cbMunicipio.ItemIndex > -1 then
      begin
        if frmDetalhesCliente.cbBairro.ItemIndex > -1 then
        begin
          if bVerificaCpfCnpj then
          begin
            if bVerificaTelefoneCelular then
            begin
              oClienteDto.Numero := StrToInt(frmDetalhesCliente.edtNumero.Text);
              oClienteDto.oBairro.idBairro := oListaBairros.Items
                [frmDetalhesCliente.cbBairro.Items
                [frmDetalhesCliente.cbBairro.ItemIndex]].idBairro;
              oClienteDto.Complemento :=
                Trim(frmDetalhesCliente.edtComplemento.Text);
              try

                if (oDetalhesClienteRegra.Salvar(oDetalhesClienteModel,
                  oClienteDto)) then
                begin
                  FecharDetalhesUsuario(Self);
                end;
              except
                on E: Exception do
                  ShowMessage(E.Message);
              end;
            end
            else
              ShowMessage('Deve ser cadastrado o Telefone ou Celular');
          end
          else
            ShowMessage('Deve ser cadastrado o CPF ou CNPJ.');
        end
        else
          ShowMessage('Selecione um bairro.');
      end
      else
        ShowMessage('Selecione um municipio.');
    end
    else
      ShowMessage('Selecione um estado.');
  end
  else
    ShowMessage('Prencha todos os campos.');
end;

initialization

finalization

if Assigned(oDetalhesClienteControler) then
  FreeAndNil(oDetalhesClienteControler);

end.
