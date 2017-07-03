// Banco de dados
unit uEstadoModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, System.Generics.Collections,
  uEstadoDto, uClassSingletonConexao, uEstadoInterfaceModel;

type
  TEstadoModel = class(TInterfacedObject, IModelEstadoInterface)
  private
    oQueryListarEstados: TFDQuery;
  public
    function Inserir(var AEstado: TEstadoDto): Boolean;
    function Alterar(var AEstado: TEstadoDto): Boolean;
    function VerificarExcluir(AId: integer): Boolean;
    function Deletar(const AIDUF: integer): Boolean;
    function ADDListaHash(var oEstado: TObjectDictionary<string,
      TEstadoDto>): Boolean;
    function BuscarID: integer;
    function Ler(var AEstado: TEstadoDto): Boolean;
    procedure ListarEstados(var DsEstado: TDataSource);
    function VerificarUF(AUF: TEstadoDto; out AId: integer): Boolean;
    function Buscar(ANome: String): integer;
    function Localizar(ATexto: String): Boolean;
    function IsEmpty: Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TEstadoModel }

function TEstadoModel.ADDListaHash(var oEstado
  : TObjectDictionary<string, TEstadoDto>): Boolean;
var
  oEstadoDTO: TEstadoDto;
  oQuery: TFDQuery;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select * from uf');

    if (not(oQuery.IsEmpty)) then
    begin
      oQuery.First;
      while (not(oQuery.Eof)) do
      begin
        // Instancia do objeto
        oEstadoDTO := TEstadoDto.Create;

        // Atribui os valores
        oEstadoDTO.IdUF := oQuery.FieldByName('idUf').AsInteger;
        oEstadoDTO.UF := oQuery.FieldByName('UF').AsString;
        oEstadoDTO.Nome := oQuery.FieldByName('nome').AsString;

        // Adiciona o objeto na lista hash
        oEstado.Add(oEstadoDTO.Nome, oEstadoDTO);

        // Vai para o próximo registro
        oQuery.Next;
      end;
      Result := True;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;

end;

function TEstadoModel.Alterar(var AEstado: TEstadoDto): Boolean;
var
  sSql: String;
begin
  sSql := 'update UF' + '   set UF = ' + QuotedStr(AEstado.UF) +
    '     , Nome = ' + QuotedStr(AEstado.Nome) + ' where idUF = ' +
    IntToStr(AEstado.IdUF);

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

function TEstadoModel.Buscar(ANome: String): integer;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select IdUF from UF where nome = ' + QuotedStr(ANome));
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('IdUF').AsInteger
    else
      Result := 0;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TEstadoModel.BuscarID: integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(IdUF) as ID' + '  from UF');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

constructor TEstadoModel.Create;
begin
  oQueryListarEstados := TFDQuery.Create(nil);
end;

function TEstadoModel.Deletar(const AIDUF: integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from uf where iduf = ' + IntToStr(AIDUF)) > 0;
end;

destructor TEstadoModel.Destroy;
begin
  oQueryListarEstados.Close;

  if Assigned(oQueryListarEstados) then
    FreeAndNil(oQueryListarEstados);
  inherited;
end;

function TEstadoModel.Inserir(var AEstado: TEstadoDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into uf (idUF, Nome, UF) values (' + IntToStr(AEstado.IdUF) +
    ', ' + QuotedStr(AEstado.Nome) + ', ' + QuotedStr(AEstado.UF) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

function TEstadoModel.IsEmpty: Boolean;
begin
  Result := oQueryListarEstados.IsEmpty;
end;

function TEstadoModel.Ler(var AEstado: TEstadoDto): Boolean;
var
  oQuery: TFDQuery;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select iduf, Nome, uf  from uf where UF = ' +
      QuotedStr(AEstado.UF));
    if (not(oQuery.IsEmpty)) then
    begin
      AEstado.IdUF := oQuery.FieldByName('iduf').AsInteger;
      AEstado.Nome := oQuery.FieldByName('Nome').AsString;
      Result := True;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

procedure TEstadoModel.ListarEstados(var DsEstado: TDataSource);
begin
  oQueryListarEstados.Connection := TSingletonConexao.GetInstancia;
  oQueryListarEstados.Filtered := False;
  oQueryListarEstados.Open('select iduf, Nome, uf  from uf');
  DsEstado.DataSet := oQueryListarEstados;
end;

function TEstadoModel.Localizar(ATexto: String): Boolean;
begin
  oQueryListarEstados.Filter := 'UPPER(Nome) LIKE ''%' +
    UpperCase(ATexto.Trim) + '%''';
  oQueryListarEstados.Filtered := True;
  Result := oQueryListarEstados.IsEmpty;
end;

function TEstadoModel.VerificarExcluir(AId: integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select idMunicipio from municipio where municipio_iduf = ' +
      IntToStr(AId));
    if (oQuery.IsEmpty) then
      Result := True
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TEstadoModel.VerificarUF(AUF: TEstadoDto; out AId: integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select iduf  from uf where UF = ' + QuotedStr(AUF.UF) +
      ' or nome = ' + QuotedStr(AUF.Nome));
    if (not(oQuery.IsEmpty)) then
    begin
      AId := oQuery.FieldByName('iduf').AsInteger;
      Result := True;
    end
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

end.
