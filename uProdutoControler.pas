unit uProdutoControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uProdutoDto,
  uProdutoModel, uProduto, uProdutoRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows,
  uInterfaceControler, uProdutoInterfaceModel;

type
  TProdutoControler = class(TInterfacedObject, IControlerInterface)

  private
    oProdutoModel: IModelProdutoInterface;
    oProdutoDto: TProdutoDto;
    oProdutoRegra: TProdutoRegra;
    oListaProdutos: TObjectDictionary<string, TProdutoDto>;

    procedure Excluir(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure ListarProdutos;
    procedure Alterar(Sender: TObject);
    procedure fecharProduto(Sender: TObject);
    procedure Pesquisar(Sender: TObject);
    procedure OnKeyPressEdtPesquisa(Sender: TObject; var Key: Char);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    procedure abrirForm;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TProdutoControler }

procedure TProdutoControler.abrirForm;
begin
  if (not(Assigned(frmProduto))) then
    frmProduto := TfrmProduto.Create(nil);

  frmProduto.tsDados.Enabled := False;
  frmProduto.BtnSalvar.Enabled := False;
  frmProduto.BtnCancelar.Enabled := False;
  frmProduto.BtnFechar.OnClick := fecharProduto;
  frmProduto.BtnSalvar.OnClick := Salvar;
  frmProduto.btnInserir.OnClick := Inserir;
  frmProduto.BtnAlterar.OnClick := Alterar;
  frmProduto.BtnCancelar.OnClick := Cancelar;
  frmProduto.btnExcluir.OnClick := Excluir;
  ListarProdutos;
  frmProduto.btnPesquisa.OnClick := Pesquisar;
  frmProduto.edtPesquisa.OnKeyPress := OnKeyPressEdtPesquisa;
  frmProduto.OnKeyDown := OnKeyDownForm;
  frmProduto.Show;
end;

procedure TProdutoControler.Alterar(Sender: TObject);
begin
  oProdutoDto.idProduto := frmProduto.DBGrid1.Fields[0].AsInteger;

  frmProduto.tsDados.Enabled := True;
  frmProduto.Caption := 'Alteração de Produto';
  frmProduto.edtDescricao.Text := frmProduto.DBGrid1.Fields[1].AsString;
  frmProduto.PageControl1.ActivePage := frmProduto.tsDados;
  frmProduto.tsTabela.Enabled := False;
  frmProduto.btnInserir.Enabled := False;
  frmProduto.BtnAlterar.Enabled := False;
  frmProduto.btnExcluir.Enabled := False;
  frmProduto.BtnSalvar.Enabled := True;
  frmProduto.BtnCancelar.Enabled := True;
end;

procedure TProdutoControler.Cancelar(Sender: TObject);
begin

end;

constructor TProdutoControler.Create;
begin

end;

destructor TProdutoControler.Destroy;
begin
   if Assigned(oProdutoRegra) then
    FreeAndNil(oProdutoRegra);

  if Assigned(oListaProdutos) then
  begin
    oListaProdutos.Clear;
    FreeAndNil(oListaProdutos);
  end;

  if Assigned(oProdutoDto) then
    FreeAndNil(oProdutoDto);

  if Assigned(frmProduto) then
  begin
    frmProduto.Close;
    FreeAndNil(frmProduto);
  end;
  inherited;
end;

procedure TProdutoControler.Excluir(Sender: TObject);
begin
 if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oProdutoRegra.VerificarExcluir(oProdutoModel,
      frmProduto.DBGrid1.Fields[0].AsInteger) then
    begin
      if oProdutoRegra.Deletar(oProdutoModel,
        frmProduto.DBGrid1.Fields[0].AsInteger) then
      begin
        ShowMessage('Excluido com sucesso.');
        ListarProdutos;
      end
      else
        ShowMessage('Houve algum erro!!');
    end
    else
      ShowMessage
        ('Impossível excluir, pois existe um ou mais registros vinculados com esse!');
  end;
end;

procedure TProdutoControler.fecharProduto(Sender: TObject);
begin

end;

procedure TProdutoControler.Inserir(Sender: TObject);
begin

end;

procedure TProdutoControler.ListarProdutos;
begin
  oProdutoModel.ListarProdutos(frmProduto.dsTabela);
end;

procedure TProdutoControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TProdutoControler.OnKeyPressEdtPesquisa(Sender: TObject;
  var Key: Char);
begin

end;

procedure TProdutoControler.Pesquisar(Sender: TObject);
begin

end;

procedure TProdutoControler.Salvar(Sender: TObject);
begin
   oProdutoDto.Descricao := frmProduto.edtDescricao.Text;
  if (oProdutoDto.Descricao <> EmptyStr) and (oProdutoDto.Preco > 0) then
  begin
    try
      if (oProdutoRegra.Salvar(oProdutoModel, oProdutoDto)) then
      begin
        ShowMessage('Salvo com sucesso');
        oProdutoRegra.Limpar(oProdutoDto);
        frmProduto.edtDescricao.Text := EmptyStr;
        frmProduto.PageControl1.ActivePage := frmProduto.tsTabela;
        frmProduto.tsTabela.Enabled := True;
        frmProduto.btnInserir.Enabled := True;
        frmProduto.BtnAlterar.Enabled := True;
        frmProduto.btnExcluir.Enabled := True;
        frmProduto.BtnSalvar.Enabled := False;
        frmProduto.BtnCancelar.Enabled := False;
        frmProduto.Caption := 'Listagem de Produtos';
        ListarProdutos;
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);

    end
  end
  else
    ShowMessage('Prencha o campo Descrição.');

end;

end.
