unit uCadastroBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmCadastroBase = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edtPesquisa: TEdit;
    Panel2: TPanel;
    PageControl1: TPageControl;
    tsTabela: TTabSheet;
    DBGrid1: TDBGrid;
    tsDados: TTabSheet;
    Panel3: TPanel;
    Panel4: TPanel;
    dsTabela: TDataSource;
    btnInserir: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    BtnFechar: TBitBtn;
    procedure btnCancelarMouseEnter(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroBase: TfrmCadastroBase;

implementation

{$R *.dfm}

procedure TfrmCadastroBase.btnCancelarMouseEnter(Sender: TObject);
begin;
end;

procedure TfrmCadastroBase.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange := False;
end;

end.
