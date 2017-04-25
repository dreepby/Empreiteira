program Empreiteira;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uClassSingletonConexao in 'uClassSingletonConexao.pas',
  uClassConexaoBanco in 'uClassConexaoBanco.pas',
  uCadastroBase in 'uCadastroBase.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
