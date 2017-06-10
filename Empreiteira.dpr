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
  uBairroControler in 'uBairroControler.pas',
  uBairroModel in 'uBairroModel.pas',
  uBairroDto in 'uBairroDto.pas',
  uEstadoRegra in 'uEstadoRegra.pas',
  uEstado in 'uEstado.pas' {frmEstados},
  uMunicipio in 'uMunicipio.pas' {frmMunicipio},
  Vcl.Themes,
  Vcl.Styles,
  uMunicipioRegra in 'uMunicipioRegra.pas',
  uBairro in 'uBairro.pas' {frmBairro},
  uBairroRegra in 'uBairroRegra.pas',
  uInterfaceControler in 'uInterfaceControler.pas',
  uEstadoInterfaceModel in 'uEstadoInterfaceModel.pas',
  uMunicipioInterfaceModel in 'uMunicipioInterfaceModel.pas',
  uBairroInterfaceModel in 'uBairroInterfaceModel.pas',
  uCliente in 'uCliente.pas' {frmCliente},
  uClienteControler in 'uClienteControler.pas',
  uClienteDto in 'uClienteDto.pas',
  uClienteModel in 'uClienteModel.pas',
  uClienteInterfaceModel in 'uClienteInterfaceModel.pas',
  uClienteRegra in 'uClienteRegra.pas',
  uAmbiente in 'uAmbiente.pas' {frmAmbiente},
  uAmbienteControler in 'uAmbienteControler.pas',
  uAmbienteModel in 'uAmbienteModel.pas',
  uAmbienteRegra in 'uAmbienteRegra.pas',
  uAmbienteDto in 'uAmbienteDto.pas',
  uAmbienteInterfaceModel in 'uAmbienteInterfaceModel.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
