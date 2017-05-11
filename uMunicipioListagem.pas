unit uMunicipioListagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uListagemBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, uMunicipioControler;

type
  TfrmListagemMunicipios = class(TfrmListagemBase)
    edtPesquisa: TEdit;
    btnPesquisa: TButton;
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListagemMunicipios: TfrmListagemMunicipios;

implementation

{$R *.dfm}

procedure TfrmListagemMunicipios.btnFecharClick(Sender: TObject);
begin
  inherited;
  frmListagemMunicipios := nil;
end;

end.
