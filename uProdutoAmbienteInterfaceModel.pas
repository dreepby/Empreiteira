unit uProdutoAmbienteInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uProdutoAmbienteDto;

type
  IModelProdutoAmbienteInterface = interface
    function Inserir(var AProdutoAmbiente: TProdutoAmbienteDto): Boolean;
    function VerificarExcluir(AId: integer): Boolean;
    function Deletar(const AProdutoAmbiente: integer): Boolean;
    function BuscarID: integer;
    function VerificarProdutoAmbiente(AProdutoAmbiente: TProdutoAmbienteDto;
      out AId: integer): Boolean;
  end;

implementation

end.
