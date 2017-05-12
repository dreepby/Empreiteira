unit uMunicipioListagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,System.UITypes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uListagemBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls, uMunicipioControler,
  uMunicipioDto;

type
  TfrmListagemMunicipios = class(TfrmListagemBase)
    edtPesquisa: TEdit;
    btnPesquisa: TButton;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCadastrarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    oController: TMunicipioControler;
    oMunicipio: TMunicipioDto;
  public
    { Public declarations }
  end;

var
  frmListagemMunicipios: TfrmListagemMunicipios;

implementation

{$R *.dfm}

procedure TfrmListagemMunicipios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  oMunicipio.idMunicipio := DBGrid1.Fields[0].AsInteger;
  oMunicipio.Nome := DBGrid1.Fields[1].AsString;
  oMunicipio.nomeUf := DBGrid1.Fields[2].AsString;
  oController.AbrirMunicipioUpdate(oMunicipio);
end;

procedure TfrmListagemMunicipios.btnCadastrarClick(Sender: TObject);
begin
  inherited;
  oController.AbrirMunicipio();
end;

procedure TfrmListagemMunicipios.btnExcluirClick(Sender: TObject);
begin
  inherited;
    if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
  if oController.VerificarExcluir(DBGrid1.Fields[0].AsInteger) then
    begin
      if oController.Excluir(DBGrid1.Fields[0].AsInteger) then
    begin
      ShowMessage('Excluido com sucesso.');
      oController.ListarMunicipios(dsTabela);
    end
    else
      ShowMessage('Houve algum erro!!');
    end
    else
      ShowMessage('Impossível excluir, pois existe um ou mais registros vinculados com esse!');

  end;
end;

procedure TfrmListagemMunicipios.btnFecharClick(Sender: TObject);
begin
  inherited;
  frmListagemMunicipios := nil;
end;

procedure TfrmListagemMunicipios.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  if (Trim(edtPesquisa.Text) <> '') then
  begin
    if (oController.Pesquisar(edtPesquisa.Text) = False) then
      ShowMessage('Nenhum registro correspondente');
  end
  else
    ShowMessage('Campo de pesquisa vazio!');
end;

procedure TfrmListagemMunicipios.edtPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
   if Key = #8 then
  begin
    if Length(Trim(edtPesquisa.Text)) = 1 then
      oController.ListarMunicipios(dsTabela);
  end;

  if Key = #13 then
    btnPesquisa.Click;
end;

procedure TfrmListagemMunicipios.FormActivate(Sender: TObject);
begin
  inherited;
  oController.ListarMunicipios(dsTabela);
end;

procedure TfrmListagemMunicipios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(oMunicipio) then
    FreeAndNil(oMunicipio);

  if Assigned(oController) then
    FreeAndNil(oController);

  frmListagemMunicipios := nil;
end;

procedure TfrmListagemMunicipios.FormCreate(Sender: TObject);
begin
  inherited;
  oMunicipio := TMunicipioDto.Create;
  oController := TMunicipioControler.Create;
  oController.ListarMunicipios(dsTabela);
end;

procedure TfrmListagemMunicipios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   if key = vk_F2 then
    edtPesquisa.SetFocus;
end;

end.
