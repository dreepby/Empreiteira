unit uBairro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmBairro = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    cbMunicipio: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    cbEstado: TComboBox;
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure cbMunicipioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmBairro.cbMunicipioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   if Key = #13 then
    BtnSalvar.Click;
end;

procedure TfrmBairro.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    cbMunicipio.SetFocus;
end;

end.
