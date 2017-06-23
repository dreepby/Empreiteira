unit uDetalhesCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmDetalhesCliente = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    ScrollBox1: TScrollBox;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    edtCpf: TEdit;
    edtCnpj: TEdit;
    edtTelefone: TEdit;
    edtCelular: TEdit;
    edtRua: TEdit;
    edtNumero: TEdit;
    edtCep: TEdit;
    edtComplemento: TEdit;
    moObservacao: TMemo;
    BtnFechar: TBitBtn;
    BtnSalvar: TBitBtn;
    cbEstado: TComboBox;
    cbMunicipio: TComboBox;
    cbBairro: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
