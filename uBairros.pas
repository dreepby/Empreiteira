unit uBairros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, uBairrosDto, uBairrosControlerInserirAlterar, System.Generics.Collections,uMunicipioDto;

type
  TfrmBairros = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    Label1: TLabel;
    cbMunicipio: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure cbMunicipioKeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    oListaMunicipio: TObjectDictionary<string, TMunicipioDto>;
    oControler: TBairrosControlerInserirAlterar;
  public
    { Public declarations }
    oBairro: TBairrosDto;
  end;

var
  frmBairros: TfrmBairros;

implementation

{$R *.dfm}

procedure TfrmBairros.btnSalvarClick(Sender: TObject);
begin
  inherited;
  oBairro.Nome := Trim(edtNome.Text);
  oBairro.idMunicipio := oListaMunicipio.Items[cbMunicipio.Items[cbMunicipio.ItemIndex]].idMunicipio;
  if (oBairro.Nome <> '') and (cbMunicipio.ItemIndex <> -1) then
  begin
    if oControler.VerificarBairros(oBairro) then
    begin

      if oBairro.idMunicipio > 0 then
      begin
        if oControler.alterar(oBairro) then
          ShowMessage('Registro alterado com sucesso!')
        else
          ShowMessage('Houve algum erro!');
      end
      else
      begin
        if (oControler.Salvar(oBairro)) then
          ShowMessage('Salvo com sucesso!!')
        else
          ShowMessage('Houve algum erro na inserção!!');
        oControler.Limpar(oBairro);
        edtNome.Text := '';
        cbMunicipio.ItemIndex := -1;
        edtNome.SetFocus;
      end;
    end
    else
    begin
      ShowMessage('Bairro Já cadastrado!');
    end;
  end
  else
    ShowMessage('Prencha todos os campos');
end;

procedure TfrmBairros.cbMunicipioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnSalvar.Click;
end;

procedure TfrmBairros.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
    if Key = #13 then
    cbMunicipio.SetFocus;
end;

procedure TfrmBairros.FormActivate(Sender: TObject);
var
  sIndice: String;
begin
  inherited;
  oListaMunicipio.Clear;
  if (oControler.ADDListaHash(oListaMunicipio)) then
  begin
    for sIndice in oListaMunicipio.Keys do
      cbMunicipio.AddItem(sIndice, oListaMunicipio);
  end
  else
    ShowMessage('Nenhum municipio cadastrado!!');
end;

procedure TfrmBairros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if Assigned(oBairro) then
    FreeAndNil(oBairro);

  if (Assigned(oControler)) then
    FreeAndNil(oControler);

  if Assigned(oListaMunicipio) then
  begin
    oListaMunicipio.Clear;
    FreeAndNil(oListaMunicipio);
  end;
  frmBairros := nil;
end;

procedure TfrmBairros.FormCreate(Sender: TObject);
begin
  inherited;
  oBairro := TBairrosDto.Create;
  oControler := TBairrosControlerInserirAlterar.Create;
  oListaMunicipio := TObjectDictionary<string, TMunicipioDto>.Create([doOwnsValues]);
end;

end.
