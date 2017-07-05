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
    edtDescricao: TLabeledEdit;
    CheckListBox1: TCheckListBox;
    Label2: TLabel;
    clbAmbientes: TCheckListBox;
    edtPreco: TEdit;
    Label3: TLabel;
    procedure edtDescricaoKeyPress(Sender: TObject; var Key: Char);
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

end.
