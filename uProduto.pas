unit uProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.CheckLst;

type
  TfrmProduto = class(TfrmCadastroBase)
    edtDescricao: TLabeledEdit;
    CheckListBox1: TCheckListBox;
    Label2: TLabel;
    CheckListBox2: TCheckListBox;
    edtPreco: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProduto: TfrmProduto;

implementation

{$R *.dfm}

end.
