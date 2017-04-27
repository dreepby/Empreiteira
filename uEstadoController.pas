unit uEstadoController;

interface

uses
  System.SysUtils, Data.DB, uEstadoDto, uEstadoModel;

type
  TEstadoControler = class
  private
    oModelEstado: TEstadoModel;

  public

    function Excluir(var AEstado: TEstadoDto): Boolean;

    function Salvar(var AEstado: TEstadoDto): Boolean;

    procedure Limpar(var AEstado: TEstadoDto);

    function Buscar(var AEstado: TEstadoDto): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoControler }

function TEstadoControler.Excluir(var AEstado: TEstadoDto): Boolean;
begin
  if AEstado.IDuf > 0 then
    Result := oModelEstado.Deletar(AEstado.IDuf);
end;

function TEstadoControler.Buscar(var AEstado: TEstadoDto): Boolean;
begin
if (trim(AEstado.UF) <> EmptyStr) then
    Result := oModelEstado.Ler(AEstado);
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

function TEstadoControler.Salvar(var AEstado: TEstadoDto): Boolean;
begin
  Result := False;

  if AEstado.IDuf > 0 then
    Result := oModelEstado.Alterar(AEstado)
  else
  begin
    AEstado.IDuf := oModelEstado.BuscarID;

    Result := oModelEstado.Inserir(AEstado);
  end;
end;

end.
