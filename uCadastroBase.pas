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
    btnPesquisa: TButton;
    Panel2: TPanel;
    PageControl1: TPageControl;
    tsTabela: TTabSheet;
    DBGrid1: TDBGrid;
    tsDados: TTabSheet;
    Panel3: TPanel;
    Panel4: TPanel;
    btnInserir: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnSalvar: TBitBtn;
    BtnCancelar: TBitBtn;
    btnExcluir: TBitBtn;
    BtnFechar: TBitBtn;
    dsTabela: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarMouseEnter(Sender: TObject);
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

procedure TfrmCadastroBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
