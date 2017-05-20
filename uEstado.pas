unit uEstado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TfrmEstados = class(TfrmCadastroBase)
    edtUF: TLabeledEdit;
    edtNome: TLabeledEdit;
    procedure edtUFKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmEstados.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnSalvar.Click;
end;

procedure TfrmEstados.edtUFKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtNome.SetFocus;
end;

end.
