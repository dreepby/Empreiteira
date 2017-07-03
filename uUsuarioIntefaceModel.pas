unit uUsuarioIntefaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uUsuarioDto;

type
  IModelUsuarioInterface = interface
function BuscarID: Integer;
    function Alterar(var AUsuario: TUsuarioDto): Boolean;
    function Inserir(var AUsuario: TUsuarioDto): Boolean;
    function ListarUsuarios(var DsUsuario: TDataSource): Boolean;
    function Deletar(const AidUsuario: Integer): Boolean;
    function Localizar(ATexto, ACampo: String): Boolean;
    function VerificarUsuario(AUsuario: TUsuarioDto; out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function ADDListaHash(var oUsuario: TObjectDictionary<string,
      TUsuarioDto>): Boolean;

  end;

implementation

end.
