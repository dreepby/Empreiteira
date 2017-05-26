unit uClienteModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uClienteDto, uClassSingletonConexao;

type
  TClienteModel = class
  private
    oQueryListaClientes: TFDQuery;
  public
    function BuscarID: Integer;
    function Alterar(var ACliente: TClienteDto): Boolean;
    function Inserir(var ACliente: TClienteDto): Boolean;
    procedure ListarClientes(var DsTabela: TDataSource);
    function Deletar(const ACliente: Integer): Boolean;
    function Pesquisar(ANome: String): Boolean;
    function VerificarCliente(ACliente: TClienteDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
  end;

implementation

{ TClienteModel }

function TClienteModel.Alterar(var ACliente: TClienteDto): Boolean;
var
  sSql: String;
begin {
    sSql := 'update bairro set nome = ' + QuotedStr(ACliente.Nome) +
    '     , bairro_idMunicipio = ' + IntToStr(ACliente.oMunicipio.idMunicipio) +
    ' where idBairro = ' + IntToStr(ACliente.idBairro);

    Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0; }
end;

function TClienteModel.BuscarID: Integer;
var
  oQuery: TFDQuery;
begin
  Result := 1;
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select max(idCliente) as ID' + '  from cliente');
    if (not(oQuery.IsEmpty)) then
      Result := oQuery.FieldByName('ID').AsInteger + 1;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TClienteModel.Deletar(const ACliente: Integer): Boolean;
begin

end;

function TClienteModel.Inserir(var ACliente: TClienteDto): Boolean;
begin

end;

procedure TClienteModel.ListarClientes(var DsTabela: TDataSource);
begin
  oQueryListaClientes.Connection := TSingletonConexao.GetInstancia;
  oQueryListaClientes.Open
    ('select ');
  DsTabela.DataSet := oQueryListaClientes;
end;

function TClienteModel.Pesquisar(ANome: String): Boolean;
begin

end;

function TClienteModel.VerificarCliente(ACliente: TClienteDto;
  out AId: Integer): Boolean;
begin

end;

function TClienteModel.VerificarExcluir(AId: Integer): Boolean;
begin

end;

end.
