program Empreiteira;

uses
  Vcl.Forms,
  uCadastroBase in 'uCadastroBase.pas' {frmCadastroBase},
  uClassConexaoBanco in 'uClassConexaoBanco.pas',
  uClassSingletonConexao in 'uClassSingletonConexao.pas',
  uEstadoController in 'uEstadoController.pas',
  uEstadoDto in 'uEstadoDto.pas',
  uEstadoModel in 'uEstadoModel.pas',
  uEstados in 'uEstados.pas' {frmEstados},
  uListagemBase in 'uListagemBase.pas' {frmListagemBase},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uEstadosListagem in 'uEstadosListagem.pas' {frmListagemEstados},
  uEstadoControlerInserirAlterar in 'uEstadoControlerInserirAlterar.pas',
  uMunicipioListagem in 'uMunicipioListagem.pas' {frmListagemMunicipios},
  uMunicipio in 'uMunicipio.pas' {frmMunicipio},
  uMunicipioModel in 'uMunicipioModel.pas',
  uMunicipioControler in 'uMunicipioControler.pas',
  uMunicipioDto in 'uMunicipioDto.pas',
  uMunicipioControlerInserirAlterar in 'uMunicipioControlerInserirAlterar.pas',
  uBairros in 'uBairros.pas' {frmBairros},
  uBairrosListagem in 'uBairrosListagem.pas' {frmListagemBairro},
  uBairrosControler in 'uBairrosControler.pas',
  uBairrosControlerInserirAlterar in 'uBairrosControlerInserirAlterar.pas',
  uBairrosModel in 'uBairrosModel.pas',
  uBairrosDto in 'uBairrosDto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmBairros, frmBairros);
  Application.CreateForm(TfrmListagemBairro, frmListagemBairro);
  Application.Run;
end.
