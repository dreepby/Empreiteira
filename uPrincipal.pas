unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uClassSingletonConexao, System.Actions, uEstados,
  Vcl.ActnList, Vcl.Menus;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Sobre1: TMenuItem;
    ActionList1: TActionList;
    actEstados: TAction;
    Estados1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure actEstadosExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.actEstadosExecute(Sender: TObject);
begin
  //Verifica se a vari�vel do formul�rio foi instanciada
  if (not(Assigned(frmEstados))) then
    frmEstados := TfrmEstados.Create(Self);
  //Manda mostrar o formul�rio
  frmEstados.Show;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

   ReportMemoryLeaksOnShutdown := True;
   // Quando True verifica se ocorreu vazamento de mem�ria ao fechar o programa
  ReportMemoryLeaksOnShutdown := True;

  // Cria a conex�o com o banco de dados
  try
    TSingletonConexao.GetInstancia;
  except
    ShowMessage('Erro ao conectar com o banco de dados.');
    // Manda encerrar a aplica��o
    Application.Terminate;
    exit;
  end;

end;

end.
