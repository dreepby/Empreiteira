unit uEstadoController;

interface

uses
  System.SysUtils, Data.DB, uEstadoDto, uEstadoModel, uEstado, uEstadoRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows, uInterfaceControler,
  uEstadoInterfaceModel;

type
  TEstadoControler = class(TInterfacedObject, IControlerInterface)
  private
    oModelEstado: IModelEstadoInterface;
    oEstadoDto: TEstadoDto;
    oRegraEstado: TEstadoRegra;
    frmEstados: TfrmEstados;

    procedure Excluir(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure ListarEstados;
    procedure Alterar(Sender: TObject);
    procedure fecharEstado(Sender: TObject);
    procedure OnChangeEdtPesquisa(Sender: TObject);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure OnExitEdtUf(Sender: TObject);
  public
    procedure abrirForm;

    constructor Create;
    destructor Destroy; override;
  end;

var
  oEstadoControler: TEstadoControler;

implementation

{ TEstadoControler }

procedure TEstadoControler.abrirForm;
begin
  if (not(Assigned(frmEstados))) then
  begin
    frmEstados := TfrmEstados.Create(nil);

    frmEstados.tsDados.Enabled := False;
    frmEstados.BtnSalvar.Enabled := False;
    frmEstados.BtnCancelar.Enabled := False;
    frmEstados.BtnFechar.OnClick := fecharEstado;
    frmEstados.BtnSalvar.OnClick := Salvar;
    frmEstados.btnInserir.OnClick := Inserir;
    frmEstados.BtnAlterar.OnClick := Alterar;
    frmEstados.BtnCancelar.OnClick := Cancelar;
    frmEstados.btnExcluir.OnClick := Excluir;
    ListarEstados;
    frmEstados.OnActivate := FormActivate;
    frmEstados.OnKeyDown := OnKeyDownForm;
    frmEstados.edtPesquisa.OnChange := OnChangeEdtPesquisa;
    frmEstados.edtUF.OnExit := OnExitEdtUf;
    frmEstados.Show;
  end
  else
    frmEstados.Show;
end;

procedure TEstadoControler.Alterar(Sender: TObject);
begin

  oEstadoDto.IdUF := frmEstados.DBGrid1.Fields[0].AsInteger;
  frmEstados.edtPesquisa.Enabled := False;
  frmEstados.tsDados.Enabled := True;
  frmEstados.Caption := 'Alteração de Estado';
  frmEstados.edtNome.Text := frmEstados.DBGrid1.Fields[2].AsString;
  frmEstados.edtUF.Text := frmEstados.DBGrid1.Fields[1].AsString;
  frmEstados.PageControl1.ActivePage := frmEstados.tsDados;
  frmEstados.tsTabela.Enabled := False;
  frmEstados.btnInserir.Enabled := False;
  frmEstados.BtnAlterar.Enabled := False;
  frmEstados.btnExcluir.Enabled := False;
  frmEstados.BtnSalvar.Enabled := True;
  frmEstados.BtnCancelar.Enabled := True;
  frmEstados.BtnAlterar.Enabled := False;

end;

procedure TEstadoControler.Cancelar(Sender: TObject);
begin
  frmEstados.tsTabela.Enabled := True;
  frmEstados.PageControl1.ActivePage := frmEstados.tsTabela;
  frmEstados.tsDados.Enabled := False;
  frmEstados.btnInserir.Enabled := True;
  frmEstados.BtnAlterar.Enabled := True;
  frmEstados.btnExcluir.Enabled := True;
  frmEstados.BtnSalvar.Enabled := False;
  frmEstados.BtnCancelar.Enabled := False;
  frmEstados.edtNome.Text := EmptyStr;
  frmEstados.edtUF.Text := EmptyStr;
  frmEstados.Caption := 'Listagem de Estados';
  oRegraEstado.Limpar(oEstadoDto);
  frmEstados.edtPesquisa.Enabled := True;
  ListarEstados;
end;

constructor TEstadoControler.Create;
begin
  oModelEstado := TEstadoModel.Create;
  oRegraEstado := TEstadoRegra.Create;
  oEstadoDto := TEstadoDto.Create;
end;

destructor TEstadoControler.Destroy;
begin
  if Assigned(oEstadoDto) then
    FreeAndNil(oEstadoDto);

  if Assigned(oRegraEstado) then
    FreeAndNil(oRegraEstado);

  if Assigned(frmEstados) then
  begin
    frmEstados.Close;
    FreeAndNil(frmEstados);
  end;
  inherited;
end;

procedure TEstadoControler.Excluir(Sender: TObject);
begin
  if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oRegraEstado.VerificarExcluir(oModelEstado,
      frmEstados.DBGrid1.Fields[0].AsInteger) then
    begin
      if oRegraEstado.Deletar(oModelEstado, frmEstados.DBGrid1.Fields[0]
        .AsInteger) then
      begin
        ShowMessage('Excluido com sucesso.');
        ListarEstados;
      end
      else
        ShowMessage('Houve algum erro!!');
    end
    else
      ShowMessage
        ('Impossível excluir, pois existe um ou mais registros vinculados com esse!');
  end;
end;

procedure TEstadoControler.fecharEstado(Sender: TObject);
begin
  if (not(Assigned(frmEstados))) then
    exit;

  oRegraEstado.Limpar(oEstadoDto);
  frmEstados.Close;
  FreeAndNil(frmEstados);
end;

procedure TEstadoControler.FormActivate(Sender: TObject);
begin
  frmEstados.btnInserir.Enabled := False;
  ListarEstados;
end;

procedure TEstadoControler.Inserir(Sender: TObject);
begin
  frmEstados.tsDados.Enabled := True;
  frmEstados.Caption := 'Cadastro de Estado';
  frmEstados.PageControl1.ActivePage := frmEstados.tsDados;
  frmEstados.tsTabela.Enabled := False;
  frmEstados.BtnAlterar.Enabled := False;
  frmEstados.btnExcluir.Enabled := False;
  frmEstados.BtnSalvar.Enabled := True;
  frmEstados.BtnCancelar.Enabled := True;
  frmEstados.edtPesquisa.Enabled := False;
  frmEstados.edtUF.SetFocus;
end;

procedure TEstadoControler.ListarEstados;
begin
  oModelEstado.ListarEstados(frmEstados.dsTabela);
  if oModelEstado.IsEmpty then
  begin
    frmEstados.BtnAlterar.Enabled := False;
    frmEstados.btnExcluir.Enabled := False;
  end
  else
  begin
    frmEstados.BtnAlterar.Enabled := True;
    frmEstados.btnExcluir.Enabled := True;
  end;
end;

procedure TEstadoControler.OnChangeEdtPesquisa(Sender: TObject);
begin
  if oModelEstado.Localizar(frmEstados.edtPesquisa.Text) then
  begin
    frmEstados.btnExcluir.Enabled := False;
    frmEstados.BtnAlterar.Enabled := False;
  end
  else
  begin
    frmEstados.btnExcluir.Enabled := True;
    frmEstados.BtnAlterar.Enabled := True;
  end;
end;

procedure TEstadoControler.OnExitEdtUf(Sender: TObject);
var
  iCodigo: Integer;
begin
  oEstadoDto.UF := frmEstados.edtUF.Text;
  if oModelEstado.VerificarUF(oEstadoDto, iCodigo) then
  begin
    if not(oEstadoDto.IdUF = iCodigo) then
    begin
      frmEstados.edtUF.SetFocus;
      ShowMessage('UF já cadastrada.');
    end;
  end;
end;

procedure TEstadoControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if frmEstados.edtPesquisa.Enabled then
  begin
    if Key = VK_F2 then
      frmEstados.edtPesquisa.SetFocus;

    if Key = VK_F5 then
      ListarEstados;
  end;
end;

procedure TEstadoControler.Salvar(Sender: TObject);
begin
  frmEstados.BtnSalvar.Enabled := False;
  oEstadoDto.UF := Trim(frmEstados.edtUF.Text);
  oEstadoDto.Nome := Trim(frmEstados.edtNome.Text);

  if (oEstadoDto.UF <> EmptyStr) and (oEstadoDto.Nome <> EmptyStr) then
  begin

    ShowMessage(oRegraEstado.Salvar(oModelEstado, oEstadoDto));

    oRegraEstado.Limpar(oEstadoDto);
    frmEstados.edtNome.Text := EmptyStr;
    frmEstados.edtUF.Text := EmptyStr;
    frmEstados.edtUF.SetFocus;

  end
  else
    ShowMessage('Prencha todos os campos');
  frmEstados.BtnSalvar.Enabled := True;
end;

initialization

finalization

if Assigned(oEstadoControler) then
  FreeAndNil(oEstadoControler);

end.
