unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uClassSingletonConexao, System.Actions,
  Vcl.ActnList, Vcl.Menus, System.UITypes, uEstadoController,
  Vcl.ExtCtrls, uMunicipioControler, uBairroControler, uUsuarioControler,
  uClienteControler, uAmbienteControler, uReformaControler, uProdutoControler, uRelatorioControler,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Sobre1: TMenuItem;
    ActionList1: TActionList;
    actEstados: TAction;
    Estados1: TMenuItem;
    actMunicipio: TAction;
    Municipios1: TMenuItem;
    actBairro: TAction;
    Bairros1: TMenuItem;
    actUsuario: TAction;
    actCliente: TAction;
    actAmbiente: TAction;
    Usuarios1: TMenuItem;
    Clientes1: TMenuItem;
    Ambientes1: TMenuItem;
    actProduto: TAction;
    Produtos1: TMenuItem;
    actReforma: TAction;
    Reformas1: TMenuItem;
    actRelatorio: TAction;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Image1: TImage;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure actEstadosExecute(Sender: TObject);
    procedure actMunicipioExecute(Sender: TObject);
    procedure actBairroExecute(Sender: TObject);
    procedure actUsuarioExecute(Sender: TObject);
    procedure actClienteExecute(Sender: TObject);
    procedure actAmbienteExecute(Sender: TObject);
    procedure actReformaExecute(Sender: TObject);
    procedure actProdutoExecute(Sender: TObject);
    procedure actRelatorioExecute(Sender: TObject);
  private
    { Private declarations }
    procedure WMClose(var Message: TWMClose); message WM_Close;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.WMClose(var Message: TWMClose);
begin
  if MessageDlg('Deseja realmente sair do programa?', mtinformation,
    [mbyes, mbno], 0) = mryes then
    Application.Terminate;
end;

procedure TfrmPrincipal.actAmbienteExecute(Sender: TObject);
begin
  if not(Assigned(oAmbienteControler)) then
    oAmbienteControler := TAmbienteControler.Create;
  oAmbienteControler.abrirForm;
end;

procedure TfrmPrincipal.actBairroExecute(Sender: TObject);
begin
  if not(Assigned(oBairroControler)) then
    oBairroControler := TBairroControler.Create;
  oBairroControler.abrirForm;
end;

procedure TfrmPrincipal.actClienteExecute(Sender: TObject);
begin
  if not(Assigned(oClienteControler)) then
    oClienteControler := TClienteControler.Create;
  oClienteControler.abrirForm;
end;

procedure TfrmPrincipal.actEstadosExecute(Sender: TObject);
begin
  if not(Assigned(oEstadoControler)) then
    oEstadoControler := TEstadoControler.Create;
  oEstadoControler.abrirForm;
end;

procedure TfrmPrincipal.actMunicipioExecute(Sender: TObject);
begin
  if not(Assigned(oMunicipioControler)) then
    oMunicipioControler := TMunicipioControler.Create;
  oMunicipioControler.abrirForm;
end;

procedure TfrmPrincipal.actReformaExecute(Sender: TObject);
begin
  if not(Assigned(oReformaControler)) then
    oReformaControler := TReformaControler.Create;
  oReformaControler.abrirForm;
end;

procedure TfrmPrincipal.actRelatorioExecute(Sender: TObject);
begin
    if not(Assigned(oRelatorioControler)) then
    oRelatorioControler := TRelatorioControler.Create;
  oRelatorioControler.abrirForm;
end;

procedure TfrmPrincipal.actProdutoExecute(Sender: TObject);
begin
  if not(Assigned(oProdutoControler)) then
    oProdutoControler := TProdutoControler.Create;
  oProdutoControler.abrirForm;
end;

procedure TfrmPrincipal.actUsuarioExecute(Sender: TObject);
begin
  if not(Assigned(oUsuarioControler)) then
    oUsuarioControler := TUsuarioControler.Create;
  oUsuarioControler.abrirForm;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);

begin
  ReportMemoryLeaksOnShutdown := False;
  // Quando True verifica se ocorreu vazamento de memória ao fechar o programa
  // Cria a conexão com o banco de dados
  try
    TSingletonConexao.GetInstancia;
  except
    ShowMessage('Erro ao conectar com o banco de dados.');
    // Manda encerrar a aplicação
    Application.Terminate;
    exit;
  end;
end;

end.
