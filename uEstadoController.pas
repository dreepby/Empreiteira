unit uEstadoController;

interface

uses
  System.SysUtils, Data.DB, uEstadoDto, uEstadoModel, uEstados;

type
  TEstadoControler = class
  private
    oModelEstado: TEstadoModel;

  public

    function Excluir(var AEstado: TEstadoDto): Boolean;

    function Salvar(var AEstado: TEstadoDto): Boolean;

    procedure Limpar(var AEstado: TEstadoDto);

    function Buscar(var AEstado: TEstadoDto): Boolean;

    procedure ListarEstados(var DsEstado: TDataSource);

    procedure abrirEstadoUpdate(AEstado: TEstadoDto);

    procedure abrirEstado();
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoControler }

function TEstadoControler.Excluir(var AEstado: TEstadoDto): Boolean;
begin
  if AEstado.IDuf > 0 then
    Result := oModelEstado.Deletar(AEstado.IDuf)
  else
    Result := False;
end;

procedure TEstadoControler.abrirEstado();
begin
  if (not(Assigned(frmEstados))) then
    frmEstados := TfrmEstados.Create(nil);
  // Manda mostrar o formulário
  frmEstados.Show;
end;

procedure TEstadoControler.abrirEstadoUpdate(AEstado: TEstadoDto);
begin
  if (not(Assigned(frmEstados))) then
    frmEstados := TfrmEstados.Create(nil);
  // Manda mostrar o formulário
  frmEstados.Caption := 'Alteração de Estado';
  frmEstados.Panel3.Caption := 'Alterar';
  frmEstados.Show;
end;

function TEstadoControler.Buscar(var AEstado: TEstadoDto): Boolean;
begin
  if (trim(AEstado.UF) <> EmptyStr) then
    Result := oModelEstado.Ler(AEstado)
  else
    Result := False;
end;

constructor TEstadoControler.Create;
begin
  oModelEstado := TEstadoModel.Create;
end;

destructor TEstadoControler.Destroy;
begin
  if Assigned(oModelEstado) then
    FreeAndNil(oModelEstado);

  inherited;
end;

procedure TEstadoControler.Limpar(var AEstado: TEstadoDto);
begin
  AEstado.IDuf := 0;
  AEstado.UF := EmptyStr;
  AEstado.Nome := EmptyStr;
end;

procedure TEstadoControler.ListarEstados(var DsEstado: TDataSource);
begin
  oModelEstado.ListarEstados(DsEstado);
end;

function TEstadoControler.Salvar(var AEstado: TEstadoDto): Boolean;
begin

  if AEstado.IDuf > 0 then
    Result := oModelEstado.Alterar(AEstado)
  else
  begin
    AEstado.IDuf := oModelEstado.BuscarID;

    Result := oModelEstado.Inserir(AEstado);
  end;
end;

end.
