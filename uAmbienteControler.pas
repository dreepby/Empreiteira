unit uAmbienteControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uAmbienteDto,
  uAmbienteModel, uAmbiente, uAmbienteRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows, uEstadoDto,
  uInterfaceControler, uAmbienteInterfaceModel;

type
  TAmbienteControler = class(TInterfacedObject, IControlerInterface)

  private
    oAmbienteModel: IModelAmbienteInterface;
    oAmbienteDto: TAmbienteDto;
    oBairroRegra: TAmbienteRegra;
    oListaBairros: TObjectDictionary<string, TAmbienteDto>;
    frmAmbiente: TfrmAmbiente;

    procedure Excluir(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure ListarAmbientes;
    procedure Alterar(Sender: TObject);
    procedure fecharAmbiente(Sender: TObject);
    procedure Pesquisar(Sender: TObject);
    procedure OnKeyPressEdtPesquisa(Sender: TObject; var Key: Char);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    procedure abrirForm;

    constructor Create;
    destructor Destroy; override;
  end;

var
  oAmbienteControler: TAmbienteControler;

implementation

{ TAmbienteControler }

procedure TAmbienteControler.abrirForm;
begin
  if (not(Assigned(frmAmbiente))) then
    frmAmbiente := TfrmAmbiente.Create(nil);

  frmAmbiente.tsDados.Enabled := False;
  frmAmbiente.BtnSalvar.Enabled := False;
  frmAmbiente.BtnCancelar.Enabled := False;
  frmAmbiente.BtnFechar.OnClick := fecharAmbiente;
  frmAmbiente.BtnSalvar.OnClick := Salvar;
  frmAmbiente.btnInserir.OnClick := Inserir;
  frmAmbiente.BtnAlterar.OnClick := Alterar;
  frmAmbiente.BtnCancelar.OnClick := Cancelar;
  frmAmbiente.btnExcluir.OnClick := Excluir;
  ListarAmbientes;
  frmAmbiente.btnPesquisa.OnClick := Pesquisar;
  frmAmbiente.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmAmbiente.OnKeyDown := OnKeyDownForm;
  frmAmbiente.Show;
end;

procedure TAmbienteControler.Alterar(Sender: TObject);
begin

end;

procedure TAmbienteControler.Cancelar(Sender: TObject);
begin

end;

constructor TAmbienteControler.Create;
begin

end;

destructor TAmbienteControler.Destroy;
begin

  inherited;
end;

procedure TAmbienteControler.Excluir(Sender: TObject);
begin

end;

procedure TAmbienteControler.fecharAmbiente(Sender: TObject);
begin

end;

procedure TAmbienteControler.Inserir(Sender: TObject);
begin

end;

procedure TAmbienteControler.ListarAmbientes;
begin

end;

procedure TAmbienteControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TAmbienteControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin

end;

procedure TAmbienteControler.Pesquisar(Sender: TObject);
begin

end;

procedure TAmbienteControler.Salvar(Sender: TObject);
begin

end;

initialization

finalization

if Assigned(oAmbienteControler) then
  FreeAndNil(oAmbienteControler);

end.
