unit uClienteControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uClienteDto,
  uCliente, uClienteDto, uClienteModel, uClienteRegra, uEstadoDto, uMunicipioDto, uBairroDto,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows, uInterfaceControler;

type
  TClienteControler = class(TInterfacedObject, IControlerInterface)
  private
    frmCliente: TfrmCliente;
    oClienteModel: TClienteModel;
    oClienteDto: TClienteDto;
    oClienteRegra: TClienteRegra;
    oListaEstados: TObjectDictionary<string, TEstadoDto>;
    oListaMunicipios: TObjectDictionary<string, TMunicipioDto>;
    oListaBairros: TObjectDictionary<string, TBairroDto>;

    procedure Excluir(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure Alterar(Sender: TObject);
    procedure Pesquisar(Sender: TObject);
    procedure fecharCliente(Sender: TObject);
    procedure OnKeyPressEdtPesquisa(Sender: TObject; var Key: Char);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    procedure abrirForm;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TClienteControler }

procedure TClienteControler.abrirForm;
begin
  if (not(Assigned(frmCliente))) then
    frmCliente := TfrmCliente.Create(nil);

  frmCliente.tsDados.Enabled := False;
  frmCliente.BtnSalvar.Enabled := False;
  frmCliente.BtnCancelar.Enabled := False;
  frmCliente.BtnFechar.OnClick := fecharCliente;
  frmCliente.BtnSalvar.OnClick := Salvar;
  frmCliente.btnInserir.OnClick := Inserir;
  frmCliente.BtnAlterar.OnClick := Alterar;
  frmCliente.BtnCancelar.OnClick := Cancelar;
  frmCliente.btnExcluir.OnClick := Excluir;
  ListarClientes;
  frmCliente.btnPesquisa.OnClick := Pesquisar;
  frmCliente.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmCliente.OnKeyDown := OnKeyDownForm;
  frmCliente.cbEstado.OnSelect := OnSelectCbEstado;
  frmCliente.Show;
end;

procedure TClienteControler.Alterar(Sender: TObject);
begin

end;

procedure TClienteControler.Cancelar(Sender: TObject);
begin

end;

constructor TClienteControler.Create;
begin
  oListaEstados := TObjectDictionary<string, TEstadoDto>.Create([doOwnsValues]);
  oListaMunicipios := TObjectDictionary<string, TMunicipioDto>.Create([doOwnsValues]);
  oListaBairros := TObjectDictionary<string, TBairroDto>.Create([doOwnsValues]);
end;

destructor TClienteControler.Destroy;
begin
  if Assigned(frmCliente) then
    FreeAndNil(frmCliente);

  if Assigned(oListaMunicipios) then
  begin
    oListaMunicipios.Clear;
    FreeAndNil(oListaMunicipios);
  end;

  if Assigned(oListaEstados) then
  begin
    oListaEstados.Clear;
    FreeAndNil(oListaEstados);
  end;

  if Assigned(oListaBairros) then
  begin
    oListaBairros.Clear;
    FreeAndNil(oListaBairros);
  end;

  inherited;
end;

procedure TClienteControler.Excluir(Sender: TObject);
begin

end;

procedure TClienteControler.fecharCliente(Sender: TObject);
begin
   if (not(Assigned(frmCliente))) then
    exit;

  oClienteRegra.Limpar(oClienteDto);
  frmCliente.Close;
  FreeAndNil(frmCliente);
end;

procedure TClienteControler.Inserir(Sender: TObject);
begin

end;

procedure TClienteControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TClienteControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin

end;

procedure TClienteControler.Pesquisar(Sender: TObject);
begin

end;

procedure TClienteControler.Salvar(Sender: TObject);
begin

end;

end.
