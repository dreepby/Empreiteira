unit uUsuarioControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uMunicipioModel,
  uUsuario, uUsuarioDto, uUsuarioModel, uUsuarioRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows, uInterfaceControler;

type
  TUsuarioControler = class
  public
    procedure AbrirForm;
  end;

implementation

var
  oUsuarioControler: TUsuarioControler;

{ TUsuarioControler }

procedure TUsuarioControler.AbrirForm;
begin
if (not(Assigned(frmUsuario))) then
    frmUsuario := TfrmUsuario.Create(nil);

  frmUsuario.tsDados.Enabled := False;
  frmUsuario.BtnSalvar.Enabled := False;
  frmUsuario.BtnCancelar.Enabled := False;
  frmUsuario.BtnFechar.OnClick := fecharMunicipio;
  frmUsuario.BtnSalvar.OnClick := Salvar;
  frmUsuario.btnInserir.OnClick := Inserir;
  frmUsuario.BtnAlterar.OnClick := Alterar;
  frmUsuario.BtnCancelar.OnClick := Cancelar;
  frmUsuario.btnExcluir.OnClick := Excluir;
  ListarUsuarios;
  frmUsuario.btnPesquisa.OnClick := Pesquisar;
  frmUsuario.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmUsuario.OnKeyDown := OnKeyDownForm;
  frmUsuario.Show;
end;

end.
