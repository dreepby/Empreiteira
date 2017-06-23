unit uDetalhesClienteModel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, Data.DB, FireDAC.DApt, FireDAC.Comp.UI,
  FireDAC.Comp.DataSet, uClienteDto, uClassSingletonConexao,
  uDetalhesClienteInterfaceModel;

type
  TDetalhesClienteModel = class(TInterfacedObject,
    IModelDetalhesClienteInterface)
  public
    function BuscarRegistroCpfCnpj(const ACliente: TClienteDto): Boolean;
    function VerificarCliente(ACliente: TClienteDto; out AId: Integer): Boolean;
    function BuscarID: Integer;
    function Inserir(var ACliente: TClienteDto): Boolean;
    function Alterar(var ACliente: TClienteDto): Boolean;
  end;

implementation

{ TDetalhesClienteModel }

function TDetalhesClienteModel.Alterar(var ACliente: TClienteDto): Boolean;
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
    ' WHERE idCliente = ' + IntToStr(ACliente.idCliente);

  Result := TSingletonConexao.GetInstancia.ExecSQL(sSql) > 0;
end;

function TDetalhesClienteModel.BuscarID: Integer;
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

function TDetalhesClienteModel.BuscarRegistroCpfCnpj(const ACliente
  : TClienteDto): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  try
    if ACliente.Cpf <> EmptyStr then
    begin
      oQuery.Connection := TSingletonConexao.GetInstancia;
      oQuery.Open
        ('select c.idCliente,c.Nome, c.CPF, c.CNPJ, c.Telefone, c.Celular, ' +
        ' c.Observacao, c.Rua, c.Numero, c.Complemento, c.CEP ,u.Nome estado, '
        + 'm.Nome municipio, b.Nome bairro from cliente c INNER JOIN bairro b ON'
        + ' c.cliente_idBairro = b.idBairro INNER JOIN municipio m ON' +
        ' b.bairro_idMunicipio = m.idMunicipio INNER JOIN uf u ON m.Municipio_idUF'
        + ' = u.idUF where c.CPF = ' + QuotedStr(ACliente.Cpf));
      if (not(oQuery.IsEmpty)) then
      begin
        Result := True;
        ACliente.idCliente := oQuery.FieldByName('idCliente').AsInteger;
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
    end
    else if ACliente.Cnpj <> EmptyStr then
    begin
      oQuery.Connection := TSingletonConexao.GetInstancia;
      oQuery.Open
        ('select c.idCliente,c.Nome, c.CPF, c.CNPJ, c.Telefone, c.Celular, ' +
        ' c.Observacao, c.Rua, c.Numero, c.Complemento, c.CEP ,u.Nome estado, '
        + 'm.Nome municipio, b.Nome bairro from cliente c INNER JOIN bairro b ON'
        + ' c.cliente_idBairro = b.idBairro INNER JOIN municipio m ON' +
        ' b.bairro_idMunicipio = m.idMunicipio INNER JOIN uf u ON m.Municipio_idUF'
        + ' = u.idUF where c.cnpj = ' + QuotedStr(ACliente.Cnpj));
      if (not(oQuery.IsEmpty)) then
      begin
        Result := True;
        ACliente.idCliente := oQuery.FieldByName('idCliente').AsInteger;
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
    end
    else
      Result := False;
  finally
    if Assigned(oQuery) then
      FreeAndNil(oQuery);
  end;
end;

function TDetalhesClienteModel.Inserir(var ACliente: TClienteDto): Boolean;
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

function TDetalhesClienteModel.VerificarCliente(ACliente: TClienteDto;
  out AId: Integer): Boolean;
var
  oQuery: TFDQuery;
begin
  oQuery := TFDQuery.Create(nil);
  Result := False;
  try
    oQuery.Connection := TSingletonConexao.GetInstancia;
    if ACliente.Cpf <> EmptyStr then
    begin
      oQuery.Open('select idCliente from cliente where CPF = ' +
        QuotedStr(ACliente.Cpf) + ' AND idCliente = idCliente');
    end
    else if ACliente.Cnpj <> EmptyStr then
    begin
      oQuery.Open('select idCliente from cliente where CNPJ = ' +
        QuotedStr(ACliente.Cnpj) + ' AND idCliente = idCliente');
    end;

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

end.
