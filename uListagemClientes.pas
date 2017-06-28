unit uListagemClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  TfrmListagemClientes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtPesquisa: TEdit;
    cbPesquisa: TComboBox;
    DBGrid1: TDBGrid;
    btnInserir: TBitBtn;
    BtnAlterar: TBitBtn;
    BtnFechar: TBitBtn;
    btnSelecionar: TBitBtn;
    dsTabela: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmListagemClientes.FormCreate(Sender: TObject);
begin
  if (Owner is TForm) then
    (Owner as TForm).Enabled := False;
end;

procedure TfrmListagemClientes.FormDestroy(Sender: TObject);
begin
  if (Owner is TForm) then
    (Owner as TForm).Enabled := True;
end;

end.
