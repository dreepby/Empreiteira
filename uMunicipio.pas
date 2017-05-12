unit uMunicipio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Vcl.Buttons,
  Vcl.ExtCtrls,
  Vcl.StdCtrls, uMunicipioDto, System.Generics.Collections, uEstadoDto,
  uMunicipioControlerInserirAlterar;

type
  TfrmMunicipio = class(TfrmCadastroBase)
    Label1: TLabel;
    edtNome: TLabeledEdit;
    cbUf: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
    procedure cbUfKeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    oListaEstados: TObjectDictionary<string, TEstadoDto>;
    oControler: TMunicipioControlerInserirAlterar;
  public
    { Public declarations }
    oMunicipio: TMunicipioDto;

  end;

var
  frmMunicipio: TfrmMunicipio;

implementation

{$R *.dfm}

procedure TfrmMunicipio.btnCancelarClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmMunicipio.btnSalvarClick(Sender: TObject);
begin
  inherited;
  oMunicipio.Nome := Trim(edtNome.Text);
  oMunicipio.idUf := oListaEstados.Items[cbUf.Items[cbUf.ItemIndex]].idUf;
  if (oMunicipio.Nome <> '') and (cbUf.ItemIndex <> -1) then
  begin
    if oControler.VerificarMunicipio(oMunicipio) then
    begin

      if oMunicipio.idMunicipio > 0 then
      begin
        if oControler.alterar(oMunicipio) then
          ShowMessage('Registro alterado com sucesso!')
        else
          ShowMessage('Houve algum erro!');
      end
      else
      begin
        if (oControler.Salvar(oMunicipio)) then
          ShowMessage('Salvo com sucesso!!')
        else
          ShowMessage('Houve algum erro na inserção!!');
        oControler.Limpar(oMunicipio);
        edtNome.Text := '';
        cbUf.ItemIndex := -1;
        edtNome.SetFocus;
      end;
    end
    else
    begin
      ShowMessage('Municipio Já cadastrado!');
    end;
  end
  else
    ShowMessage('Prencha todos os campos');
end;

procedure TfrmMunicipio.cbUfKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnSalvar.Click;
end;

procedure TfrmMunicipio.edtNomeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    cbUf.SetFocus;
end;

procedure TfrmMunicipio.FormActivate(Sender: TObject);
var
  sIndice: String;
begin
  inherited;
  oListaEstados.Clear;
  if (oControler.ADDListaHash(oListaEstados)) then
  begin
    for sIndice in oListaEstados.Keys do
      cbUf.AddItem(sIndice, oListaEstados);
  end
  else
    ShowMessage('Nenhum estado cadastrado!!');
end;

procedure TfrmMunicipio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if Assigned(oMunicipio) then
    FreeAndNil(oMunicipio);

  if (Assigned(oControler)) then
    FreeAndNil(oControler);

  if Assigned(oListaEstados) then
  begin
    oListaEstados.Clear;
    FreeAndNil(oListaEstados);
  end;

  frmMunicipio := nil;
end;

procedure TfrmMunicipio.FormCreate(Sender: TObject);
begin
  inherited;
  oMunicipio := TMunicipioDto.Create;
  oControler := TMunicipioControlerInserirAlterar.Create;
  oListaEstados := TObjectDictionary<string, TEstadoDto>.Create([doOwnsValues]);
end;

end.
