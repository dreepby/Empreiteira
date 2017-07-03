unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmCliente = class(TfrmCadastroBase)
    Label5: TLabel;
    cbPesquisa: TComboBox;
    edtCpfCnpj: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtRua: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    edtCep: TLabeledEdit;
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
    procedure edtCpfCnpjKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure edtRuaKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumeroKeyPress(Sender: TObject; var Key: Char);
    procedure edtComplementoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCepKeyPress(Sender: TObject; var Key: Char);
    procedure cbEstadoKeyPress(Sender: TObject; var Key: Char);
    procedure cbMunicipioKeyPress(Sender: TObject; var Key: Char);
    procedure cbBairroKeyPress(Sender: TObject; var Key: Char);
    procedure edtTelefoneKeyPress(Sender: TObject; var Key: Char);
    procedure edtCelularKeyPress(Sender: TObject; var Key: Char);
    procedure moObservacaoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmCliente.cbBairroKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtTelefone.SetFocus;
end;

procedure TfrmCliente.cbEstadoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if cbMunicipio.Enabled then
  begin
    if Key = #13 then
      cbMunicipio.SetFocus;
  end;
end;

procedure TfrmCliente.cbMunicipioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if cbBairro.Enabled then
  begin
    if Key = #13 then
      cbBairro.SetFocus;
  end;
end;

procedure TfrmCliente.edtCelularKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    moObservacao.SetFocus;
end;

procedure TfrmCliente.edtCepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    cbEstado.SetFocus;
end;

procedure TfrmCliente.edtComplementoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtCep.SetFocus;
end;

procedure TfrmCliente.edtCpfCnpjKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtNome.SetFocus;
end;

procedure TfrmCliente.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtRua.SetFocus;
end;

procedure TfrmCliente.edtNumeroKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtComplemento.SetFocus;
end;

procedure TfrmCliente.edtRuaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtNumero.SetFocus;
end;

procedure TfrmCliente.edtTelefoneKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtCelular.SetFocus;
end;

procedure TfrmCliente.moObservacaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    BtnSalvar.Click;
end;

end.
