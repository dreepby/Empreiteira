unit uUsuarioModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uUsuarioDto, uClassSingletonConexao,
  System.Generics.Collections, uUsuarioIntefaceModel;

type
  TUsuarioModel = class(TInterfacedObject, IModelUsuarioInterface)
  private
    oQueryListarUsuarios: TFDQuery;
  public
    function BuscarID: Integer;
    function Alterar(var AUsuario: TUsuarioDto): Boolean;
    function Inserir(var AUsuario: TUsuarioDto): Boolean;
    procedure ListarUsuarios(var DsUsuario: TDataSource);
    function Deletar(const AidUsuario: Integer): Boolean;
    function Localizar(ATexto, ACampo: String): Boolean;
    function Pesquisar(const AModel: IModelUsuarioInterface;
      ANome: String): Boolean;
    function VerificarUsuario(AUsuario: TUsuarioDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function ADDListaHash(var oUsuario: TObjectDictionary<string, TUsuarioDto>;
      const AId: Integer): Boolean;
    procedure DesativarFiltro;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TUsuarioModel }

function TUsuarioModel.ADDListaHash(var oUsuario
  : TObjectDictionary<string, TUsuarioDto>; const AId: Integer): Boolean;
begin

end;

function TUsuarioModel.Alterar(var AUsuario: TUsuarioDto): Boolean;
var
  sSql: String;
begin
  sSql := 'update Usuario set nome = ' + QuotedStr(AUsuario.Nome) +
    '     , CPF = "' + (AUsuario.CPF) + '" where idUsuario = ' +
    IntToStr(AUsuario.idUsuario);

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;

end;

function TUsuarioModel.BuscarID: Integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(IdUsuario) as ID' + '  from Usuario');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;

end;

constructor TUsuarioModel.Create;
begin
  oQueryListarUsuarios := TFDQuery.Create(nil);
end;

function TUsuarioModel.Deletar(const AidUsuario: Integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from usuario where idusuario = ' + IntToStr(AidUsuario)) > 0;
end;

procedure TUsuarioModel.DesativarFiltro;
begin
  oQueryListarUsuarios.Filtered := False;
end;

destructor TUsuarioModel.Destroy;
begin
  oQueryListarUsuarios.Close;

  if (Assigned(oQueryListarUsuarios)) then
    FreeAndNil(oQueryListarUsuarios);
  inherited;
end;

function TUsuarioModel.Inserir(var AUsuario: TUsuarioDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into Usuario (idUsuario, Nome, CPF) values (' +
    IntToStr(AUsuario.idUsuario) + ', ' + QuotedStr(AUsuario.Nome) + ', ' +
    QuotedStr(AUsuario.CPF) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;

end;

procedure TUsuarioModel.ListarUsuarios(var DsUsuario: TDataSource);
begin
  oQueryListarUsuarios.Filtered := False;
  oQueryListarUsuarios.Connection := TSingletonConexao.GetInstancia;
  oQueryListarUsuarios.Open('select * from usuario');
  DsUsuario.DataSet := oQueryListarUsuarios;

end;



function TUsuarioModel.Localizar(ATexto, ACampo: String): Boolean;
begin
Result := True;
  oQueryListarUsuarios.Filtered := False;
  if ATexto.Trim <> EmptyStr then
  begin
    oQueryListarUsuarios.Filter := 'UPPER(' + ACampo + ') LIKE ''%' +
      UpperCase(ATexto.Trim) + '%''';
    oQueryListarUsuarios.Filtered := True;
    Result := oQueryListarUsuarios.RecordCount > 0;
    if (not(Result)) then
      oQueryListarUsuarios.Filtered := False;
  end;
end;

function TUsuarioModel.Pesquisar(const AModel: IModelUsuarioInterface;
  ANome: String): Boolean;
begin

end;

function TUsuarioModel.VerificarExcluir(AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select idReforma from Reforma where Escritor_idUsuario = ' +
      IntToStr(AId) + ' or Atendente_idUsuario = ' + IntToStr(AId));
    if (oQuery.IsEmpty) then
      Result := True
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TUsuarioModel.VerificarUsuario(AUsuario: TUsuarioDto;
  out AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select IdUsuario from Usuario where CPF=' +
      (QuotedStr(AUsuario.CPF)));
    if (not(oQuery.IsEmpty)) then
    begin
      AId := oQuery.FieldByName('IdUsuario').AsInteger;
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
