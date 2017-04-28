unit uEstadosListagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uListagemBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uEstados,
  uEstadoController;

type
  TfrmListagemEstados = class(TfrmListagemBase)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnFecharMouseLeave(Sender: TObject);
    procedure btnFecharMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    oController: TEstadoControler;
  public
    { Public declarations }
  end;

var
  frmListagemEstados: TfrmListagemEstados;

implementation

{$R *.dfm}

procedure TfrmListagemEstados.btnCadastrarClick(Sender: TObject);
begin
  inherited;
  // Verifica se a variável do formulário foi instanciada
  if (not(Assigned(frmEstados))) then
    frmEstados := TfrmEstados.Create(Self);
  // Manda mostrar o formulário
  frmEstados.Show;
end;

procedure TfrmListagemEstados.btnFecharClick(Sender: TObject);
begin
  inherited;
  frmListagemEstados := nil;
end;

procedure TfrmListagemEstados.btnFecharMouseLeave(Sender: TObject);
begin
  inherited;
  pnFechar.Color := $002B2FC6;
end;

procedure TfrmListagemEstados.btnFecharMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnFechar.Color := $004F53D9;
end;

procedure TfrmListagemEstados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if Assigned(oController) then
    FreeAndNil(oController);

  frmListagemEstados := nil;
end;

procedure TfrmListagemEstados.FormCreate(Sender: TObject);
begin
  inherited;
  oController := TEstadoControler.Create;
  oController.ListarEstados(dsTabela);
end;

end.
