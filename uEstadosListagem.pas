unit uEstadosListagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uListagemBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, uEstados,
  uEstadoController, uEstadoDto;

type
  TfrmListagemEstados = class(TfrmListagemBase)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    oController: TEstadoControler;
    oEstado: TEstadoDto;
  public
    { Public declarations }
  end;

var
  frmListagemEstados: TfrmListagemEstados;

implementation

{$R *.dfm}

procedure TfrmListagemEstados.btnAlterarClick(Sender: TObject);
begin
  inherited;
  oEstado.IdUF := DBGrid1.Fields[0].AsInteger;
  oEstado.UF := DBGrid1.Fields[1].AsString;
  oEstado.Nome := DBGrid1.Fields[2].AsString;
  oController.abrirEstadoUpdate(oEstado);
end;

procedure TfrmListagemEstados.btnCadastrarClick(Sender: TObject);
begin
  inherited;
  oController.abrirEstado();
end;

procedure TfrmListagemEstados.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oController.Excluir(DBGrid1.Fields[0].AsInteger) then
    begin
      ShowMessage('Excluido com sucesso.');
      oController.ListarEstados(dsTabela);
    end
    else
      ShowMessage('Jouve algum erro!!');
  end;

end;

procedure TfrmListagemEstados.btnFecharClick(Sender: TObject);
begin
  inherited;
  frmListagemEstados := nil;
end;

procedure TfrmListagemEstados.FormActivate(Sender: TObject);
begin
  inherited;
  oController.ListarEstados(dsTabela);
end;

procedure TfrmListagemEstados.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  if Assigned(oEstado) then
    FreeAndNil(oEstado);

  if Assigned(oController) then
    FreeAndNil(oController);

  frmListagemEstados := nil;
end;

procedure TfrmListagemEstados.FormCreate(Sender: TObject);
begin
  inherited;
  oEstado := TEstadoDto.Create;
  oController := TEstadoControler.Create;
  oController.ListarEstados(dsTabela);
end;

end.
