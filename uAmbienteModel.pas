unit uAmbienteModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uAmbienteDto, uClassSingletonConexao,
  uAmbienteInterfaceModel, System.Generics.Collections;

type
  TAmbienteModel = class(TInterfacedObject, IModelAmbienteInterface)
  private
    oQueryListaAmbientes: TFDQuery;
  public
    function BuscarID: Integer;
    function Alterar(var AAmbiente: TAmbienteDto): Boolean;
    function Inserir(var AAmbiente: TAmbienteDto): Boolean;
    procedure ListarAmbientes(var DsTabela: TDataSource);
    function Deletar(const AIDAmbiente: Integer): Boolean;
    function VerificarAmbiente(AAmbiente: TAmbienteDto;
      out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Localizar(ATexto: String): Boolean;
    function ADDListaHash(var oLista: TObjectDictionary<string,
      TAmbienteDto>): Boolean;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TAmbienteModel }

function TAmbienteModel.ADDListaHash(var oLista
  : TObjectDictionary<string, TAmbienteDto>): Boolean;
var
  oAmbienteDTO: TAmbienteDto;
  oQuery: TFDQuery;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select * from ambiente');

    if (not(oQuery.IsEmpty)) then
    begin
      oQuery.First;
      while (not(oQuery.Eof)) do
      begin
        // Instancia do objeto
        oAmbienteDTO := TAmbienteDto.Create;

        // Atribui os valores
        oAmbienteDTO.idAmbiente := oQuery.FieldByName('idAmbientes').AsInteger;
        oAmbienteDTO.Descricao := oQuery.FieldByName('descricao').AsString;

        // Adiciona o objeto na lista hash
        oLista.Add(oAmbienteDTO.Descricao, oAmbienteDTO);

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

function TAmbienteModel.Alterar(var AAmbiente: TAmbienteDto): Boolean;
var
  sSql: String;
begin
  sSql := 'update ambiente set descricao = ' + QuotedStr(AAmbiente.Descricao) +
    ' where idAmbientes = ' + IntToStr(AAmbiente.idAmbiente);

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

function TAmbienteModel.BuscarID: Integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(idAmbientes) as ID' + '  from ambiente');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

constructor TAmbienteModel.Create;
begin
  oQueryListaAmbientes := TFDQuery.Create(nil);
end;

function TAmbienteModel.Deletar(const AIDAmbiente: Integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from ambiente where idAmbientes = ' + IntToStr(AIDAmbiente)) > 0;
end;

destructor TAmbienteModel.Destroy;
begin
  oQueryListaAmbientes.Close;

  if Assigned(oQueryListaAmbientes) then
    FreeAndNil(oQueryListaAmbientes);
  inherited;
end;

function TAmbienteModel.Inserir(var AAmbiente: TAmbienteDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into ambiente (idAmbientes, Descricao) values (' +
    IntToStr(AAmbiente.idAmbiente) + ', ' +
    QuotedStr(AAmbiente.Descricao) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

procedure TAmbienteModel.ListarAmbientes(var DsTabela: TDataSource);
begin
  oQueryListaAmbientes.Filtered := False;
  oQueryListaAmbientes.Connection := TSingletonConexao.GetInstancia;
  oQueryListaAmbientes.Open('select idAmbientes, Descricao from Ambiente');
  DsTabela.DataSet := oQueryListaAmbientes;
end;

function TAmbienteModel.Localizar(ATexto: String): Boolean;
begin
  Result := True;
  oQueryListaAmbientes.Filtered := False;
  if ATexto.Trim <> EmptyStr then
  begin
    oQueryListaAmbientes.Filter := 'UPPER(DESCRICAO) LIKE ''%' +
      UpperCase(ATexto.Trim) + '%''';
    oQueryListaAmbientes.Filtered := True;
    Result := oQueryListaAmbientes.RecordCount > 0;
    if (not(Result)) then
      oQueryListaAmbientes.Filtered := False;
  end;
end;

function TAmbienteModel.VerificarAmbiente(AAmbiente: TAmbienteDto;
  out AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select idAmbientes from ambiente where descricao=' +
      QuotedStr(AAmbiente.Descricao));
    if (not(oQuery.IsEmpty)) then
    begin
      AId := oQuery.FieldByName('idAmbientes').AsInteger;
      Result := True;
    end
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TAmbienteModel.VerificarExcluir(AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open
      ('select idAmbienteReforma from AmbienteReforma where Ambiente_idAmbientes = '
      + IntToStr(AId));
    if (oQuery.IsEmpty) then
      Result := True
    else
    begin
      oQuery.Open
        ('select idProduto_Ambiente from Produto_Ambiente where Ambientes_idAmbientes = '
        + IntToStr(AId));
      if (oQuery.IsEmpty) then
        Result := True
      else
        Result := False;
    end;

  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

end.
