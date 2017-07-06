unit uRelatorioControler;

interface

uses
  System.SysUtils, Data.DB, uRelatorio, Dialogs, System.UITypes,
  System.Generics.Collections, System.Classes,
  Winapi.Windows, uInterfaceControler, uEstadoDto, uEstadoModel,
  uEstadoInterfaceModel, uMunicipioInterfaceModel, uMunicipioModel,
  uMunicipioDto, uListagemClientesController, uClienteInterfaceModel,
  uClienteModel, uClienteDto, uRelatorioModel;

type
  TRelatorioControler = class(TInterfacedObject)
  private
    frmRelatorio: TfrmRelatorio;
    oListaEstados: TObjectDictionary<string, TEstadoDto>;
    oListaMunicipios: TObjectDictionary<string, TMunicipioDto>;
    oControlerListagemClientes: TListagemClientesControler;
    oRelatorioModel: TRelatorioModel;

    procedure fecharForm(Sender: TObject);
    procedure PopularComboBoxEstado;
    procedure rbTodasDatasClick(Sender: TObject);
    procedure rbPeriodosEspecificosClick(Sender: TObject);
    procedure rbTodosClientesClick(Sender: TObject);
    procedure rbEspecificoClick(Sender: TObject);
    procedure rbTodosEstadosClick(Sender: TObject);
    procedure rbEstadosEspecificosClick(Sender: TObject);
    procedure rbTodosMunicipiosClick(Sender: TObject);
    procedure rbMunicipiosEspecificosClick(Sender: TObject);
    procedure PopularComboBoxMunicipio;
    procedure OnSelectCbEstado(Sender: TObject);
    procedure AbrirListagemClientes(Sender: TObject);
    procedure AtualizaCliente(const ACNPJ: String);
    procedure TrazerFormParaFrente;
    procedure OnKeyPressEdtCpfCnpj(Sender: TObject; var Key: Char);
    procedure Buscar(Sender: TObject);
    procedure Imprimir(Sender: TObject);
  public
    procedure abrirForm;

    constructor Create;
    destructor Destroy; override;
  end;

var
  oRelatorioControler: TRelatorioControler;

implementation

{ TEstadoControler }

procedure TRelatorioControler.abrirForm;
begin
  if (not(Assigned(frmRelatorio))) then
  begin
    frmRelatorio := TfrmRelatorio.Create(nil);
    frmRelatorio.BtnFechar.OnClick := fecharForm;

    frmRelatorio.rbTodasDatas.OnClick := rbTodasDatasClick;
    frmRelatorio.rbPeriodosEspecificos.OnClick := rbPeriodosEspecificosClick;
    frmRelatorio.rbTodosClientes.OnClick := rbTodosClientesClick;
    frmRelatorio.rbEspecifico.OnClick := rbEspecificoClick;
    frmRelatorio.rbTodosEstados.OnClick := rbTodosEstadosClick;
    frmRelatorio.rbEstadosEspecificos.OnClick := rbEstadosEspecificosClick;
    frmRelatorio.rbTodosMunicipios.OnClick := rbTodosMunicipiosClick;
    frmRelatorio.rbMunicipiosEspecificos.OnClick :=
      rbMunicipiosEspecificosClick;
    frmRelatorio.cbEstado.OnSelect := OnSelectCbEstado;
    frmRelatorio.btnPesquisarCliente.OnClick := AbrirListagemClientes;
    frmRelatorio.edtCpfCnpj.OnKeyPress := OnKeyPressEdtCpfCnpj;
    frmRelatorio.btnBuscar.OnClick := Buscar;
    frmRelatorio.btnImprimir.OnClick := Imprimir;
    frmRelatorio.Show;
  end
  else
    frmRelatorio.Show;
end;

procedure TRelatorioControler.AbrirListagemClientes(Sender: TObject);
begin
  oControlerListagemClientes.abrirForm(frmRelatorio, AtualizaCliente,
    TrazerFormParaFrente);
end;

procedure TRelatorioControler.AtualizaCliente(const ACNPJ: String);
begin
  if not(ACNPJ = EmptyStr) then
  begin
    frmRelatorio.edtCpfCnpj.Text := ACNPJ;
  end;
end;

procedure TRelatorioControler.Buscar(Sender: TObject);
var
  sWhereSql: String;
  oClienteModel: IModelClienteInterface;
  oClienteDto: TClienteDto;
  iCodigoCliente: Integer;
begin
  oClienteModel := TClienteModel.Create;
  if frmRelatorio.rbPeriodosEspecificos.Checked then
  begin
    if frmRelatorio.dtpFim.Date >= frmRelatorio.dtpComeco.Date then
    begin
      if Length(sWhereSql) <= 0 then
        sWhereSql := ' where r.datadopedido BETWEEN ' +
          QuotedStr(FormatDateTime('yyyy/mm/dd', frmRelatorio.dtpComeco.Date)) +
          ' AND ' + QuotedStr(FormatDateTime('yyyy/mm/dd',
          frmRelatorio.dtpFim.Date));
    end
    else
    begin
      ShowMessage('A data de inicio não pode ser depois da data de termino.');
      exit;
    end;
  end;

  if frmRelatorio.rbEspecifico.Checked then
  begin
    oClienteDto := TClienteDto.Create;
    try
      oClienteDto.CpfCnpj := frmRelatorio.edtCpfCnpj.Text;
      if oClienteModel.VerificarCliente(oClienteDto, iCodigoCliente) then
      begin
        if Length(sWhereSql) <= 0 then
          sWhereSql := ' where c.idCliente = ' + IntToStr(iCodigoCliente)
        else
          sWhereSql := sWhereSql + ' AND c.idCliente = ' +
            IntToStr(iCodigoCliente);
      end
      else
      begin
        if Assigned(oClienteDto) then
          FreeAndNil(oClienteDto);
        ShowMessage('CPF/CNPJ não encontrado.');
        exit;
      end;
    finally
      if Assigned(oClienteDto) then
        FreeAndNil(oClienteDto);
    end;
  end;

  if frmRelatorio.rbEstadosEspecificos.Checked then
  begin
    if frmRelatorio.cbEstado.ItemIndex > -1 then
    begin
      if Length(sWhereSql) <= 0 then
        sWhereSql := ' where u.iduf = ' +
          IntToStr(Integer(frmRelatorio.cbEstado.Items.Objects
          [frmRelatorio.cbEstado.ItemIndex]))
      else
        sWhereSql := sWhereSql + ' AND u.iduf = ' +
          IntToStr(Integer(frmRelatorio.cbEstado.Items.Objects
          [frmRelatorio.cbEstado.ItemIndex]))
    end
    else
    begin
      ShowMessage
        ('Selecione um estado ou então marque a opção "Todos os estados".');
      exit;
    end;
  end;

  if frmRelatorio.rbMunicipiosEspecificos.Checked then
  begin
    if frmRelatorio.cbMunicipio.ItemIndex > -1 then
    begin
      if Length(sWhereSql) <= 0 then
        sWhereSql := ' where m.idMunicipio = ' +
          IntToStr(Integer(frmRelatorio.cbMunicipio.Items.Objects
          [frmRelatorio.cbMunicipio.ItemIndex]))
      else
        sWhereSql := sWhereSql + ' AND m.idMunicipio = ' +
          IntToStr(Integer(frmRelatorio.cbMunicipio.Items.Objects
          [frmRelatorio.cbMunicipio.ItemIndex]))
    end
    else
    begin
      ShowMessage
        ('Selecione um municpio ou então marque a opção "Todos os municpios".');
      exit;
    end;
  end;
  frmRelatorio.FDMemTable1.Close;
  if not(oRelatorioModel.ListarRelatorio(frmRelatorio.dsTabela, sWhereSql, frmRelatorio.FDMemTable1)) then
  begin
    frmRelatorio.PageControl1.TabIndex := 1;
  end
  else
    ShowMessage('Nenhum registro encontrado com esses filtros.');
end;

constructor TRelatorioControler.Create;
begin
  oListaEstados := TObjectDictionary<string, TEstadoDto>.Create([doOwnsValues]);
  oListaMunicipios := TObjectDictionary<string, TMunicipioDto>.Create
    ([doOwnsValues]);
  oControlerListagemClientes := TListagemClientesControler.Create;
  oRelatorioModel := TRelatorioModel.Create;
end;

destructor TRelatorioControler.Destroy;
begin
  if Assigned(frmRelatorio) then
  begin
    frmRelatorio.Close;
    FreeAndNil(frmRelatorio);
  end;

  if Assigned(oListaMunicipios) then
  begin
    oListaMunicipios.Clear;
    FreeAndNil(oListaMunicipios);
  end;

  if Assigned(oListaEstados) then
  begin
    oListaEstados.Clear;
    FreeAndNil(oListaEstados);
  end;

  if Assigned(oControlerListagemClientes) then
    FreeAndNil(oControlerListagemClientes);

  if Assigned(oRelatorioModel) then
    FreeAndNil(oRelatorioModel);
  inherited;
end;

procedure TRelatorioControler.fecharForm(Sender: TObject);
begin
  if (not(Assigned(frmRelatorio))) then
    exit;

  frmRelatorio.Close;
  FreeAndNil(frmRelatorio);
end;

procedure TRelatorioControler.Imprimir(Sender: TObject);
begin
  if not(frmRelatorio.FDMemTable1.IsEmpty) then
    frmRelatorio.frxReport1.ShowReport
  else
    ShowMessage('Nenhum registro filtrado.');
end;

procedure TRelatorioControler.OnKeyPressEdtCpfCnpj(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    if not(Length(Trim(frmRelatorio.edtCpfCnpj.Text)) > 0) then
      frmRelatorio.btnPesquisarCliente.Click;
  end;
end;

procedure TRelatorioControler.OnSelectCbEstado(Sender: TObject);
begin
  if frmRelatorio.cbMunicipio.Enabled then
    PopularComboBoxMunicipio;
end;

procedure TRelatorioControler.PopularComboBoxEstado;
var
  oEstadoModel: IModelEstadoInterface;
  oIndice: TEstadoDto;
begin
  oEstadoModel := TEstadoModel.Create;
  oListaEstados.Clear;
  frmRelatorio.cbEstado.Clear;
  frmRelatorio.cbMunicipio.Clear;
  if (oEstadoModel.ADDListaHash(oListaEstados)) then
  begin
    for oIndice in oListaEstados.Values do
      frmRelatorio.cbEstado.AddItem(oIndice.Nome, TObject(oIndice.IdUF));
  end;
end;

procedure TRelatorioControler.PopularComboBoxMunicipio;
var
  iCodigo: Integer;
  oIndice: TMunicipioDto;
  oMunicipioModel: IModelMunicipioInterface;
begin
  oMunicipioModel := TMunicipioModel.Create;
  oListaMunicipios.Clear;
  frmRelatorio.cbMunicipio.Clear;
  if frmRelatorio.cbEstado.ItemIndex > -1 then
  begin
    iCodigo := Integer(frmRelatorio.cbEstado.Items.Objects
      [frmRelatorio.cbEstado.ItemIndex]);
    frmRelatorio.cbMunicipio.Enabled := True;
    if (oMunicipioModel.ADDListaHash(oListaMunicipios, iCodigo)) then
    begin
      for oIndice in oListaMunicipios.Values do
        frmRelatorio.cbMunicipio.AddItem(oIndice.Nome,
          TObject(oIndice.idMunicipio));
    end;
  end;
end;

procedure TRelatorioControler.rbEspecificoClick(Sender: TObject);
begin
  if frmRelatorio.rbEspecifico.Checked = True then
  begin
    frmRelatorio.edtCpfCnpj.Enabled := True;
    frmRelatorio.btnPesquisarCliente.Enabled := True;
  end;
end;

procedure TRelatorioControler.rbEstadosEspecificosClick(Sender: TObject);
begin
  if frmRelatorio.rbEstadosEspecificos.Checked = True then
  begin
    PopularComboBoxEstado;
    frmRelatorio.cbEstado.Enabled := True;
    frmRelatorio.rbTodosMunicipios.Enabled := True;
    frmRelatorio.rbMunicipiosEspecificos.Enabled := True;
  end;
end;

procedure TRelatorioControler.rbMunicipiosEspecificosClick(Sender: TObject);
begin
  if frmRelatorio.rbMunicipiosEspecificos.Checked = True then
  begin
    PopularComboBoxMunicipio;
    frmRelatorio.cbMunicipio.Enabled := True;
  end;
end;

procedure TRelatorioControler.rbPeriodosEspecificosClick(Sender: TObject);
begin
  if frmRelatorio.rbPeriodosEspecificos.Checked = True then
  begin
    frmRelatorio.dtpComeco.Enabled := True;
    frmRelatorio.dtpFim.Enabled := True;
  end;
end;

procedure TRelatorioControler.rbTodasDatasClick(Sender: TObject);
begin
  if frmRelatorio.rbTodasDatas.Checked = True then
  begin
    frmRelatorio.dtpComeco.Enabled := False;
    frmRelatorio.dtpFim.Enabled := False;
  end;
end;

procedure TRelatorioControler.rbTodosClientesClick(Sender: TObject);
begin
  if frmRelatorio.rbTodosClientes.Checked = True then
  begin
    frmRelatorio.edtCpfCnpj.Enabled := False;
    frmRelatorio.btnPesquisarCliente.Enabled := False;
  end;
end;

procedure TRelatorioControler.rbTodosEstadosClick(Sender: TObject);
begin
  if frmRelatorio.rbTodosEstados.Checked = True then
  begin
    frmRelatorio.rbTodosMunicipios.Checked := True;
    frmRelatorio.rbTodosMunicipios.Enabled := False;
    frmRelatorio.rbMunicipiosEspecificos.Enabled := False;
    frmRelatorio.cbMunicipio.Enabled := False;
    frmRelatorio.cbEstado.Enabled := False;
    frmRelatorio.cbEstado.Clear;
    frmRelatorio.cbMunicipio.Clear;
  end;
end;

procedure TRelatorioControler.rbTodosMunicipiosClick(Sender: TObject);
begin
  if frmRelatorio.rbTodosMunicipios.Checked = True then
  begin
    frmRelatorio.cbMunicipio.Enabled := False;
    frmRelatorio.cbMunicipio.Clear;
  end;
end;

procedure TRelatorioControler.TrazerFormParaFrente;
begin
  frmRelatorio.Enabled := True;
  frmRelatorio.Show;
end;

initialization

finalization

if Assigned(oRelatorioControler) then
  FreeAndNil(oRelatorioControler);

end.
