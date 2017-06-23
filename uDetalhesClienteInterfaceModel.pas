unit uDetalhesClienteInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uClienteDto;

type
  IModelDetalhesClienteInterface = interface
    function BuscarRegistroCpfCnpj(const ACliente: TClienteDto): Boolean;
    function VerificarCliente(ACliente: TClienteDto; out AId: Integer): Boolean;
    function BuscarID: Integer;
    function Inserir(var ACliente: TClienteDto): Boolean;
    function Alterar(var ACliente: TClienteDto): Boolean;
  end;

implementation

end.
