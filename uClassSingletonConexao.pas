unit uClassSingletonConexao;

interface

uses
  System.SysUtils, uClassConexaoBanco;

type
  TSingletonConexao = class
    private
      class var oObjetoConexao: TConexao;
    public
      class function GetInstancia: TConexao;
  end;
implementation

{ TSingleton }

class function TSingletonConexao.GetInstancia: TConexao;
begin
 if(not(Assigned(oObjetoConexao))) then
    oObjetoConexao := TConexao.Create(nil);

  Result := oObjetoConexao;
end;

Initialization

Finalization
  if(Assigned(TSingletonConexao.oObjetoConexao)) then
    FreeAndNil(TSingletonConexao.oObjetoConexao);

end.
