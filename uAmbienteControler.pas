unit uAmbienteControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uAmbienteDto,
  uAmbienteModel, uAmbiente, uAmbienteRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows, uEstadoDto,
  uInterfaceControler, uAmbienteInterfaceModel;

type
  TAmbienteControler = class(TInterfacedObject, IControlerInterface)

  private
    oAmbienteModel: IModelAmbienteInterface;
    oAmbienteDto: TAmbienteDto;
    oAmbienteRegra: TAmbienteRegra;
    oListaAmbientes: TObjectDictionary<string, TAmbienteDto>;
    frmAmbiente: TfrmAmbiente;

    procedure Excluir(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure ListarAmbientes;
    procedure Alterar(Sender: TObject);
    procedure fecharAmbiente(Sender: TObject);
    procedure Pesquisar(Sender: TObject);
    procedure OnKeyPressEdtPesquisa(Sender: TObject; var Key: Char);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    procedure abrirForm;

    constructor Create;
    destructor Destroy; override;
  end;

var
  oAmbienteControler: TAmbienteControler;

implementation

{ TAmbienteControler }

procedure TAmbienteControler.abrirForm;
begin
  if (not(Assigned(frmAmbiente))) then
    frmAmbiente := TfrmAmbiente.Create(nil);

  frmAmbiente.tsDados.Enabled := False;
  frmAmbiente.BtnSalvar.Enabled := False;
  frmAmbiente.BtnCancelar.Enabled := False;
  frmAmbiente.BtnFechar.OnClick := fecharAmbiente;
  frmAmbiente.BtnSalvar.OnClick := Salvar;
  frmAmbiente.btnInserir.OnClick := Inserir;
  frmAmbiente.BtnAlterar.OnClick := Alterar;
  frmAmbiente.BtnCancelar.OnClick := Cancelar;
  frmAmbiente.btnExcluir.OnClick := Excluir;
  ListarAmbientes;
  frmAmbiente.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmAmbiente.OnKeyDown := OnKeyDownForm;
  frmAmbiente.Show;
end;

procedure TAmbienteControler.Alterar(Sender: TObject);
begin
  oAmbienteDto.idAmbiente := frmAmbiente.DBGrid1.Fields[0].AsInteger;

  frmAmbiente.tsDados.Enabled := True;
  frmAmbiente.Caption := 'Alteração de Ambiente';
  frmAmbiente.edtDescricao.Text := frmAmbiente.DBGrid1.Fields[1].AsString;
  frmAmbiente.PageControl1.ActivePage := frmAmbiente.tsDados;
  frmAmbiente.tsTabela.Enabled := False;
  frmAmbiente.btnInserir.Enabled := False;
  frmAmbiente.BtnAlterar.Enabled := False;
  frmAmbiente.btnExcluir.Enabled := False;
  frmAmbiente.BtnSalvar.Enabled := True;
  frmAmbiente.BtnCancelar.Enabled := True;
end;

procedure TAmbienteControler.Cancelar(Sender: TObject);
begin
  frmAmbiente.tsTabela.Enabled := True;
  frmAmbiente.PageControl1.ActivePage := frmAmbiente.tsTabela;
  frmAmbiente.tsDados.Enabled := False;
  frmAmbiente.btnInserir.Enabled := True;
  frmAmbiente.BtnAlterar.Enabled := True;
  frmAmbiente.btnExcluir.Enabled := True;
  frmAmbiente.BtnSalvar.Enabled := False;
  frmAmbiente.BtnCancelar.Enabled := False;
  frmAmbiente.edtDescricao.Text := EmptyStr;
  frmAmbiente.Caption := 'Listagem de Ambientes';
  oAmbienteRegra.Limpar(oAmbienteDto);
end;

constructor TAmbienteControler.Create;
begin
  oAmbienteModel := TAmbienteModel.Create;
  oAmbienteDto := TAmbienteDto.Create;
  oAmbienteRegra := TAmbienteRegra.Create;
  oListaAmbientes := TObjectDictionary<string, TAmbienteDto>.Create
    ([doOwnsValues]);
end;

destructor TAmbienteControler.Destroy;
begin
  if Assigned(oAmbienteRegra) then
    FreeAndNil(oAmbienteRegra);

  if Assigned(oListaAmbientes) then
  begin
    oListaAmbientes.Clear;
    FreeAndNil(oListaAmbientes);
  end;

  if Assigned(oAmbienteDto) then
    FreeAndNil(oAmbienteDto);

  if Assigned(frmAmbiente) then
  begin
    frmAmbiente.Close;
    FreeAndNil(frmAmbiente);
  end;
  inherited;
end;

procedure TAmbienteControler.Excluir(Sender: TObject);
begin
  if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oAmbienteRegra.VerificarExcluir(oAmbienteModel,
      frmAmbiente.DBGrid1.Fields[0].AsInteger) then
    begin
      if oAmbienteRegra.Deletar(oAmbienteModel,
        frmAmbiente.DBGrid1.Fields[0].AsInteger) then
      begin
        ShowMessage('Excluido com sucesso.');
        ListarAmbientes;
      end
      else
        ShowMessage('Houve algum erro!!');
    end
    else
      ShowMessage
        ('Impossível excluir, pois existe um ou mais registros vinculados com esse!');
  end;
end;

procedure TAmbienteControler.fecharAmbiente(Sender: TObject);
begin
  if (not(Assigned(frmAmbiente))) then
    exit;

  oAmbienteRegra.Limpar(oAmbienteDto);
  frmAmbiente.Close;
  FreeAndNil(frmAmbiente);
end;

procedure TAmbienteControler.Inserir(Sender: TObject);
begin
  frmAmbiente.tsDados.Enabled := True;
  frmAmbiente.Caption := 'Cadastro de Ambiente';
  frmAmbiente.PageControl1.ActivePage := frmAmbiente.tsDados;
  frmAmbiente.tsTabela.Enabled := False;
  frmAmbiente.btnInserir.Enabled := False;
  frmAmbiente.BtnAlterar.Enabled := False;
  frmAmbiente.btnExcluir.Enabled := False;
  frmAmbiente.BtnSalvar.Enabled := True;
  frmAmbiente.BtnCancelar.Enabled := True;
  frmAmbiente.edtDescricao.SetFocus;
end;

procedure TAmbienteControler.ListarAmbientes;
begin
  oAmbienteModel.ListarAmbientes(frmAmbiente.dsTabela);
end;

procedure TAmbienteControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F2 then
    frmAmbiente.edtPesquisa.SetFocus;

  if Key = VK_F5 then
    ListarAmbientes;
end;

procedure TAmbienteControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin
  if Key = #8 then
  begin
    if Length(Trim(frmAmbiente.edtPesquisa.Text)) = 1 then
      ListarAmbientes
    else if Length(Trim(frmAmbiente.edtPesquisa.Text)) = 0 then
      ListarAmbientes;

  end;
end;

procedure TAmbienteControler.Pesquisar(Sender: TObject);
begin
  try
    oAmbienteRegra.Filtrar(oAmbienteModel, frmAmbiente.edtPesquisa.Text);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TAmbienteControler.Salvar(Sender: TObject);
begin
  oAmbienteDto.Descricao := frmAmbiente.edtDescricao.Text;
  if (oAmbienteDto.Descricao <> EmptyStr) then
  begin
    try
      if (oAmbienteRegra.Salvar(oAmbienteModel, oAmbienteDto)) then
      begin
        ShowMessage('Salvo com sucesso');
        oAmbienteRegra.Limpar(oAmbienteDto);
        frmAmbiente.edtDescricao.Text := EmptyStr;
        frmAmbiente.PageControl1.ActivePage := frmAmbiente.tsTabela;
        frmAmbiente.tsTabela.Enabled := True;
        frmAmbiente.btnInserir.Enabled := True;
        frmAmbiente.BtnAlterar.Enabled := True;
        frmAmbiente.btnExcluir.Enabled := True;
        frmAmbiente.BtnSalvar.Enabled := False;
        frmAmbiente.BtnCancelar.Enabled := False;
        frmAmbiente.Caption := 'Listagem de Ambientes';
        ListarAmbientes;
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);

    end
  end
  else
    ShowMessage('Prencha o campo Descrição.');

end;

initialization

finalization

if Assigned(oAmbienteControler) then
  FreeAndNil(oAmbienteControler);

end.
