unit uProdutoAmbienteInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uProdutoAmbienteDto, uArrayAmbientes;

type

  IModelProdutoAmbienteInterface = interface
    function Inserir(var AProdutoAmbiente: TProdutoAmbienteDto): Boolean;
    function VerificarExcluir(AId: integer): Boolean;
    function Deletar(const AProdutoAmbiente: integer): Boolean;
    function BuscarID: integer;
    function VerificarProdutoAmbiente(AProdutoAmbiente: TProdutoAmbienteDto;
      out AId: integer): Boolean;
    procedure BuscarAmbientes(const ID: integer;
      var oAmbientes: TAmbientesReformaArray);
    function CompararAmbientesTabela(const IDP, IDA: integer): integer;
    function BuscarAmbientesArray(var AAmbientesArray: TAmbientesReformaArray; const  ID: integer): Boolean;

  end;

implementation

end.
