unit uEstadoInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uEstadoDto;

type
  IModelEstadoInterface = interface

    function Inserir(var AEstado: TEstadoDto): Boolean;
    function Alterar(var AEstado: TEstadoDto): Boolean;
    function VerificarExcluir(AId: integer): Boolean;
    function Deletar(const AIDUF: integer): Boolean;
    function ADDListaHash(var oEstado: TObjectDictionary<string,
      TEstadoDto>): Boolean;
    function BuscarID: integer;
    function Ler(var AEstado: TEstadoDto): Boolean;
    procedure ListarEstados(var DsEstado: TDataSource);
    function VerificarUF(AUF: TEstadoDto; out AId: integer): Boolean;
    function Pesquisar(ANome: String): Boolean;
    function Buscar(ANome: String): integer;
  end;

implementation

end.
