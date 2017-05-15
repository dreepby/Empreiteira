unit uBairros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, uBairrosDto, uBairrosControlerInserirAlterar;

type
  TfrmBairros = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    Label1: TLabel;
    cbMunicipio: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBairros: TfrmBairros;

implementation

{$R *.dfm}

end.
