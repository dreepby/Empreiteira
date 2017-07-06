unit uProdutoControler;

interface

uses
  System.SysUtils, Data.DB, System.Generics.Collections, uProdutoDto,
  uProdutoModel, uProduto, uProdutoRegra,
  Dialogs, System.UITypes, System.Classes, Winapi.Windows,
  uInterfaceControler, uProdutoInterfaceModel, uAmbienteModel, uAmbienteDto,
  uProdutoAmbienteInterfaceModel, uAmbienteInterfaceModel,
  uProdutoAmbienteModel, uArrayAmbientes;

type

  TProdutoControler = class(TInterfacedObject, IControlerInterface)

  private

    oProdutoModel: IModelProdutoInterface;
    oProdutoDto: TProdutoDto;
    oProdutoRegra: TProdutoRegra;
    oProdutoAmbienteModel: IModelProdutoAmbienteInterface;

    oListaAmbientes: TObjectDictionary<string, TAmbienteDto>;

    procedure Excluir(Sender: TObject);
    procedure Salvar(Sender: TObject);
    procedure Inserir(Sender: TObject);
    procedure Cancelar(Sender: TObject);
    procedure ListarProdutos;
    procedure Alterar(Sender: TObject);
    procedure fecharProduto(Sender: TObject);
    procedure OnChangeEdtPesquisa(Sender: TObject);
    procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure popularCheckListBox;
    procedure onExitEdtNome(Sender: TObject);
    procedure AtualizarDadosCadastro;
  public
    procedure abrirForm;

    constructor Create;
    destructor Destroy; override;
  end;

var
  oProdutoControler: TProdutoControler;

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
  frmProduto.edtDescricao.OnExit := onExitEdtNome;
  frmProduto.edtPesquisa.OnChange := OnChangeEdtPesquisa;
  ListarProdutos;
  frmProduto.OnKeyDown := OnKeyDownForm;
  frmProduto.Show;
end;

procedure TProdutoControler.Alterar(Sender: TObject);
var
  aCodigosAmbientes: TAmbientesReformaArray;
  i: integer;
begin
  popularCheckListBox;
  oProdutoDto.idProduto := frmProduto.DBGrid1.Fields[0].AsInteger;

  if oProdutoRegra.BuscarProduto(oProdutoModel, oProdutoDto) then
  begin
    frmProduto.edtPesquisa.Enabled := False;
    frmProduto.tsDados.Enabled := True;
    frmProduto.Caption := 'Alteração de Produto';
    frmProduto.PageControl1.ActivePage := frmProduto.tsDados;
    frmProduto.tsTabela.Enabled := False;
    frmProduto.btnInserir.Enabled := False;
    frmProduto.BtnAlterar.Enabled := False;
    frmProduto.btnExcluir.Enabled := False;
    frmProduto.BtnSalvar.Enabled := True;
    frmProduto.BtnCancelar.Enabled := True;
    frmProduto.edtDescricao.Text := oProdutoDto.Descricao;
    frmProduto.edtPreco.Text := (oProdutoDto.Preco);
    oProdutoAmbienteModel.BuscarAmbientes(oProdutoDto.idProduto,
      aCodigosAmbientes);

    for i := 0 to (Length(aCodigosAmbientes) - 1) do
      frmProduto.clbAmbientes.Checked
        [frmProduto.clbAmbientes.Items.IndexOfObject
        (TObject(aCodigosAmbientes[i]))] := True;
  end
  else
    ShowMessage('Nenhum registro encontrado');

end;

procedure TProdutoControler.AtualizarDadosCadastro;
begin

end;

procedure TProdutoControler.Cancelar(Sender: TObject);
begin
  frmProduto.edtPesquisa.Enabled := True;
  frmProduto.tsTabela.Enabled := True;
  frmProduto.PageControl1.ActivePage := frmProduto.tsTabela;
  frmProduto.tsDados.Enabled := False;
  frmProduto.btnInserir.Enabled := True;
  frmProduto.BtnAlterar.Enabled := True;
  frmProduto.btnExcluir.Enabled := True;
  frmProduto.BtnSalvar.Enabled := False;
  frmProduto.BtnCancelar.Enabled := False;
  frmProduto.edtDescricao.Text := EmptyStr;
  frmProduto.edtPreco.Text := EmptyStr;
  frmProduto.clbAmbientes.Clear;
  frmProduto.Caption := 'Listagem de Produtos';
  oProdutoRegra.Limpar(oProdutoDto);
  ListarProdutos;
end;

constructor TProdutoControler.Create;
begin
  oProdutoModel := TProdutoModel.Create;
  oProdutoRegra := TProdutoRegra.Create;
  oProdutoDto := TProdutoDto.Create;
  oListaAmbientes := TObjectDictionary<string, TAmbienteDto>.Create
    ([doOwnsValues]);
  oProdutoAmbienteModel := TProdutoAmbienteModel.Create;
end;

destructor TProdutoControler.Destroy;
begin
  if Assigned(oProdutoDto) then
    FreeAndNil(oProdutoDto);

  if Assigned(oProdutoRegra) then
    FreeAndNil(oProdutoRegra);

  if (Assigned(frmProduto)) then
  begin
    frmProduto.Close;
    FreeAndNil(frmProduto);
  end;

  if Assigned(oListaAmbientes) then
  begin
    oListaAmbientes.Clear;
    FreeAndNil(oListaAmbientes);
  end;
  inherited;
end;

procedure TProdutoControler.Excluir(Sender: TObject);
begin
  if MessageDlg('Você deseja realmente excluir o registro?', mtinformation,
    [mbyes, mbno], 0) = mryes then
  begin
    if oProdutoModel.VerificarExcluir(frmProduto.DBGrid1.Fields[0].AsInteger)
    then
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
        ('Impossível excluir, pois existe uma ou mais reformas vinculadas com esse produto!');
  end;
end;

procedure TProdutoControler.fecharProduto(Sender: TObject);
begin
  if (not(Assigned(frmProduto))) then
    exit;

  oProdutoRegra.Limpar(oProdutoDto);
  frmProduto.Close;
  FreeAndNil(frmProduto);
end;

procedure TProdutoControler.Inserir(Sender: TObject);
begin
  popularCheckListBox;
  frmProduto.edtPesquisa.Enabled := False;
  frmProduto.tsDados.Enabled := True;
  frmProduto.Caption := 'Cadastro de Produto';
  frmProduto.PageControl1.ActivePage := frmProduto.tsDados;
  frmProduto.tsTabela.Enabled := False;
  frmProduto.btnInserir.Enabled := False;
  frmProduto.BtnAlterar.Enabled := False;
  frmProduto.btnExcluir.Enabled := False;
  frmProduto.BtnSalvar.Enabled := True;
  frmProduto.BtnCancelar.Enabled := True;
  frmProduto.edtDescricao.SetFocus;
end;

procedure TProdutoControler.ListarProdutos;
begin
  if oProdutoModel.ListarProdutos(frmProduto.dsTabela) then
  begin
    frmProduto.BtnAlterar.Enabled := False;
    frmProduto.btnExcluir.Enabled := False;
  end
  else
  begin
    frmProduto.BtnAlterar.Enabled := True;
    frmProduto.btnExcluir.Enabled := True;
  end;
end;

procedure TProdutoControler.OnChangeEdtPesquisa(Sender: TObject);
begin
  if oProdutoModel.Localizar(frmProduto.edtPesquisa.Text) then
  begin
    frmProduto.btnExcluir.Enabled := False;
    frmProduto.BtnAlterar.Enabled := False;
  end
  else
  begin
    frmProduto.btnExcluir.Enabled := True;
    frmProduto.BtnAlterar.Enabled := True;
  end;
end;

procedure TProdutoControler.onExitEdtNome(Sender: TObject);
begin
  if oProdutoDto.idProduto <> 0 then
  begin
    if not(oProdutoModel.VerificarNome(frmProduto.edtDescricao.Text)) then
      raise Exception.Create('Já existe um produto com este nome!');
  end;
end;

procedure TProdutoControler.OnKeyDownForm(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if frmProduto.edtPesquisa.Enabled then
  begin
    if Key = VK_F2 then
      frmProduto.edtPesquisa.SetFocus;

    if Key = VK_F5 then
      ListarProdutos;
  end
  else
    AtualizarDadosCadastro;
end;

procedure TProdutoControler.popularCheckListBox;
var
  oAmbienteModel: IModelAmbienteInterface;
  oIndice: TAmbienteDto;
begin
  oAmbienteModel := TAmbienteModel.Create;
  oListaAmbientes.Clear;
  frmProduto.clbAmbientes.Clear;
  if (oAmbienteModel.ADDListaHash(oListaAmbientes)) then
  begin
    for oIndice in oListaAmbientes.Values do
      frmProduto.clbAmbientes.AddItem(oIndice.Descricao,
        TObject(oIndice.idAmbiente));
  end;

end;

procedure TProdutoControler.Salvar(Sender: TObject);
var
  sTeste: String;
  i, iCount, iCountArray: integer;
  AmbientesReforma: TAmbientesReformaArray;
begin
  iCount := frmProduto.clbAmbientes.Items.count - 1;
  iCountArray := 0;
  SetLength(AmbientesReforma, 0);
  for i := 0 to iCount do
  begin
    if frmProduto.clbAmbientes.Checked[i] = True then
    begin
      sTeste := sTeste + frmProduto.clbAmbientes.Items[i];
      SetLength(AmbientesReforma, iCountArray + 1);
      AmbientesReforma[iCountArray] := oListaAmbientes.Items
        [frmProduto.clbAmbientes.Items[i]].idAmbiente;
      iCountArray := iCountArray + 1;
    end;
  end;
  if Length(AmbientesReforma) > 0 then
  begin
    if frmProduto.edtPreco.Text <> EmptyStr then
    begin
      oProdutoDto.Descricao := frmProduto.edtDescricao.Text;
      oProdutoDto.Preco := StringReplace((frmProduto.edtPreco.Text), ',', '.',
        [rfReplaceAll]);
      if (frmProduto.edtDescricao.Text <> EmptyStr) then
      begin
        try
          if not(StrToCurr(frmProduto.edtPreco.Text) <= 0) then
          begin
            try
              if (oProdutoRegra.Salvar(oProdutoModel, oProdutoAmbienteModel,
                oProdutoDto, AmbientesReforma)) then
              begin
                frmProduto.edtDescricao.Text := EmptyStr;
                frmProduto.edtPreco.Text := EmptyStr;
                oProdutoRegra.Limpar(oProdutoDto);
                popularCheckListBox;
                ShowMessage('Salvo com sucesso');
              end;
            except
              on E: Exception do
                ShowMessage(E.Message);
            end
          end
        except
          ShowMessage('Insira um valor válido.')
        end
      end
      else
        ShowMessage('Prencha o campo preço.');
    end
    else
      ShowMessage('Prencha o campo preço.');
  end
  else
    ShowMessage('Selecione ao menos um ambiente.');
end;

initialization

finalization

if Assigned(oProdutoControler) then
  FreeAndNil(oProdutoControler);

end.
