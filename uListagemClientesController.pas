unit uListagemClientesController;

interface

uses
  System.SysUtils, Data.DB, uClienteModel,
  uListagemClientes,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows,
  uClienteInterfaceModel, uClienteDto, uClienteRegra, Vcl.DBGrids,
  uClienteControler;

type
  TConfirmaCliente = procedure(const ACNPJ: String) of object;

  TFormParaFrenteReforma = procedure of object;

  TListagemClientesControler = class
  private
    oModelCliente: IModelClienteInterface;
    frmListagemClientes: TfrmListagemClientes;
    oClienteDto: TClienteDto;
    oClienteRegra: TClienteRegra;
    oClienteControler: TClienteControler;
    oConfirmaCliente: TConfirmaCliente;
    oFormReformaParaFrente: TFormParaFrenteReforma;
    sCampo: String;

    procedure Inserir(Sender: TObject);
    procedure ListarClientes;
    procedure Alterar(Sender: TObject);
    procedure fecharForm(Sender: TObject);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Selecionar(Sender: TObject);
    procedure OnDblClickDbGrid(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OnChangeEdtpesquisa(Sender: TObject);
    procedure OnSelectCbPesquisa(Sender: TObject);
    procedure OnKeyPressGrid(Sender: TObject; var Key: Char);
  public
    procedure abrirForm(AOwner: TComponent; oAtualizarCliente: TConfirmaCliente;
      oFormParaFrente: TFormParaFrenteReforma);

    constructor Create;
    destructor Destroy; override;
  end;

var
  oListagemControler: TListagemClientesControler;

implementation

{ TEstadoControler }

procedure TListagemClientesControler.abrirForm(AOwner: TComponent;
  oAtualizarCliente: TConfirmaCliente; oFormParaFrente: TFormParaFrenteReforma);
begin
  if (not(Assigned(frmListagemClientes))) then
    frmListagemClientes := TfrmListagemClientes.Create(AOwner);

  oConfirmaCliente := oAtualizarCliente;
  oFormReformaParaFrente := oFormParaFrente;
  frmListagemClientes.cbPesquisa.ItemIndex := 0;
  OnSelectCbPesquisa(Self);
  frmListagemClientes.cbPesquisa.OnSelect := OnSelectCbPesquisa;
  frmListagemClientes.edtPesquisa.OnChange := OnChangeEdtpesquisa;
  frmListagemClientes.btnInserir.OnClick := Inserir;
  frmListagemClientes.BtnAlterar.OnClick := Alterar;
  frmListagemClientes.BtnFechar.OnClick := fecharForm;
  frmListagemClientes.btnSelecionar.OnClick := Selecionar;
  frmListagemClientes.DBGrid1.OnKeyPress := OnKeyPressGrid;
  ListarClientes;
  frmListagemClientes.OnKeyDown := OnKeyDownForm;
  frmListagemClientes.DBGrid1.OnDblClick := OnDblClickDbGrid;
  frmListagemClientes.OnActivate := FormActivate;
  frmListagemClientes.DBGrid1.SetFocus;
  frmListagemClientes.Show;
end;

procedure TListagemClientesControler.Alterar(Sender: TObject);
begin
  oClienteControler.AbrirFormAlterar(frmListagemClientes.DBGrid1.Fields[0]
    .AsInteger);
end;

constructor TListagemClientesControler.Create;
begin
  oModelCliente := TClienteModel.Create;
  oClienteDto := TClienteDto.Create;
  oClienteRegra := TClienteRegra.Create;
  oClienteControler := TClienteControler.Create;
end;

destructor TListagemClientesControler.Destroy;
begin

  if Assigned(oClienteRegra) then
    FreeAndNil(oClienteRegra);

  if Assigned(oClienteDto) then
    FreeAndNil(oClienteDto);

  if Assigned(oClienteControler) then
    FreeAndNil(oClienteControler);

  if Assigned(frmListagemClientes) then
  begin
    frmListagemClientes.Close;
    FreeAndNil(frmListagemClientes);
  end;

  inherited;
end;

procedure TListagemClientesControler.fecharForm(Sender: TObject);
begin
  if (not(Assigned(frmListagemClientes))) then
    exit;

  frmListagemClientes.Close;
  oClienteRegra.Limpar(oClienteDto);
  FreeAndNil(frmListagemClientes);
  oFormReformaParaFrente;
end;

procedure TListagemClientesControler.FormActivate(Sender: TObject);
begin
  frmListagemClientes.edtPesquisa.Text := EmptyStr;
  ListarClientes;
end;

procedure TListagemClientesControler.Inserir(Sender: TObject);
begin
  oClienteControler.AbrirFormModoAdicao;
end;

procedure TListagemClientesControler.ListarClientes;
begin
  oModelCliente.ListarClientes(frmListagemClientes.dsTabela);
end;

procedure TListagemClientesControler.OnChangeEdtpesquisa(Sender: TObject);
begin
  oModelCliente.Localizar(frmListagemClientes.edtPesquisa.Text, sCampo);
end;

procedure TListagemClientesControler.OnDblClickDbGrid(Sender: TObject);
begin
  Selecionar(Self);
end;

procedure TListagemClientesControler.OnKeyDownForm(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F2 then
    frmListagemClientes.edtPesquisa.SetFocus;

  if Key = VK_F5 then
    ListarClientes;
end;

procedure TListagemClientesControler.OnKeyPressGrid(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    Selecionar(TObject(0));
end;

procedure TListagemClientesControler.OnSelectCbPesquisa(Sender: TObject);
begin
  if frmListagemClientes.cbPesquisa.Items
    [frmListagemClientes.cbPesquisa.ItemIndex] = 'Nome do cliente' then
    sCampo := 'Nome'
  else if frmListagemClientes.cbPesquisa.Items
    [frmListagemClientes.cbPesquisa.ItemIndex] = 'CPF/CNPJ' then
    sCampo := 'CPFCNPJ'
  else
    sCampo := frmListagemClientes.cbPesquisa.Items
      [frmListagemClientes.cbPesquisa.ItemIndex];

  if Trim(frmListagemClientes.edtPesquisa.Text) <> EmptyStr then
    OnChangeEdtpesquisa(Sender);
end;

procedure TListagemClientesControler.Selecionar(Sender: TObject);
begin
  oClienteDto.idCliente := frmListagemClientes.DBGrid1.Fields[0].AsInteger;
  if not(oModelCliente.BuscarRegistro(oClienteDto)) then
  begin
    ListarClientes;
    frmListagemClientes.edtPesquisa.Text := EmptyStr;
    ShowMessage('Cliente não encontrado.');
  end
  else
  begin
    oConfirmaCliente(oClienteDto.CpfCnpj);
    fecharForm(TObject(0));
  end;
end;

initialization

finalization

if Assigned(oListagemControler) then
  FreeAndNil(oListagemControler);

end.
