unit uBairrosListagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uListagemBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmListagemBairro = class(TfrmListagemBase)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListagemBairro: TfrmListagemBairro;

implementation

{$R *.dfm}

end.
