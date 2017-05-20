unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uClassSingletonConexao, System.Actions,
  Vcl.ActnList, Vcl.Menus, System.UITypes, uEstadoController,
  Vcl.ExtCtrls, uMunicipioControler;

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
    procedure FormCreate(Sender: TObject);
    procedure actEstadosExecute(Sender: TObject);
    procedure actMunicipioExecute(Sender: TObject);
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
  oControllerEstado.abrirForm;
end;

procedure TfrmPrincipal.actMunicipioExecute(Sender: TObject);
begin
  // oControllerMunicipio.abrirForm;
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

  if not(Assigned(oControllerEstado)) then
    oControllerEstado := TEstadoControler.Create;

end;

end.
