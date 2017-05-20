program Empreiteira;

uses
  Vcl.Forms,
  uCadastroBase in 'uCadastroBase.pas' {frmCadastroBase},
  uClassConexaoBanco in 'uClassConexaoBanco.pas',
  uClassSingletonConexao in 'uClassSingletonConexao.pas',
  uEstadoController in 'uEstadoController.pas',
  uEstadoDto in 'uEstadoDto.pas',
  uEstadoModel in 'uEstadoModel.pas',
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uMunicipioModel in 'uMunicipioModel.pas',
  uMunicipioControler in 'uMunicipioControler.pas',
  uMunicipioDto in 'uMunicipioDto.pas',
  uMunicipioControlerInserirAlterar in 'uMunicipioControlerInserirAlterar.pas',
  uBairros in 'uBairros.pas' {frmBairros},
  uBairrosListagem in 'uBairrosListagem.pas' {frmListagemBairro},
  uBairrosControler in 'uBairrosControler.pas',
  uBairrosControlerInserirAlterar in 'uBairrosControlerInserirAlterar.pas',
  uBairrosModel in 'uBairrosModel.pas',
  uBairrosDto in 'uBairrosDto.pas',
  uEstadoRegra in 'uEstadoRegra.pas',
  uEstado in 'uEstado.pas' {frmEstados},
  uListagemBase in 'uListagemBase.pas' {frmListagemBase},
  uMunicipio in 'uMunicipio.pas' {frmMunicipio},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
