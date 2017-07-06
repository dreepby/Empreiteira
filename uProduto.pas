unit uProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.CheckLst;

type
  TfrmProduto = class(TfrmCadastroBase)
    clbAmbientes: TCheckListBox;
    Label3: TLabel;
    edtDescricao: TLabeledEdit;
    edtPreco: TEdit;
    Label2: TLabel;
    procedure edtDescricaoKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrecoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProduto: TfrmProduto;

implementation

{$R *.dfm}

procedure TfrmProduto.edtDescricaoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtPreco.SetFocus;
end;

procedure TfrmProduto.edtPrecoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    BtnSalvar.Click;

  if not(CharInSet(Key, ['0' .. '9', #8, ',', '-'])) then
    Key := #0;
end;

end.
