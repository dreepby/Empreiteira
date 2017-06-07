unit uUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmUsuario = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    edtCPF: TLabeledEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

end.
