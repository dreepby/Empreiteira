unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TfrmCliente = class(TfrmCadastroBase)
    cbPesquisa: TComboBox;
    edtCpfCnpj: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtRua: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    edtCep: TMaskEdit;
    Label7: TLabel;
    cbEstado: TComboBox;
    Label2: TLabel;
    cbMunicipio: TComboBox;
    Label3: TLabel;
    cbBairro: TComboBox;
    Label4: TLabel;
    edtTelefone: TLabeledEdit;
    edtCelular: TLabeledEdit;
    moObservacao: TMemo;
    Label6: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    Perform(WM_NEXTDLGCTL, 0, 0);

end;

end.
