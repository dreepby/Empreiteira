unit uAmbienteInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uAmbienteDto;

type
  IModelAmbienteInterface = interface
    function BuscarID: Integer;
    function Alterar(var AAmbiente: TAmbienteDto): Boolean;
    function Inserir(var AAmbiente: TAmbienteDto): Boolean;
    procedure ListarAmbientes(var DsTabela: TDataSource);
    function Deletar(const AIDAmbiente: Integer): Boolean;
    function VerificarAmbiente(AAmbiente: TAmbienteDto;
      out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function Localizar(ATexto: String): Boolean;
    function ADDListaHash(var oLista: TObjectDictionary<string,
      TAmbienteDto>): Boolean;
  end;

implementation

end.
