unit uUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TfrmUsuario = class(TfrmCadastroBase)
    cbPesquisa: TComboBox;
    edtCPF: TMaskEdit;
    Label2: TLabel;
    edtNome: TLabeledEdit;
    procedure edtCPFKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TfrmUsuario.edtCPFKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtNome.SetFocus;
end;

procedure TfrmUsuario.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    BtnSalvar.Click;
end;

end.
