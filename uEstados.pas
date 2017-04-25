unit uEstados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmEstados = class(TfrmCadastroBase)
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEstados: TfrmEstados;

implementation

{$R *.dfm}

procedure TfrmEstados.btnFecharClick(Sender: TObject);
begin
  inherited;
  frmEstados := nil;
end;

procedure TfrmEstados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   FrmEstados := nil;
end;

end.
