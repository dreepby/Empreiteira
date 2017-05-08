unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uClassSingletonConexao, System.Actions,
  uEstados,
  Vcl.ActnList, Vcl.Menus, uEstadosListagem, System.UITypes, uEstadoController,
  Vcl.ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Sobre1: TMenuItem;
    ActionList1: TActionList;
    actEstados: TAction;
    Estados1: TMenuItem;
    Listagem1: TMenuItem;
    actListagemEstado: TAction;
    Estados2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure actEstadosExecute(Sender: TObject);
    procedure actListagemEstadoExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    oControllerEstado: TEstadoControler;

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

procedure TfrmPrincipal.actEstadosExecute(Sender: TObject);
begin
  oControllerEstado.abrirEstado();
end;

procedure TfrmPrincipal.actListagemEstadoExecute(Sender: TObject);
begin
  // Verifica se a variável do formulário foi instanciada
  if (not(Assigned(frmListagemEstados))) then
    frmListagemEstados := TfrmListagemEstados.Create(Self);
  // Manda mostrar o formulário
  frmListagemEstados.Show;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if Assigned(oControllerEstado) then
    FreeAndNil(oControllerEstado);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);

begin

  ReportMemoryLeaksOnShutdown := True;
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
