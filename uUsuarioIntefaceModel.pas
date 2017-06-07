unit uUsuarioIntefaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uUsuarioDto;

type
  IModelUsuarioInterface = interface
    function BuscarID: Integer;
    function Alterar(var AUsuario: TUsuarioDto): Boolean;
    function Inserir(var AUsuario: TUsuarioDto): Boolean;
    procedure ListarUsuarios(var DsUsuario: TDataSource);
    function Deletar(const AidUsuario: Integer): Boolean;
    function Pesquisar(ANome: String): Boolean;
    function VerificarUsuario(AUsuario: TUsuarioDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function ADDListaHash(var oMunicipio: TObjectDictionary<string,
      TUsuarioDto>; const AId: Integer): Boolean;
  end;

implementation

end.
