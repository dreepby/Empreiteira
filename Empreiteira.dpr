program Empreiteira;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uClassSingletonConexao in 'uClassSingletonConexao.pas',
  uClassConexaoBanco in 'uClassConexaoBanco.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
