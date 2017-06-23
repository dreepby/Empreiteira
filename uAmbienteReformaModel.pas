unit uAmbienteReformaModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, System.Generics.Collections,
  uAmbienteReformaDto, uClassSingletonConexao, uAmbienteReformaInterfaceModel;

type
  TAmbienteReformaModel = class(TInterfacedObject,
    IModelAmbienteReformaInterface)
    function BuscarID: Integer;
    function Inserir(var AAmbienteReforma: TAmbienteReformaDto): Boolean;
    function Deletar(const AidReforma: Integer): Boolean;
    function VerificarAmbienteReforma(AAmbienteReforma: TAmbienteReformaDto;
      out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
  end;

implementation

{ TAmbienteReformaModel }

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
    QuotedStr(AAmbienteReforma.oReforma.idReforma) + ', ' + QuotedStr(AAmbienteReforma.oAmbiente.idAmbiente) + ')';

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
