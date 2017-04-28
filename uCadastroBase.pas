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
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    btnCancelar: TSpeedButton;
    btnSalvar: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarMouseEnter(Sender: TObject);
    procedure btnSalvarMouseLeave(Sender: TObject);
    procedure btnCancelarMouseEnter(Sender: TObject);
    procedure btnCancelarMouseLeave(Sender: TObject);
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
begin
  Panel4.Color := $002B2FC6;
end;

procedure TfrmCadastroBase.btnCancelarMouseLeave(Sender: TObject);
begin
  Panel4.Color := $004F53D9;
end;

procedure TfrmCadastroBase.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroBase.btnSalvarMouseEnter(Sender: TObject);
begin
  Panel3.Color := $003E8E3E;
end;

procedure TfrmCadastroBase.btnSalvarMouseLeave(Sender: TObject);
begin
  Panel3.Color := $005CB85C;
end;

procedure TfrmCadastroBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmCadastroBase.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

end.
