unit uMunicipioInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uMunicipioDto;

type
  IModelMunicipioInterface = interface
    function BuscarID: Integer;
    function Alterar(var AMunicipio: TMunicipioDto): Boolean;
    function Inserir(var AMunicipio: TMunicipioDto): Boolean;
    procedure ListarMunicipios(var DsEstado: TDataSource);
    function Deletar(const AIDMunicipio: Integer): Boolean;
    function Pesquisar(ANome: String): Boolean;
    function VerificarMunicipio(AMunicipio: TMunicipioDto;
      out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function ADDListaHash(var oMunicipio: TObjectDictionary<string,
      TMunicipioDto>; const AId: Integer): Boolean;
  end;

implementation

end.
