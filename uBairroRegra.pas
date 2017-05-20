unit uBairroRegra;

interface

uses
  uBairroDto, System.SysUtils, uEstadoModel;

type
  TBairroRegra = class
  public
    procedure Limpar(ABairro: TBairroDto);

  end;

implementation

{ TBairroRegra }

procedure TBairroRegra.Limpar(ABairro: TBairroDto);
begin
  ABairro.idBairro := 0;
  ABairro.Nome := EmptyStr;
  ABairro.oMunicipio.idMunicipio := 0;
  ABairro.oMunicipio.Nome := EmptyStr;
end;

end.
