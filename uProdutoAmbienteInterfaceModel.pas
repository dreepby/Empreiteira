unit uProdutoAmbienteInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uProdutoAmbienteDto,uArrayAmbientes;

type

  IModelProdutoAmbienteInterface = interface
    function Inserir(var AProdutoAmbiente: TProdutoAmbienteDto): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Deletar(const AProdutoAmbiente: Integer): Boolean;
    function BuscarID: Integer;
    function VerificarProdutoAmbiente(AProdutoAmbiente: TProdutoAmbienteDto;
      out AId: Integer): Boolean;
    procedure BuscarAmbientes(const ID: Integer; var oAmbientes: TAmbientesReformaArray);
  end;

implementation

end.
