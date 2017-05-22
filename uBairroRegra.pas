unit uBairroRegra;

interface

uses
  uBairroDto, System.SysUtils, uBairroModel;

type
  TBairroRegra = class
  public
    procedure Limpar(ABairro: TBairroDto);
    function VerificarExcluir(var AModel: TBairroModel; AId: Integer): Boolean;
    function Deletar(var AModel: TBairroModel; AId: Integer): Boolean;

  end;

implementation

{ TBairroRegra }

function TBairroRegra.Deletar(var AModel: TBairroModel; AId: Integer): Boolean;
begin
   Result := AModel.Deletar(AId);
end;

procedure TBairroRegra.Limpar(ABairro: TBairroDto);
begin
  ABairro.idBairro := 0;
  ABairro.Nome := EmptyStr;
  ABairro.oMunicipio.idMunicipio := 0;
  ABairro.oMunicipio.Nome := EmptyStr;
end;

function TBairroRegra.VerificarExcluir(var AModel: TBairroModel;
  AId: Integer): Boolean;
begin
  Result := AModel.VerificarExcluir(AId);
end;

end.
