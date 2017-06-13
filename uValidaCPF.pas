unit uValidaCPF;

interface

uses
  System.SysUtils;

type
  TValidaCPF = class

  public

    Function ValidarCPF(Acpf: string): Boolean;

    Function tirapontos(texto: String): String;

  end;

implementation

function TValidaCPF.tirapontos(texto: String): String;
begin

  While pos('-', texto) <> 0 Do
    delete(texto, pos('-', texto), 1);

  While pos('.', texto) <> 0 Do
    delete(texto, pos('.', texto), 1);

  Result := texto;
end;

function TValidaCPF.ValidarCPF(Acpf: string): Boolean;
var
  iContador1, iContador2, iSoma, iMultiplicacao: integer;
  iDigito: integer;
  sCPF, sCPFValidado: String;
begin
  sCPF := '00000000000' + trim(Acpf);
  sCPF := copy(sCPF, length(sCPF) - 13, 14);
  sCPF := tirapontos(sCPF);
  sCPFValidado := copy(sCPF, 1, 9);
  for iContador1 := 0 to 1 do
  begin
    iSoma := 0;
    iMultiplicacao := 10 + iContador1;
    for iContador2 := 1 to (9 + iContador1) do
    begin
      iSoma := iSoma + (StrToInt(copy(sCPF, iContador2, 1)) * iMultiplicacao);
      iMultiplicacao := iMultiplicacao - 1;
    end;
    iDigito := iSoma mod 11;
    if iDigito < 2 then
      iDigito := 0
    else
      iDigito := 11 - iDigito;
    sCPFValidado := sCPFValidado + IntToStr(iDigito);
  end;
  Result := sCPF = sCPFValidado;
end;

end.
