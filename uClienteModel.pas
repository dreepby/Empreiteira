unit uClienteModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uClienteDto, uClassSingletonConexao,
  uClienteInterfaceModel;

type
  TClienteModel = class(TInterfacedObject, IModelClienteInterface)
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
    function Localizar(ATexto: String; ACampo: String): Boolean;
    procedure DesativarFiltro;
    function BuscarRegistro(var ACliente: TClienteDto): Boolean;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TClienteModel }

function TClienteModel.Alterar(var ACliente: TClienteDto): Boolean;
var
  sSql: String;
begin
  sSql := 'UPDATE cliente SET Nome = ' + QuotedStr(ACliente.Nome) + ', CPF = ' +
    QuotedStr(ACliente.Cpf) + ', CNPJ = ' + QuotedStr(ACliente.Cnpj) +
    ', Telefone = ' + QuotedStr(ACliente.Telefone) + ', Celular = ' +
    QuotedStr(ACliente.Celular) + ', Observacao = ' +
    QuotedStr(ACliente.Observacao) + ', Rua = ' + QuotedStr(ACliente.Rua) +
    ', Numero = ' + IntToStr(ACliente.Numero) + ', Complemento = ' +
    QuotedStr(ACliente.Complemento) + ', CEP = ' + QuotedStr(ACliente.Cep) +
    ', cliente_idBairro = ' + IntToStr(ACliente.oBairro.idBairro) +
    ' WHERE idCliente = '+IntToStr(ACliente.idCliente);

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
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

function TClienteModel.BuscarRegistro(var ACliente: TClienteDto): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    oQuery.Open('select c.Nome, c.CPF, c.CNPJ, c.Telefone, c.Celular, ' +
      ' c.Observacao, c.Rua, c.Numero, c.Complemento, c.CEP ,u.Nome estado, ' +
      'm.Nome municipio, b.Nome bairro from cliente c INNER JOIN bairro b ON' +
      ' c.cliente_idBairro = b.idBairro INNER JOIN municipio m ON' +
      ' b.bairro_idMunicipio = m.idMunicipio INNER JOIN uf u ON m.Municipio_idUF'
      + ' = u.idUF where c.IDCliente = ' + IntToStr(ACliente.idCliente));
    if (not(oQuery.IsEmpty)) then
    begin
      Result := True;
      ACliente.Nome := oQuery.FieldByName('Nome').AsString;
      ACliente.Cpf := oQuery.FieldByName('CPF').AsString;
      ACliente.Cnpj := oQuery.FieldByName('CNPJ').AsString;
      ACliente.Telefone := oQuery.FieldByName('Telefone').AsString;
      ACliente.Celular := oQuery.FieldByName('Celular').AsString;
      ACliente.Observacao := oQuery.FieldByName('Observacao').AsString;
      ACliente.Rua := oQuery.FieldByName('Rua').AsString;
      ACliente.Numero := oQuery.FieldByName('Numero').AsInteger;
      ACliente.Complemento := oQuery.FieldByName('Complemento').AsString;
      ACliente.Cep := oQuery.FieldByName('Cep').AsString;
      ACliente.oEstado.Nome := oQuery.FieldByName('estado').AsString;
      ACliente.oMunicipio.Nome := oQuery.FieldByName('municipio').AsString;
      ACliente.oBairro.Nome := oQuery.FieldByName('bairro').AsString;
    end
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

constructor TClienteModel.Create;
begin
  oQueryListaClientes := TFDQuery.Create(nil);
end;

function TClienteModel.Deletar(const ACliente: Integer): Boolean;
begin
  Result := TSingletonConexao.GetInstancia.ExecSQL
    ('delete from cliente where idCliente = ' + IntToStr(ACliente)) > 0;
end;

procedure TClienteModel.DesativarFiltro;
begin
  oQueryListaClientes.Filtered := False;
end;

destructor TClienteModel.Destroy;
begin
  oQueryListaClientes.Close;

  if Assigned(oQueryListaClientes) then
    FreeAndNil(oQueryListaClientes);
  inherited;
end;

function TClienteModel.Inserir(var ACliente: TClienteDto): Boolean;
var
  sSql: String;
begin
  sSql := 'INSERT INTO cliente (idCliente, Nome, CPF, CNPJ, Telefone, Celular,'
    + 'Observacao, Rua, Numero, Complemento, CEP, cliente_idBairro) VALUES(' +
    IntToStr(ACliente.idCliente) + ', ' + QuotedStr(ACliente.Nome) + ', ' +
    QuotedStr(ACliente.Cpf) + ', ' + QuotedStr(ACliente.Cnpj) + ', ' +
    QuotedStr(ACliente.Telefone) + ', ' + QuotedStr(ACliente.Celular) + ', ' +
    QuotedStr(ACliente.Observacao) + ', ' + QuotedStr(ACliente.Rua) + ', ' +
    IntToStr(ACliente.Numero) + ', ' + QuotedStr(ACliente.Complemento) + ', ' +
    QuotedStr(ACliente.Cep) + ', ' + IntToStr(ACliente.oBairro.idBairro) + ')';

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

procedure TClienteModel.ListarClientes(var DsTabela: TDataSource);
begin
  oQueryListaClientes.Filtered := False;
  oQueryListaClientes.Connection := TSingletonConexao.GetInstancia;
  oQueryListaClientes.Open
    ('SELECT c.idCliente, c.Nome, c.CPF, c.CNPJ, c.Telefone, c.Celular,' +
    ' c.Observacao,c.Complemento, CONCAT("Rua: ",c.Rua, ", Nº: " ,c.Numero) as '
    + ' endereco, c.CEP, b.Nome as bairro, CONCAT(m.Nome, " - ",u.UF) as municipio FROM '
    + ' cliente c INNER JOIN bairro b ON c.cliente_idBairro = b.idBairro INNER JOIN '
    + ' municipio m ON b.bairro_idMunicipio = m.idMunicipio INNER JOIN uf u' +
    ' ON m.Municipio_idUF = u.idUF');
  DsTabela.DataSet := oQueryListaClientes;
end;

function TClienteModel.Localizar(ATexto, ACampo: String): Boolean;
begin
  Result := True;
  oQueryListaClientes.Filtered := False;
  if ATexto.Trim <> EmptyStr then
  begin
    oQueryListaClientes.Filter := 'UPPER(' + ACampo + ') LIKE ''%' +
      UpperCase(ATexto.Trim) + '%''';
    oQueryListaClientes.Filtered := True;
    Result := oQueryListaClientes.RecordCount > 0;
    if (not(Result)) then
      oQueryListaClientes.Filtered := False;
  end;
end;

function TClienteModel.Pesquisar(ACampo: String; AValor: String): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  Result := False;
  try
    oQuery.Open
      ('SELECT c.idCliente, c.Nome, c.CPF, c.CNPJ, c.Telefone, c.Celular,' +
      ' c.Observacao,c.Complemento, CONCAT("Rua: ",c.Rua, ", Nº: " ,c.Numero) as '
      + ' endereco, c.CEP, b.Nome as bairro, CONCAT(m.Nome, " - ",u.UF) as municipio FROM '
      + ' cliente c INNER JOIN bairro b ON c.cliente_idBairro = b.idBairro INNER JOIN '
      + ' municipio m ON b.bairro_idMunicipio = m.idMunicipio INNER JOIN uf u' +
      ' ON m.Municipio_idUF = u.idUF');
    if (not(oQuery.IsEmpty)) then
    begin
      oQueryListaClientes.Open
        ('SELECT c.idCliente, c.Nome, c.CPF, c.CNPJ, c.Telefone, c.Celular,' +
        ' c.Observacao,c.Complemento, CONCAT("Rua: ",c.Rua, ", Nº: " ,c.Numero) as '
        + ' endereco, c.CEP, b.Nome as bairro, CONCAT(m.Nome, " - ",u.UF) as municipio FROM '
        + ' cliente c INNER JOIN bairro b ON c.cliente_idBairro = b.idBairro INNER JOIN '
        + ' municipio m ON b.bairro_idMunicipio = m.idMunicipio INNER JOIN uf u'
        + ' ON m.Municipio_idUF = u.idUF');
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
      QuotedStr(ACliente.Cpf) + ' or CNPJ = ' + QuotedStr(ACliente.Cnpj));
    if (not(oQuery.IsEmpty)) then
    begin
      AId := oQuery.FieldByName('idCliente').AsInteger;
      Result := True;
    end
    else
      Result := False;
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
    oQuery.Open('select idReforma from reforma where Pedinte_IDCliente = ' +
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
