unit uListagemBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, System.ImageList, Vcl.ImgList;

type
  TfrmListagemBase = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    DBGrid1: TDBGrid;
    pnCadastrar: TPanel;
    SpeedButton1: TSpeedButton;
    btnCadastrar: TSpeedButton;
    pnAlterar: TPanel;
    SpeedButton2: TSpeedButton;
    pnExcluir: TPanel;
    SpeedButton3: TSpeedButton;
    pnFechar: TPanel;
    SpeedButton4: TSpeedButton;
    btnAlterar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnFechar: TSpeedButton;
    dsTabela: TDataSource;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListagemBase: TfrmListagemBase;

implementation

{$R *.dfm}

procedure TfrmListagemBase.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmListagemBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmListagemBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) then
  begin
    case Key of
      87:
        Close; // Código desejado
    end;
  end;
end;

end.
