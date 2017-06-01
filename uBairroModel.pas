unit uBairroModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uBairroDto, uClassSingletonConexao;

type
  TBairroModel = class
  private
    oQueryListaBairros: TFDQuery;
  public
    function BuscarID: Integer;
    function Alterar(var ABairro: TBairroDto): Boolean;
    function Inserir(var ABairro: TBairroDto): Boolean;
    procedure ListarBairros(var DsBairro: TDataSource);
    function Deletar(const AIDBairro: Integer): Boolean;
    function VerificarBairro(ABairro: TBairroDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Localizar(ATexto: String): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TBairrosModel }

function TBairroModel.Alterar(var ABairro: TBairroDto): Boolean;
var
  sSql: String;
begin
  sSql := 'update bairro set nome = ' + QuotedStr(ABairro.Nome) +
    '     , bairro_idMunicipio = ' + IntToStr(ABairro.oMunicipio.idMunicipio) +
    ' where idBairro = ' + IntToStr(ABairro.idBairro);

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

function TBairroModel.BuscarID: Integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(idBairro) as ID' + '  from bairro');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

constructor TBairroModel.Create;
begin
  oQueryListaBairros := TFDQuery.Create(nil);
end;

function TBairroModel.Deletar(const AIDBairro: Integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from bairro where idBairro = ' + IntToStr(AIDBairro)) > 0;
end;

destructor TBairroModel.Destroy;
begin
  oQueryListaBairros.Close;

  if Assigned(oQueryListaBairros) then
    FreeAndNil(oQueryListaBairros);
  inherited;
end;

function TBairroModel.Inserir(var ABairro: TBairroDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into bairro (idBairro, Nome, bairro_idMunicipio) values (' +
    IntToStr(ABairro.idBairro) + ', ' + QuotedStr(ABairro.Nome) + ', ' +
    IntToStr(ABairro.oMunicipio.idMunicipio) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

procedure TBairroModel.ListarBairros(var DsBairro: TDataSource);
begin
  oQueryListaBairros.Filtered := False;
  oQueryListaBairros.Connection := TSingletonConexao.GetInstancia;
  oQueryListaBairros.Open
    ('select b.idBairro, b.nome, m.nome as nomeMunicipio, u.Nome as NomeEstado from bairro b inner join municipio m on b.bairro_idMunicipio = m.idMunicipio inner join uf u on m.Municipio_idUF = u.idUF');
  DsBairro.DataSet := oQueryListaBairros;
end;

function TBairroModel.Localizar(ATexto: String): Boolean;
begin
  Result := True;
  oQueryListaBairros.Filtered := False;
  if ATexto.Trim <> EmptyStr then
  begin
    oQueryListaBairros.Filter := 'UPPER(NOME) LIKE ''%'+UpperCase(ATexto.Trim)+'%''';
    oQueryListaBairros.Filtered := True;
    Result := oQueryListaBairros.RecordCount > 0;
    if (not(Result)) then
      oQueryListaBairros.Filtered := False;
  end;
end;



function TBairroModel.VerificarBairro(ABairro: TBairroDto;
  out AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select IdBairro from bairro where Nome=' +
      QuotedStr(ABairro.Nome) + ' AND bairro_idMunicipio=' +
      IntToStr(ABairro.oMunicipio.idMunicipio));
    if (not(oQuery.IsEmpty)) then
    begin
      AId := oQuery.FieldByName('IdBairro').AsInteger;
      Result := True;
    end
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TBairroModel.VerificarExcluir(AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select idCliente from cliente where cliente_idBairro = ' +
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

end.
