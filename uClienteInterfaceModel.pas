unit uClienteInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uClienteDto;

type
  IModelClienteInterface = interface
    function BuscarID: Integer;
    function Alterar(var ACliente: TClienteDto): Boolean;
    function Inserir(var ACliente: TClienteDto): Boolean;
    function ListarClientes(var DsTabela: TDataSource): Boolean;
    function Deletar(const ACliente: Integer): Boolean;
    function VerificarCliente(ACliente: TClienteDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Localizar(ATexto: String; ACampo: String): Boolean;
    function BuscarRegistro(var ACliente: TClienteDto): Boolean;
  end;

implementation

end.
