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
    function Pesquisar(ACampo: String; AValor: String): Boolean;
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
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from cliente where idCliente = ' + IntToStr(ACliente)) > 0;
end;

function TClienteModel.Inserir(var ACliente: TClienteDto): Boolean;
begin

end;

procedure TClienteModel.ListarClientes(var DsTabela: TDataSource);
begin
  oQueryListaClientes.Connection := TSingletonConexao.GetInstancia;
  oQueryListaClientes.Open
    ('SELECT c.idCliente, c.Nome, c.CPF, c.CNPJ, c.Telefone, c.Celular, c.Observacao,'
    + 'c.Complemento, CONCAT("Rua: ",c.Rua,", CEP: ",c.CEP, "Nº: " ,c.Numero, ", Bairro: ",'
    + ' b.Nome, ", Municipio: ", m.Nome, " Estado: ", u.Nome, ", Complemento: ", c.Complemento) as endereco FROM '
    + 'cliente c INNER JOIN bairro b ON c.cliente_idBairro = b.idBairro INNER JOIN'
    + ' municipio m ON b.bairro_idMunicipio = m.idMunicipio INNER JOIN uf u' +
    'ON m.Municipio_idUF = u.idUF');
  DsTabela.DataSet := oQueryListaClientes;
end;

function TClienteModel.Pesquisar(ACampo: String; AValor: String): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  Result := false;
  try
    oQuery.Open
      ('SELECT c.idCliente, c.Nome, c.CPF, c.CNPJ, c.Telefone, c.Celular, c.Observacao,'
      + 'c.Complemento, CONCAT("Rua: ",c.Rua,", CEP: ",c.CEP, "Nº: " ,c.Numero, ", Bairro: ",'
      + ' b.Nome, ", Municipio: ", m.Nome, " Estado: ", u.Nome, ", Complemento: ", c.Complemento) as endereco FROM '
      + 'cliente c INNER JOIN bairro b ON c.cliente_idBairro = b.idBairro INNER JOIN'
      + ' municipio m ON b.bairro_idMunicipio = m.idMunicipio INNER JOIN uf u' +
      'ON m.Municipio_idUF = u.idUF WHERE ' + ACampo + ' LIKE "%' +
      AValor + '%"');
    if (not(oQuery.IsEmpty)) then
    begin
      oQueryListaClientes.Open
        ('SELECT c.idCliente, c.Nome, c.CPF, c.CNPJ, c.Telefone, c.Celular, c.Observacao,'
        + 'c.Complemento, CONCAT("Rua: ",c.Rua,", CEP: ",c.CEP, "Nº: " ,c.Numero, ", Bairro: ",'
        + ' b.Nome, ", Municipio: ", m.Nome, " Estado: ", u.Nome, ", Complemento: ", c.Complemento) as endereco FROM '
        + 'cliente c INNER JOIN bairro b ON c.cliente_idBairro = b.idBairro INNER JOIN'
        + ' municipio m ON b.bairro_idMunicipio = m.idMunicipio INNER JOIN uf u'
        + 'ON m.Municipio_idUF = u.idUF WHERE ' + ACampo + ' LIKE "%' +
        AValor + '%"');
      Result := True;
    end;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TClienteModel.VerificarCliente(ACliente: TClienteDto;
  out AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select idCliente from cliente where CPF = ' +
      IntToStr(ACliente.Cpf) + ' or CNPJ = ' + IntToStr(ACliente.Cnpj));
    if (not(oQuery.IsEmpty)) then
    begin
      AId := oQuery.FieldByName('idCliente').AsInteger;
      Result := True;
    end
    else
      Result := false;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TClienteModel.VerificarExcluir(AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select idReforma from reforma where Pedinte_Cliente = ' +
      IntToStr(AId));
    if (oQuery.IsEmpty) then
      Result := True
    else
      Result := false;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

end.
