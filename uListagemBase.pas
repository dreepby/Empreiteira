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
    procedure btnCadastrarMouseEnter(Sender: TObject);
    procedure btnCadastrarMouseLeave(Sender: TObject);
    procedure btnAlterarMouseEnter(Sender: TObject);
    procedure btnAlterarMouseLeave(Sender: TObject);
    procedure btnExcluirMouseEnter(Sender: TObject);
    procedure btnExcluirMouseLeave(Sender: TObject);
    procedure btnFecharMouseEnter(Sender: TObject);
    procedure btnFecharMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListagemBase: TfrmListagemBase;

implementation

{$R *.dfm}

procedure TfrmListagemBase.btnAlterarMouseEnter(Sender: TObject);
begin
  pnAlterar.Color := $0000B7B7;
end;

procedure TfrmListagemBase.btnAlterarMouseLeave(Sender: TObject);
begin
  pnAlterar.Color := $0000E1E1;
end;

procedure TfrmListagemBase.btnCadastrarMouseEnter(Sender: TObject);
begin
  pnCadastrar.Color := $00797B17;
end;

procedure TfrmListagemBase.btnCadastrarMouseLeave(Sender: TObject);
begin
  pnCadastrar.Color := $00ABAE20;
end;

procedure TfrmListagemBase.btnExcluirMouseEnter(Sender: TObject);
begin
  pnExcluir.Color := $001792EC;
end;

procedure TfrmListagemBase.btnExcluirMouseLeave(Sender: TObject);
begin
  pnExcluir.Color := $004EADF0;
end;

procedure TfrmListagemBase.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmListagemBase.btnFecharMouseEnter(Sender: TObject);
begin
  pnFechar.Color := $002B2FC6;
end;

procedure TfrmListagemBase.btnFecharMouseLeave(Sender: TObject);
begin
  pnFechar.Color := $004F53D9;
end;

procedure TfrmListagemBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
