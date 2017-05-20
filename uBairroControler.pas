unit uBairroControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uBairroDto,
  uBairroModel, uBairro, uMunicipioDto, uMunicipioModel, uBairroRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows;

type
  TBairroControler = class
  private
    oMunicipioModel: TMunicipioModel;
    oBairroModel: TBairroModel;
    oBairroDto: TBairroDto;
    oBairroRegra: TBairroRegra;
    oListaMunicipios: TObjectDictionary<string, TMunicipioDto>;
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
    procedure PopularComboBox;
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
  frmBairro.Show;
end;

procedure TBairroControler.Alterar(Sender: TObject);
begin
  oBairroDto.idBairro := frmBairro.DBGrid1.Fields[0].AsInteger;
  oBairroDto.oMunicipio.Nome := frmBairro.DBGrid1.Fields[2].AsString;
  frmBairro.tsDados.Enabled := True;
  frmBairro.Caption := 'Alteração de Bairro';
  frmBairro.edtNome.Text := frmBairro.DBGrid1.Fields[1].AsString;

  PopularComboBox;

  frmBairro.cbMunicipio.ItemIndex := frmBairro.cbMunicipio.Items.IndexOf
    (oBairroDto.oMunicipio.Nome);

  frmBairro.PageControl1.ActivePage := frmBairro.tsDados;
  frmBairro.tsTabela.Enabled := False;
  frmBairro.btnInserir.Enabled := False;
  frmBairro.BtnAlterar.Enabled := False;
  frmBairro.btnExcluir.Enabled := False;
  frmBairro.BtnSalvar.Enabled := True;
  frmBairro.BtnCancelar.Enabled := True;
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
  frmBairro.cbMunicipio.ItemIndex := -1;
  frmBairro.Caption := 'Listagem de Bairros';
  oBairroRegra.Limpar(oBairroDto);
end;

constructor TBairroControler.Create;
begin
  oMunicipioModel := TMunicipioModel.Create;
  oBairroModel := TBairroModel.Create;
  oBairroDto := TBairroDto.Create;
  oBairroRegra := TBairroRegra.Create;
  oListaMunicipios := TObjectDictionary<string, TMunicipioDto>.Create
    ([doOwnsValues]);
end;

destructor TBairroControler.Destroy;
begin
  if Assigned(oMunicipioModel) then
    FreeAndNil(oMunicipioModel);

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

  if Assigned(frmBairro) then
  begin
    frmBairro.Close;
    FreeAndNil(frmBairro);
  end;
  inherited;
end;

procedure TBairroControler.Excluir(Sender: TObject);
begin

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
  PopularComboBox;
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

procedure TBairroControler.Pesquisar(Sender: TObject);
begin

end;

procedure TBairroControler.PopularComboBox;
begin

end;

procedure TBairroControler.Salvar(Sender: TObject);
begin

end;

initialization

finalization
  if Assigned(oBairroControler) then
    FreeAndNil(oBairroControler);

end.
