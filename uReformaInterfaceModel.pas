unit uReformaInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uReformaDto;

type
  IModelReformaInterface = interface
    function BuscarID: Integer;
    function Alterar(var AReforma: TReformaDto): Boolean;
    function Inserir(var AReforma: TReformaDto): Boolean;
    function ListarReformas(var DsTabela: TDataSource): Boolean;
    function Deletar(const AID: Integer): Boolean;
    function VerificarExcluir(AID: Integer): Boolean;
    function BuscarRegistro(var AReforma: TReformaDto): Boolean;
  end;

implementation

end.
