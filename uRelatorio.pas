unit uRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, frxClass, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, frxDBSet, frxChart;

type
  TfrmRelatorio = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    tsFiltros: TTabSheet;
    tsDados: TTabSheet;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox4: TGroupBox;
    rbTodasDatas: TRadioButton;
    rbPeriodosEspecificos: TRadioButton;
    Label1: TLabel;
    Label2: TLabel;
    dtpComeco: TDateTimePicker;
    dtpFim: TDateTimePicker;
    rbTodosClientes: TRadioButton;
    rbEspecifico: TRadioButton;
    edtCpfCnpj: TLabeledEdit;
    btnPesquisarCliente: TBitBtn;
    rbTodosEstados: TRadioButton;
    rbEstadosEspecificos: TRadioButton;
    cbEstado: TComboBox;
    rbTodosMunicipios: TRadioButton;
    rbMunicipiosEspecificos: TRadioButton;
    cbMunicipio: TComboBox;
    frxReport1: TfrxReport;
    dsTabela: TDataSource;
    btnBuscar: TBitBtn;
    btnImprimir: TBitBtn;
    BtnFechar: TBitBtn;
    frxDBDataset1: TfrxDBDataset;
    FDMemTable1: TFDMemTable;
    FDMemTable1idReforma: TIntegerField;
    FDMemTable1Cliente: TStringField;
    FDMemTable1cpfcnpj: TStringField;
    FDMemTable1local: TStringField;
    FDMemTable1datadopedido: TDateField;
    FDMemTable1datadeentrega: TDateField;
    FDMemTable1ambiente: TLargeintField;
    FDMemTable1totaldopedido: TSingleField;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
