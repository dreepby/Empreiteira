unit uReforma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmReforma = class(TfrmCadastroBase)
    btnDetalhes: TBitBtn;
    pageControl2: TPageControl;
    tsPedido: TTabSheet;
    tsProdutos: TTabSheet;
    dsTabelaProduto: TDataSource;
    cltAmbientes: TCheckListBox;
    Label6: TLabel;
    Panel13: TPanel;
    Panel5: TPanel;
    Panel8: TPanel;
    Label9: TLabel;
    Panel9: TPanel;
    dbgProdutos: TDBGrid;
    Label8: TLabel;
    valorPedido: TLabel;
    FDMemTable1: TFDMemTable;
    FDMemTable1Quantidade: TIntegerField;
    FDMemTable1total: TFloatField;
    FDMemTable1observacao: TStringField;
    FDMemTable1precouni: TFloatField;
    FDMemTable1idAmbiente: TIntegerField;
    FDMemTable1Produto: TStringField;
    FDMemTable1idProduto: TIntegerField;
    Label11: TLabel;
    cbProduto: TComboBox;
    edtQuantidade: TLabeledEdit;
    moObservacaoProduto: TMemo;
    Label12: TLabel;
    btnAdicionar: TBitBtn;
    btnCancelarProduto: TBitBtn;
    edtPreco: TLabeledEdit;
    edtTotalProduto: TLabeledEdit;
    Panel6: TPanel;
    Panel7: TPanel;
    Label10: TLabel;
    btnAlterarProdutos: TBitBtn;
    btnExcluirProdutos: TBitBtn;
    edtTotal: TEdit;
    edtCpfCnpj: TLabeledEdit;
    btnPesquisarCliente: TBitBtn;
    dtpPedido: TDateTimePicker;
    Label2: TLabel;
    dtpEntrega: TDateTimePicker;
    Label3: TLabel;
    cbAtendente: TComboBox;
    Label4: TLabel;
    cbUsuario: TComboBox;
    Label5: TLabel;
    moObservacao: TMemo;
    Label7: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
