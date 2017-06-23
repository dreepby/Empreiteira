unit uClienteInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uClienteDto;

type
  IModelClienteInterface = interface
    function BuscarID: Integer;
    function Alterar(var ACliente: TClienteDto): Boolean;
    function Inserir(var ACliente: TClienteDto): Boolean;
    procedure ListarClientes(var DsTabela: TDataSource);
    function Deletar(const ACliente: Integer): Boolean;
    function Pesquisar(ACampo: String; AValor: String): Boolean;
    function VerificarCliente(ACliente: TClienteDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Localizar(ATexto, ACampo: String): Boolean;
    procedure DesativarFiltro;
    function BuscarRegistro(var ACliente: TClienteDto): Boolean;
    function BuscarRegistroIdCpf(AValor: String): Integer;
    function BuscarRegistroIdCnpj(AValor: String): Integer;
  end;

implementation

end.
