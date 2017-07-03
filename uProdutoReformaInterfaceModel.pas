unit uProdutoReformaInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uProdutoReformaDto;

type
  IModelProdutoReformaInterface = interface
    function BuscarID: Integer;
    function Inserir(var AProdutoReforma: TProdutoReformaDto): Boolean;
    procedure Deletar(const ACodigoAmbienteReforma: Integer);
  end;

implementation

end.
