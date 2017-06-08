unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCliente = class(TfrmCadastroBase)
    Label5: TLabel;
    cbPesquisa: TComboBox;
    edtNome: TLabeledEdit;
    edtCnpj: TLabeledEdit;
    edtCpf: TLabeledEdit;
    edtCelular: TLabeledEdit;
    edtTelefone: TLabeledEdit;
    cbEstado: TComboBox;
    Label2: TLabel;
    cbMunicipio: TComboBox;
    Label3: TLabel;
    cbBairro: TComboBox;
    Label4: TLabel;
    edtRua: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtCep: TLabeledEdit;
    moObservacao: TMemo;
    Label6: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
