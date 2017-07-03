unit uAmbienteReformaModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, System.Generics.Collections,
  uAmbienteReformaDto, uClassSingletonConexao, uAmbienteReformaInterfaceModel,
  uAmbienteDto, uArrayDinamicoInteger;

type
  TAmbienteReformaModel = class(TInterfacedObject,
    IModelAmbienteReformaInterface)
    function BuscarID: Integer;
    function Inserir(var AAmbienteReforma: TAmbienteReformaDto): Boolean;
    function Deletar(const AidReforma: Integer): Boolean;
    function VerificarAmbienteReforma(AAmbienteReforma: TAmbienteReformaDto;
      out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function BuscarRegistrosReforma(var oLista
      : TObjectDictionary<string, TAmbienteDto>; AidReforma: Integer): Boolean;
    function BuscarArrayAmbientesReforma(const ACodigoReforma: Integer;
      var oArray: TArrayDinamico): Boolean;
  end;

implementation

{ TAmbienteReformaModel }

function TAmbienteReformaModel.BuscarArrayAmbientesReforma(const ACodigoReforma
  : Integer; var oArray: TArrayDinamico): Boolean;
var
  oQuery: TFDQuery;
  i: Integer;
begin
  i := 0;
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open
      ('select IdAmbienteReforma as ID from AmbienteReforma where Ambiente_idReforma = '
      + IntToStr(ACodigoReforma));
    if (not(oQuery.IsEmpty)) then
    begin
      Result := True;
      SetLength(oArray, oQuery.RecordCount);
      oQuery.First;
      while not(oQuery.Eof) do
      begin
        oArray[i] := oQuery.FieldByName('ID').AsInteger;
        oQuery.Next;
        if not(oQuery.IsEmpty) then
          i := i + 1;
      end;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TAmbienteReformaModel.BuscarID: Integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(IdAmbienteReforma) as ID from AmbienteReforma');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TAmbienteReformaModel.BuscarRegistrosReforma
  (var oLista: TObjectDictionary<string, TAmbienteDto>;
  AidReforma: Integer): Boolean;
var
  oAmbienteDTO: TAmbienteDto;
  oQuery: TFDQuery;
begin
  Result := False;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open
      ('SELECT a.idAmbientes, a.Descricao FROM ambienteReforma ar INNER' +
      ' JOIN Ambiente a ON ar.Ambiente_idAmbientes = a.idAmbientes WHERE ' +
      'Ambiente_idReforma = ' + IntToStr(AidReforma));

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

function TAmbienteReformaModel.Deletar(const AidReforma: Integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from AmbienteReforma where idAmbienteReforma = ' +
    IntToStr(AidReforma)) > 0;
end;

function TAmbienteReformaModel.Inserir(var AAmbienteReforma
  : TAmbienteReformaDto): Boolean;
var
  sSql: String;
begin
  sSql := 'insert into AmbienteReforma (idAmbienteReforma, Ambiente_IdReforma, Ambiente_idAmbientes) values ('
    + IntToStr(AAmbienteReforma.IdAmbienteReforma) + ', ' +
    IntToStr(AAmbienteReforma.oReforma.idReforma) + ', ' +
    IntToStr(AAmbienteReforma.oAmbiente.idAmbiente) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

function TAmbienteReformaModel.VerificarAmbienteReforma(AAmbienteReforma
  : TAmbienteReformaDto; out AId: Integer): Boolean;
begin

end;

function TAmbienteReformaModel.VerificarExcluir(AId: Integer): Boolean;
begin

end;

end.
