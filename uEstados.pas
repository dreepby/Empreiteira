unit uEstados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  uEstadoDto, System.ImageList, Vcl.ImgList, uEstadoControlerInserirAlterar;

type
  TfrmEstados = class(TfrmCadastroBase)
    edtNome: TLabeledEdit;
    edtUF: TLabeledEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    oControlerInserirAlterar: TEstadoControlerInserirAlterar;
  public
    { Public declarations }
    oEstado: TEstadoDto;
  end;

var
  frmEstados: TfrmEstados;

implementation

{$R *.dfm}

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
    if (oControlerInserirAlterar.Salvar(oEstado)) then
      ShowMessage('Salvo com sucesso!!')
    else
      ShowMessage('Houve algum na inserção!!');
    oControlerInserirAlterar.Limpar(oEstado);
    edtNome.Text := '';
    edtUF.Text := '';
  end
  else
    ShowMessage('Prencha todos os campos');
end;

procedure TfrmEstados.FormActivate(Sender: TObject);
begin
  inherited;
  edtUF.SetFocus;
end;

procedure TfrmEstados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oControlerInserirAlterar) then
    FreeAndNil(oControlerInserirAlterar);

  if Assigned(oEstado) then
    FreeAndNil(oEstado);

  frmEstados := nil;
end;

procedure TfrmEstados.FormCreate(Sender: TObject);
begin
  inherited;
  oEstado := TEstadoDto.Create;
  oControlerInserirAlterar := TEstadoControlerInserirAlterar.Create;
  oControlerInserirAlterar.Limpar(oEstado);
end;

procedure TfrmEstados.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  oEstado.UF := edtUF.Text;
  oEstado.Nome := edtNome.Text;
  if (Trim(oEstado.UF) <> '') and (Trim(oEstado.Nome) <> '') then
  begin
    if oEstado.IdUF > 0 then
    begin
      if oControlerInserirAlterar.alterar(oEstado) then
        ShowMessage('Registro alterado com sucesso!')
      else
        ShowMessage('Houve algum erro!');
    end
    else
    begin
      if oControlerInserirAlterar.VerificarUF(oEstado.UF) <> True then
      begin
        if (oControlerInserirAlterar.Salvar(oEstado)) then
          ShowMessage('Salvo com sucesso!!')
        else
          ShowMessage('Houve algum na inserção!!');
        oControlerInserirAlterar.Limpar(oEstado);
        edtNome.Text := '';
        edtUF.Text := '';
        edtUF.SetFocus;
      end
      else
        ShowMessage('Estado já cadastrado.');
    end;
  end
  else
    ShowMessage('Prencha todos os campos');
end;

procedure TfrmEstados.SpeedButton2Click(Sender: TObject);
begin
  Close;
  frmEstados := nil;
end;

end.
