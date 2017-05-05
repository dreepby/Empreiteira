unit uEstadoControlerInserirAlterar;

interface

uses
  System.SysUtils, Data.DB, uEstadoDto, uEstadoModel;

type
  TEstadoControlerInserirAlterar = class
  private
    oModelEstado: TEstadoModel;

  public


    function Salvar(var AEstado: TEstadoDto): Boolean;

    procedure Limpar(var AEstado: TEstadoDto);

    function Buscar(var AEstado: TEstadoDto): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoControler }



function TEstadoControlerInserirAlterar.Buscar(var AEstado: TEstadoDto): Boolean;
begin
  if (trim(AEstado.UF) <> EmptyStr) then
    Result := oModelEstado.Ler(AEstado)
  else
    Result := False;
end;

constructor TEstadoControlerInserirAlterar.Create;
begin
  oModelEstado := TEstadoModel.Create;
end;

destructor TEstadoControlerInserirAlterar.Destroy;
begin
  if Assigned(oModelEstado) then
    FreeAndNil(oModelEstado);

  inherited;
end;

procedure TEstadoControlerInserirAlterar.Limpar(var AEstado: TEstadoDto);
begin
  AEstado.IDuf := 0;
  AEstado.UF := EmptyStr;
  AEstado.Nome := EmptyStr;
end;

function TEstadoControlerInserirAlterar.Salvar(var AEstado: TEstadoDto): Boolean;
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
