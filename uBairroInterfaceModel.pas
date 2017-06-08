unit uBairroInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uBairroDto;

type
  IModelBairroInterface = interface
    function BuscarID: Integer;
    function Alterar(var ABairro: TBairroDto): Boolean;
    function Inserir(var ABairro: TBairroDto): Boolean;
    procedure ListarBairros(var DsBairro: TDataSource);
    function Deletar(const AIDBairro: Integer): Boolean;
    function VerificarBairro(ABairro: TBairroDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Localizar(ATexto: String): Boolean;
    function ADDListaHash(var oLista: TObjectDictionary<string,
      TBairroDto>; const AId: Integer): Boolean;
  end;

implementation

end.
