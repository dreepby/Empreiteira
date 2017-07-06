unit uProdutoInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uProdutoDto;

type
  IModelProdutoInterface = interface
    function BuscarID: Integer;
    function Alterar(var AProduto: TProdutoDto): Boolean;
    function Inserir(var AProduto: TProdutoDto): Boolean;
    function ListarProdutos(var DsProduto: TDataSource): Boolean;
    function BuscarProdutosPorAmbiente(const AIdAmbiente: Integer;
      var ALista: TObjectDictionary<string, TProdutoDto>): Boolean;
    function Deletar(const AIDProduto: Integer): Boolean;
    function VerificarProduto(AProduto: TProdutoDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Localizar(ATexto: String): Boolean;
    function BuscarProduto(AProduto: TProdutoDto): Boolean;
    function ADDListaHash(var oProduto: TObjectDictionary<string,
      TProdutoDto>): Boolean;
    function VerificarNome(const Nome: string): Boolean;

  end;

implementation

end.
