unit uUsuarioControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections,
  uUsuario, uUsuarioDto, uUsuarioModel, uUsuarioRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows, uInterfaceControler,
  uUsuarioIntefaceModel;

type
  TUsuarioControler = class(TInterfacedObject, IControlerInterface)
  private

    oModelUsuario: IModelUsuarioInterface;
    oRegraUsuario: TUsuarioRegra;
    oUsuarioDto: TUsuarioDto;
    frmUsuario: TfrmUsuario;

    procedure ListarUsuarios;
    procedure fecharUsuario(Sender: TObject);
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
  oUsuarioControler: TUsuarioControler;

implementation

{ TUsuarioControler }

procedure TUsuarioControler.AbrirForm;
begin
  if (not(Assigned(frmUsuario))) then
    frmUsuario := TfrmUsuario.Create(nil);

  frmUsuario.tsDados.Enabled := False;
  frmUsuario.BtnSalvar.Enabled := False;
  frmUsuario.BtnCancelar.Enabled := False;
  frmUsuario.BtnFechar.OnClick := fecharUsuario;
  frmUsuario.BtnSalvar.OnClick := Salvar;
  frmUsuario.btnInserir.OnClick := Inserir;
  frmUsuario.BtnAlterar.OnClick := Alterar;
  frmUsuario.BtnCancelar.OnClick := Cancelar;
  frmUsuario.btnExcluir.OnClick := Excluir;
  ListarUsuarios;
  frmUsuario.btnPesquisa.OnClick := Pesquisar;
  frmUsuario.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmUsuario.OnKeyDown := OnKeyDownForm;
  frmUsuario.Show;
end;

procedure TUsuarioControler.Alterar(Sender: TObject);
begin
  oUsuarioDto.idUsuario := frmUsuario.DBGrid1.Fields[0].AsInteger;
  oUsuarioDto.Nome := frmUsuario.DBGrid1.Fields[1].AsString;
  oUsuarioDto.CPF := frmUsuario.DBGrid1.Fields[2].AsString;
  frmUsuario.Caption := 'Alteração de Usuario';
  frmUsuario.edtNome.Text := frmUsuario.DBGrid1.Fields[1].AsString;
  frmUsuario.edtCPF.Text := frmUsuario.DBGrid1.Fields[2].AsString;

  frmUsuario.PageControl1.ActivePage := frmUsuario.tsDados;
  frmUsuario.tsTabela.Enabled := False;
  frmUsuario.tsDados.Enabled := True;
  frmUsuario.btnInserir.Enabled := False;
  frmUsuario.BtnAlterar.Enabled := False;
  frmUsuario.btnExcluir.Enabled := False;
  frmUsuario.BtnSalvar.Enabled := True;
  frmUsuario.BtnCancelar.Enabled := True;
end;

procedure TUsuarioControler.Cancelar(Sender: TObject);
begin
  frmUsuario.tsTabela.Enabled := True;
  frmUsuario.PageControl1.ActivePage := frmUsuario.tsTabela;
  frmUsuario.tsDados.Enabled := False;
  frmUsuario.btnInserir.Enabled := True;
  frmUsuario.BtnAlterar.Enabled := True;
  frmUsuario.btnExcluir.Enabled := True;
  frmUsuario.BtnSalvar.Enabled := False;
  frmUsuario.BtnCancelar.Enabled := False;
  frmUsuario.edtNome.Text := EmptyStr;
  frmUsuario.Caption := 'Listagem de Usuários';
  oRegraUsuario.Limpar(oUsuarioDto);
end;

constructor TUsuarioControler.Create;
begin
  oModelUsuario := TUsuarioModel.Create;
  oRegraUsuario := TUsuarioRegra.Create;
  oUsuarioDto := TUsuarioDto.Create;
end;

destructor TUsuarioControler.Destroy;
begin
  if Assigned(oUsuarioDto) then
    FreeAndNil(oUsuarioDto);

  if Assigned(oRegraUsuario) then
    FreeAndNil(oRegraUsuario);

  // if Assigned(oModelUsuario) then
  // FreeAndNil(oModelUsuario);

  if (Assigned(frmUsuario)) then
  begin
    frmUsuario.Close;
    FreeAndNil(frmUsuario);
  end;
  inherited;
end;

procedure TUsuarioControler.Excluir(Sender: TObject);
begin
if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oRegraUsuario.VerificarExcluir(oModelUsuario,
      frmUsuario.DBGrid1.Fields[0].AsInteger) then
    begin
      if oRegraUsuario.Deletar(oModelUsuario,
        frmUsuario.DBGrid1.Fields[0].AsInteger) then
      begin
        ShowMessage('Excluido com sucesso.');
        ListarUsuarios;
      end
      else
        ShowMessage('Houve algum erro!!');
    end
    else
      ShowMessage
        ('Impossível excluir, pois existe um ou mais registros vinculados com esse!');
  end;
end;

procedure TUsuarioControler.fecharUsuario(Sender: TObject);
begin
  if (not(Assigned(frmUsuario))) then
    exit;

  oRegraUsuario.Limpar(oUsuarioDto);
  frmUsuario.Close;
  FreeAndNil(frmUsuario);
end;

procedure TUsuarioControler.Inserir(Sender: TObject);
begin
  frmUsuario.tsDados.Enabled := True;
  frmUsuario.Caption := 'Cadastro de Usuário';
  frmUsuario.PageControl1.ActivePage := frmUsuario.tsDados;
  frmUsuario.tsTabela.Enabled := False;
  frmUsuario.btnInserir.Enabled := False;
  frmUsuario.BtnAlterar.Enabled := False;
  frmUsuario.btnExcluir.Enabled := False;
  frmUsuario.BtnSalvar.Enabled := True;
  frmUsuario.BtnCancelar.Enabled := True;
  frmUsuario.edtNome.SetFocus;
  PopularComboBox;
end;

procedure TUsuarioControler.ListarUsuarios;
begin
  oRegraUsuario.ListarUsuarios(oModelUsuario, frmUsuario.dsTabela);
end;

procedure TUsuarioControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TUsuarioControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin

end;

procedure TUsuarioControler.Pesquisar(Sender: TObject);
begin

end;

procedure TUsuarioControler.PopularComboBox;
begin

end;

procedure TUsuarioControler.Salvar(Sender: TObject);
begin
  oUsuarioDto.Nome := Trim(frmUsuario.edtNome.Text);
  oUsuarioDto.CPF := Trim(frmUsuario.edtCPF.Text);

  if (oUsuarioDto.Nome <> EmptyStr) and (oUsuarioDto.CPF <> EmptyStr) then
  begin
    try
      if (oRegraUsuario.Salvar(oModelUsuario, oUsuarioDto)) then
      begin
        ShowMessage('Salvo com sucesso');
        oRegraUsuario.Limpar(oUsuarioDto);
        frmUsuario.edtNome.Text := EmptyStr;
        frmUsuario.edtCPF.Text := EmptyStr;
        frmUsuario.PageControl1.ActivePage := frmUsuario.tsTabela;
        frmUsuario.tsTabela.Enabled := True;
        frmUsuario.btnInserir.Enabled := True;
        frmUsuario.BtnAlterar.Enabled := True;
        frmUsuario.btnExcluir.Enabled := True;
        frmUsuario.BtnSalvar.Enabled := False;
        frmUsuario.BtnCancelar.Enabled := False;
        frmUsuario.Caption := 'Listagem de Usuários';
        ListarUsuarios;
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);

    end
  end
  else
    ShowMessage('Prencha todos os campos');
end;

initialization

finalization

if Assigned(oUsuarioControler) then
  FreeAndNil(oUsuarioControler);

end.
