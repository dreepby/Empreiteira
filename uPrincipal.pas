unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uClassSingletonConexao, System.Actions,
  Vcl.ActnList, Vcl.Menus, System.UITypes, uEstadoController,
  Vcl.ExtCtrls, uMunicipioControler, uBairroControler;

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
    procedure FormCreate(Sender: TObject);
    procedure actEstadosExecute(Sender: TObject);
    procedure actMunicipioExecute(Sender: TObject);
    procedure actBairroExecute(Sender: TObject);
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

procedure TfrmPrincipal.actBairroExecute(Sender: TObject);
begin
  if not(Assigned(oBairroControler)) then
    oBairroControler := TBairroControler.Create;
  oBairroControler.abrirForm;
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
