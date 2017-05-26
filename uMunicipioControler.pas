unit uMunicipioControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uMunicipioDto,
  uMunicipioModel, uMunicipio, uEstadoDto, uEstadoModel, uMunicipioRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows, uInterfaceControler;

type
  TMunicipioControler = class(TInterfacedObject, IControlerInterface)
  private
    oListaEstados: TObjectDictionary<string, TEstadoDto>;
    oModelMunicipio: TMunicipioModel;
    oRegraMunicipio: TMunicipioRegra;
    oMunicipioDto: TMunicipioDto;
    frmMunicipio: TfrmMunicipio;

    procedure ListarMunicipios;
    procedure fecharMunicipio(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Alterar(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure Pesquisar(Sender: TObject);
    procedure OnKeyPressEdtPesquisa(Sender: TObject; var Key: Char);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PopularComboBox;
  public
    procedure AbrirForm;

    constructor Create;
    destructor Destroy; override;

  end;

var
  oMunicipioControler: TMunicipioControler;

implementation

{ TMunicipioControler }

procedure TMunicipioControler.AbrirForm;
begin
  if (not(Assigned(frmMunicipio))) then
    frmMunicipio := TfrmMunicipio.Create(nil);

  frmMunicipio.tsDados.Enabled := False;
  frmMunicipio.BtnSalvar.Enabled := False;
  frmMunicipio.BtnCancelar.Enabled := False;
  frmMunicipio.BtnFechar.OnClick := fecharMunicipio;
  frmMunicipio.BtnSalvar.OnClick := Salvar;
  frmMunicipio.btnInserir.OnClick := Inserir;
  frmMunicipio.BtnAlterar.OnClick := Alterar;
  frmMunicipio.BtnCancelar.OnClick := Cancelar;
  frmMunicipio.btnExcluir.OnClick := Excluir;
  ListarMunicipios;
  frmMunicipio.btnPesquisa.OnClick := Pesquisar;
  frmMunicipio.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmMunicipio.OnKeyDown := OnKeyDownForm;
  frmMunicipio.Show;

end;

procedure TMunicipioControler.Alterar(Sender: TObject);
begin
  oMunicipioDto.idMunicipio := frmMunicipio.DBGrid1.Fields[0].AsInteger;
  oMunicipioDto.oEstado.Nome := frmMunicipio.DBGrid1.Fields[2].AsString;
  frmMunicipio.tsDados.Enabled := True;
  frmMunicipio.Caption := 'Alteração de Municipio';
  frmMunicipio.edtNome.Text := frmMunicipio.DBGrid1.Fields[1].AsString;

  PopularComboBox;

  frmMunicipio.cbEstado.ItemIndex := frmMunicipio.cbEstado.Items.IndexOf
    (oMunicipioDto.oEstado.Nome);

  frmMunicipio.PageControl1.ActivePage := frmMunicipio.tsDados;
  frmMunicipio.tsTabela.Enabled := False;
  frmMunicipio.btnInserir.Enabled := False;
  frmMunicipio.BtnAlterar.Enabled := False;
  frmMunicipio.btnExcluir.Enabled := False;
  frmMunicipio.BtnSalvar.Enabled := True;
  frmMunicipio.BtnCancelar.Enabled := True;
end;

procedure TMunicipioControler.Cancelar(Sender: TObject);
begin
  frmMunicipio.tsTabela.Enabled := True;
  frmMunicipio.PageControl1.ActivePage := frmMunicipio.tsTabela;
  frmMunicipio.tsDados.Enabled := False;
  frmMunicipio.btnInserir.Enabled := True;
  frmMunicipio.BtnAlterar.Enabled := True;
  frmMunicipio.btnExcluir.Enabled := True;
  frmMunicipio.BtnSalvar.Enabled := False;
  frmMunicipio.BtnCancelar.Enabled := False;
  frmMunicipio.edtNome.Text := EmptyStr;
  frmMunicipio.cbEstado.ItemIndex := -1;
  frmMunicipio.Caption := 'Listagem de Municipios';
  oRegraMunicipio.Limpar(oMunicipioDto);
end;

constructor TMunicipioControler.Create;
begin
  oModelMunicipio := TMunicipioModel.Create;
  oListaEstados := TObjectDictionary<string, TEstadoDto>.Create([doOwnsValues]);
  oRegraMunicipio := TMunicipioRegra.Create;
  oMunicipioDto := TMunicipioDto.Create;
end;

destructor TMunicipioControler.Destroy;
begin
  if Assigned(oModelMunicipio) then
    FreeAndNil(oModelMunicipio);

  if Assigned(oRegraMunicipio) then
    FreeAndNil(oRegraMunicipio);

  if Assigned(oMunicipioDto) then
    FreeAndNil(oMunicipioDto);

  if Assigned(oListaEstados) then
  begin
    oListaEstados.Clear;
    FreeAndNil(oListaEstados);
  end;

  if Assigned(frmMunicipio) then
  begin
    frmMunicipio.Close;
    FreeAndNil(frmMunicipio);
  end;
  inherited;
end;

procedure TMunicipioControler.Excluir(Sender: TObject);
begin
  if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oRegraMunicipio.VerificarExcluir(oModelMunicipio,
      frmMunicipio.DBGrid1.Fields[0].AsInteger) then
    begin
      if oRegraMunicipio.Deletar(oModelMunicipio,
        frmMunicipio.DBGrid1.Fields[0].AsInteger) then
      begin
        ShowMessage('Excluido com sucesso.');
        ListarMunicipios;
      end
      else
        ShowMessage('Houve algum erro!!');
    end
    else
      ShowMessage
        ('Impossível excluir, pois existe um ou mais registros vinculados com esse!');
  end;
end;

procedure TMunicipioControler.fecharMunicipio(Sender: TObject);
begin
  if (not(Assigned(frmMunicipio))) then
    exit;

  oRegraMunicipio.Limpar(oMunicipioDto);
  frmMunicipio.Close;
  FreeAndNil(frmMunicipio);
end;

procedure TMunicipioControler.Inserir(Sender: TObject);
begin
  frmMunicipio.tsDados.Enabled := True;
  frmMunicipio.Caption := 'Cadastro de Municpio';
  frmMunicipio.PageControl1.ActivePage := frmMunicipio.tsDados;
  frmMunicipio.tsTabela.Enabled := False;
  frmMunicipio.btnInserir.Enabled := False;
  frmMunicipio.BtnAlterar.Enabled := False;
  frmMunicipio.btnExcluir.Enabled := False;
  frmMunicipio.BtnSalvar.Enabled := True;
  frmMunicipio.BtnCancelar.Enabled := True;
  frmMunicipio.edtNome.SetFocus;
  PopularComboBox;
end;

procedure TMunicipioControler.ListarMunicipios;
begin
  oModelMunicipio.ListarMunicipios(frmMunicipio.dsTabela);
end;

procedure TMunicipioControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_F2 then
    frmMunicipio.edtPesquisa.SetFocus;

  if Key = VK_F5 then
    ListarMunicipios;
end;

procedure TMunicipioControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin
  if Key = #8 then
  begin
    if Length(Trim(frmMunicipio.edtPesquisa.Text)) = 1 then
      ListarMunicipios;
  end;

  if Key = #13 then
    frmMunicipio.btnPesquisa.Click;
end;

procedure TMunicipioControler.Pesquisar(Sender: TObject);
begin
  if (Trim(frmMunicipio.edtPesquisa.Text) <> EmptyStr) then
  begin
    if (oRegraMunicipio.Pesquisar(oModelMunicipio,
      frmMunicipio.edtPesquisa.Text) = False) then
      ShowMessage('Nenhum registro encontrado.');
  end
  else
    ShowMessage('Campo pesquisa vazio.');
end;

procedure TMunicipioControler.PopularComboBox;
var
  sIndice: String;
  oModelEstado: TEstadoModel;
begin
  oModelEstado := TEstadoModel.Create;
  oListaEstados.Clear;
  frmMunicipio.cbEstado.Clear;
  if (oModelEstado.ADDListaHash(oListaEstados)) then
  begin
    for sIndice in oListaEstados.Keys do
      frmMunicipio.cbEstado.AddItem(sIndice, oListaEstados);
  end;

  if Assigned(oModelEstado) then
    FreeAndNil(oModelEstado);
end;

procedure TMunicipioControler.Salvar(Sender: TObject);
begin
  oMunicipioDto.Nome := Trim(frmMunicipio.edtNome.Text);
  oMunicipioDto.oEstado.IdUF := oListaEstados.Items
    [frmMunicipio.cbEstado.Items[frmMunicipio.cbEstado.ItemIndex]].IdUF;

  if (oMunicipioDto.Nome <> '') and (frmMunicipio.cbEstado.ItemIndex <> -1) then
  begin
    ShowMessage(oRegraMunicipio.Salvar(oModelMunicipio, oMunicipioDto));

    oRegraMunicipio.Limpar(oMunicipioDto);
    frmMunicipio.edtNome.Text := EmptyStr;
    frmMunicipio.cbEstado.ItemIndex := -1;
    frmMunicipio.PageControl1.ActivePage := frmMunicipio.tsTabela;
    frmMunicipio.tsTabela.Enabled := True;
    frmMunicipio.btnInserir.Enabled := True;
    frmMunicipio.BtnAlterar.Enabled := True;
    frmMunicipio.btnExcluir.Enabled := True;
    frmMunicipio.BtnSalvar.Enabled := False;
    frmMunicipio.BtnCancelar.Enabled := False;
    frmMunicipio.Caption := 'Listagem de Municipios';
    ListarMunicipios;
  end
  else
    ShowMessage('Prencha todos os campos');
end;

initialization

finalization

if Assigned(oMunicipioControler) then
  FreeAndNil(oMunicipioControler);

end.
