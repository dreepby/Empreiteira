unit uEstados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  uEstadoDto, uEstadoController, System.ImageList, Vcl.ImgList;

type
  TfrmEstados = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    edtUF: TLabeledEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtUFExit(Sender: TObject);
  private
    { Private declarations }
    oEstado: TEstadoDto;
    oControlerEstado: TEstadoControler;
  public
    { Public declarations }
  end;

var
  frmEstados: TfrmEstados;

implementation

{$R *.dfm}

procedure TfrmEstados.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if oEstado.IdUF > 0 then
  begin
    If MessageDlg('Você tem certeza que deseja excluir o registro?',
      mtConfirmation, [mbyes, mbno], 0) === mryes then
    begin
      if (oControlerEstado.Excluir(oEstado)) then
        ShowMessage('Excluido com sucesso!!')
      else
        ShowMessage('Houve algum na exclusáo!!');
    end;
  end
  else
    ShowMessage('Nenhum item Selecionado!!');

  oControlerEstado.Limpar(oEstado);
  edtNome.Text := '';
  edtUF.Text := '';
end;

procedure TfrmEstados.btnFecharClick(Sender: TObject);
begin
  inherited;
  frmEstados := nil;
end;

procedure TfrmEstados.btnSalvarClick(Sender: TObject);
begin
  inherited;
  oEstado.UF := edtUF.Text;
  oEstado.Nome := edtNome.Text;
  if (Trim(oEstado.UF) <> '') and (Trim(oEstado.Nome) <> '') then
  begin
    if (oControlerEstado.Salvar(oEstado)) then
      ShowMessage('Salvo com sucesso!!')
    else
      ShowMessage('Houve algum na inserção!!');
    oControlerEstado.Limpar(oEstado);
    edtNome.Text := '';
    edtUF.Text := '';
  end
  else
  ShowMessage('Prencha todos os campos');
end;

procedure TfrmEstados.edtUFExit(Sender: TObject);
begin
  inherited;
  oControlerEstado.Limpar(oEstado);
  oEstado.UF := edtUF.Text;

  if oControlerEstado.Buscar(oEstado) then
    edtNome.Text := oEstado.Nome;
end;

procedure TfrmEstados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oControlerEstado) then
    FreeAndNil(oControlerEstado);

  if Assigned(oEstado) then
    FreeAndNil(oEstado);

  frmEstados := nil;
end;

procedure TfrmEstados.FormCreate(Sender: TObject);
begin
  inherited;
  oEstado := TEstadoDto.Create;
  oControlerEstado := TEstadoControler.Create;

  oControlerEstado.Limpar(oEstado);
end;

end.
