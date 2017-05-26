unit uBairroControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uBairroDto,
  uBairroModel, uBairro, uMunicipioDto, uMunicipioModel, uBairroRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows, uEstadoDto,
  uEstadoModel, uInterfaceControler;

type
  TBairroControler = class(TInterfacedObject, IControlerInterface)
  private
    oBairroModel: TBairroModel;
    oBairroDto: TBairroDto;
    oBairroRegra: TBairroRegra;
    oListaMunicipios: TObjectDictionary<string, TMunicipioDto>;
    oListaEstados: TObjectDictionary<string, TEstadoDto>;
    frmBairro: TfrmBairro;

    procedure Excluir(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure ListarBairros;
    procedure Alterar(Sender: TObject);
    procedure fecharBairro(Sender: TObject);
    procedure Pesquisar(Sender: TObject);
    procedure OnKeyPressEdtPesquisa(Sender: TObject; var Key: Char);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PopularComboBoxEstado;
    procedure PopularComboBoxMunicipio(AID: Integer);
    procedure OnSelectCbEstado(Sender: TObject);
  public
    procedure abrirForm;

    constructor Create;
    destructor Destroy; override;
  end;

var
  oBairroControler: TBairroControler;

implementation

{ TMunicipioControler }

procedure TBairroControler.abrirForm;
begin
  if (not(Assigned(frmBairro))) then
    frmBairro := TfrmBairro.Create(nil);

  frmBairro.tsDados.Enabled := False;
  frmBairro.BtnSalvar.Enabled := False;
  frmBairro.BtnCancelar.Enabled := False;
  frmBairro.BtnFechar.OnClick := fecharBairro;
  frmBairro.BtnSalvar.OnClick := Salvar;
  frmBairro.btnInserir.OnClick := Inserir;
  frmBairro.BtnAlterar.OnClick := Alterar;
  frmBairro.BtnCancelar.OnClick := Cancelar;
  frmBairro.btnExcluir.OnClick := Excluir;
  ListarBairros;
  frmBairro.btnPesquisa.OnClick := Pesquisar;
  frmBairro.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmBairro.OnKeyDown := OnKeyDownForm;
  frmBairro.cbEstado.OnSelect := OnSelectCbEstado;
  frmBairro.Show;
end;

procedure TBairroControler.Alterar(Sender: TObject);
var
  sEstado: String;
  oEstadoModel: TEstadoModel;
begin
  oEstadoModel := TEstadoModel.Create;
  oBairroDto.idBairro := frmBairro.DBGrid1.Fields[0].AsInteger;
  oBairroDto.oMunicipio.Nome := frmBairro.DBGrid1.Fields[2].AsString;
  frmBairro.tsDados.Enabled := True;
  frmBairro.Caption := 'Alteração de Bairro';
  frmBairro.edtNome.Text := frmBairro.DBGrid1.Fields[1].AsString;
  sEstado := frmBairro.DBGrid1.Fields[3].AsString;
  PopularComboBoxEstado;

  frmBairro.cbEstado.ItemIndex := frmBairro.cbEstado.Items.IndexOf(sEstado);
  PopularComboBoxMunicipio(oEstadoModel.Buscar(sEstado));
  frmBairro.cbMunicipio.ItemIndex := frmBairro.cbMunicipio.Items.IndexOf
    (oBairroDto.oMunicipio.Nome);

  frmBairro.PageControl1.ActivePage := frmBairro.tsDados;
  frmBairro.tsTabela.Enabled := False;
  frmBairro.btnInserir.Enabled := False;
  frmBairro.BtnAlterar.Enabled := False;
  frmBairro.btnExcluir.Enabled := False;
  frmBairro.BtnSalvar.Enabled := True;
  frmBairro.BtnCancelar.Enabled := True;
  FreeAndNil(oEstadoModel);
end;

procedure TBairroControler.Cancelar(Sender: TObject);
begin
  frmBairro.tsTabela.Enabled := True;
  frmBairro.PageControl1.ActivePage := frmBairro.tsTabela;
  frmBairro.tsDados.Enabled := False;
  frmBairro.btnInserir.Enabled := True;
  frmBairro.BtnAlterar.Enabled := True;
  frmBairro.btnExcluir.Enabled := True;
  frmBairro.BtnSalvar.Enabled := False;
  frmBairro.BtnCancelar.Enabled := False;
  frmBairro.edtNome.Text := EmptyStr;
  frmBairro.cbEstado.ItemIndex := -1;
  frmBairro.cbMunicipio.ItemIndex := -1;
  frmBairro.Caption := 'Listagem de Bairros';
  frmBairro.cbMunicipio.Enabled := False;
  oBairroRegra.Limpar(oBairroDto);
end;

constructor TBairroControler.Create;
begin
  oBairroModel := TBairroModel.Create;
  oBairroDto := TBairroDto.Create;
  oBairroRegra := TBairroRegra.Create;
  oListaMunicipios := TObjectDictionary<string, TMunicipioDto>.Create
    ([doOwnsValues]);
  oListaEstados := TObjectDictionary<string, TEstadoDto>.Create([doOwnsValues]);
end;

destructor TBairroControler.Destroy;
begin

  if Assigned(oBairroModel) then
    FreeAndNil(oBairroModel);

  if Assigned(oBairroRegra) then
    FreeAndNil(oBairroRegra);

  if Assigned(oBairroDto) then
    FreeAndNil(oBairroDto);

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

  if Assigned(frmBairro) then
  begin
    frmBairro.Close;
    FreeAndNil(frmBairro);
  end;
  inherited;
end;

procedure TBairroControler.Excluir(Sender: TObject);
begin
  if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oBairroRegra.VerificarExcluir(oBairroModel,
      frmBairro.DBGrid1.Fields[0].AsInteger) then
    begin
      if oBairroRegra.Deletar(oBairroModel,
        frmBairro.DBGrid1.Fields[0].AsInteger) then
      begin
        ShowMessage('Excluido com sucesso.');
        ListarBairros;
      end
      else
        ShowMessage('Houve algum erro!!');
    end
    else
      ShowMessage
        ('Impossível excluir, pois existe um ou mais registros vinculados com esse!');
  end;
end;

procedure TBairroControler.fecharBairro(Sender: TObject);
begin
  if (not(Assigned(frmBairro))) then
    exit;

  oBairroRegra.Limpar(oBairroDto);
  frmBairro.Close;
  FreeAndNil(frmBairro);
end;

procedure TBairroControler.Inserir(Sender: TObject);
begin
  frmBairro.tsDados.Enabled := True;
  frmBairro.Caption := 'Cadastro de Bairro';
  frmBairro.PageControl1.ActivePage := frmBairro.tsDados;
  frmBairro.tsTabela.Enabled := False;
  frmBairro.btnInserir.Enabled := False;
  frmBairro.BtnAlterar.Enabled := False;
  frmBairro.btnExcluir.Enabled := False;
  frmBairro.BtnSalvar.Enabled := True;
  frmBairro.BtnCancelar.Enabled := True;
  frmBairro.edtNome.SetFocus;
  PopularComboBoxEstado;
end;

procedure TBairroControler.ListarBairros;
begin
  oBairroModel.ListarBairros(frmBairro.dsTabela);
end;

procedure TBairroControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    frmBairro.edtPesquisa.SetFocus;

  if Key = VK_F5 then
    ListarBairros;
end;

procedure TBairroControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin
  if Key = #8 then
  begin
    if Length(Trim(frmBairro.edtPesquisa.Text)) = 1 then
      ListarBairros;
  end;

  if Key = #13 then
    frmBairro.btnPesquisa.Click;
end;

procedure TBairroControler.OnSelectCbEstado(Sender: TObject);
begin
  PopularComboBoxMunicipio(oListaEstados.Items[frmBairro.cbEstado.Items
    [frmBairro.cbEstado.ItemIndex]].IdUF);
end;

procedure TBairroControler.Pesquisar(Sender: TObject);
begin
  if (Trim(frmBairro.edtPesquisa.Text) <> EmptyStr) then
  begin
    if (oBairroRegra.Pesquisar(oBairroModel, frmBairro.edtPesquisa.Text) = False)
    then
      ShowMessage('Nenhum registro encontrado.');
  end
  else
    ShowMessage('Campo pesquisa vazio.');
end;

procedure TBairroControler.PopularComboBoxMunicipio(AID: Integer);
var
  sIndice: String;
  oMunicipioModel: TMunicipioModel;
begin
  oMunicipioModel := TMunicipioModel.Create;
  oListaMunicipios.Clear;
  frmBairro.cbMunicipio.Clear;
  frmBairro.cbMunicipio.Enabled := True;
  if (oMunicipioModel.ADDListaHash(oListaMunicipios, AID)) then
  begin
    for sIndice in oListaMunicipios.Keys do
      frmBairro.cbMunicipio.AddItem(sIndice, oListaMunicipios);
  end;

  if Assigned(oMunicipioModel) then
    FreeAndNil(oMunicipioModel);
end;

procedure TBairroControler.PopularComboBoxEstado;
var
  oEstadoModel: TEstadoModel;
  sIndice: String;
begin
  oEstadoModel := TEstadoModel.Create;
  oListaEstados.Clear;
  frmBairro.cbEstado.Clear;
  frmBairro.cbMunicipio.Clear;
  if (oEstadoModel.ADDListaHash(oListaEstados)) then
  begin
    for sIndice in oListaEstados.Keys do
      frmBairro.cbEstado.AddItem(sIndice, oListaEstados);
  end;

  if Assigned(oEstadoModel) then
    FreeAndNil(oEstadoModel);
end;

procedure TBairroControler.Salvar(Sender: TObject);
begin
  oBairroDto.Nome := Trim(frmBairro.edtNome.Text);
  oBairroDto.oMunicipio.idMunicipio := oListaMunicipios.Items
    [frmBairro.cbMunicipio.Items[frmBairro.cbMunicipio.ItemIndex]].idMunicipio;

  if (oBairroDto.Nome <> '') and (frmBairro.cbEstado.ItemIndex <> -1) then
  begin
    ShowMessage(oBairroRegra.Salvar(oBairroModel, oBairroDto));

    oBairroRegra.Limpar(oBairroDto);
    frmBairro.edtNome.Text := EmptyStr;
    frmBairro.cbEstado.ItemIndex := -1;
    frmBairro.PageControl1.ActivePage := frmBairro.tsTabela;
    frmBairro.tsTabela.Enabled := True;
    frmBairro.btnInserir.Enabled := True;
    frmBairro.BtnAlterar.Enabled := True;
    frmBairro.btnExcluir.Enabled := True;
    frmBairro.BtnSalvar.Enabled := False;
    frmBairro.BtnCancelar.Enabled := False;
    frmBairro.Caption := 'Listagem de Municipios';
    ListarBairros;
  end
  else
    ShowMessage('Prencha todos os campos');
end;

initialization

finalization

if Assigned(oBairroControler) then
  FreeAndNil(oBairroControler);

end.
