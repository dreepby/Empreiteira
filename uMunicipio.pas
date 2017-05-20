unit uMunicipio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMunicipio = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    Label2: TLabel;
    cbEstado: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMunicipio: TfrmMunicipio;

implementation

{$R *.dfm}

end.
