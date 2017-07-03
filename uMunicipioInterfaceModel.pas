unit uMunicipioInterfaceModel;

interface

uses
  Data.DB, System.Generics.Collections, uMunicipioDto;

type
  IModelMunicipioInterface = interface
    function BuscarID: Integer;
    function Alterar(var AMunicipio: TMunicipioDto): Boolean;
    function Inserir(var AMunicipio: TMunicipioDto): Boolean;
    function ListarMunicipios(var DsEstado: TDataSource): Boolean;
    function Deletar(const AIDMunicipio: Integer): Boolean;
    function VerificarMunicipio(AMunicipio: TMunicipioDto;
      out AId: Integer): Boolean;
    function VerificarExcluir(AId: Integer): Boolean;
    function ADDListaHash(var oMunicipio: TObjectDictionary<string,
      TMunicipioDto>; const AId: Integer): Boolean;
    function Localizar(ATexto: String): Boolean;
    function BuscarRegistro(AMunicipio: TMunicipioDto): Boolean;
  end;

implementation

end.
