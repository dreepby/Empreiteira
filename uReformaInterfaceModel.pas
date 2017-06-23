unit uReformaInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uReformaDto;

type
  IModelReformaInterface = interface
    function BuscarID: Integer;
    function Alterar(var AReforma: TReformaDto;
      AAmbientes: Array of Integer): Boolean;
    function Inserir(var AReforma: TReformaDto;
      AAmbientes: Array of Integer): Boolean;
    procedure ListarReformas(var DsTabela: TDataSource);
    function Deletar(const AID: Integer): Boolean;
    function Pesquisar(ANome: String): Boolean;
    function VerificarExcluir(AID: Integer): Boolean;
    function ADDListaHash(var oReforma: TObjectDictionary<string, TReformaDto>;
      const AID: Integer): Boolean;
  end;

implementation

end.
