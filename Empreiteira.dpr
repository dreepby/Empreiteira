program Empreiteira;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uClassSingletonConexao in 'uClassSingletonConexao.pas',
  uClassConexaoBanco in 'uClassConexaoBanco.pas',
  uCadastroBase in 'uCadastroBase.pas' {frmCadastroBase},
  uEstados in 'uEstados.pas' {frmEstados},
  uEstadoController in 'uEstadoController.pas',
  uEstadoModel in 'uEstadoModel.pas',
  uEstadoDto in 'uEstadoDto.pas',
  uListaEstado in 'uListaEstado.pas',
  uListagemBase in 'uListagemBase.pas' {frmListagemBase};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmListagemBase, frmListagemBase);
  Application.Run;
end.
