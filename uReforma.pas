unit uReforma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst;

type
  TfrmReforma = class(TfrmCadastroBase)
    btnDetalhes: TBitBtn;
    pageControl2: TPageControl;
    tsPedido: TTabSheet;
    tsProdutos: TTabSheet;
    dtpPedido: TDateTimePicker;
    Label2: TLabel;
    dtpEntrega: TDateTimePicker;
    Label3: TLabel;
    edtCpfCnpj: TLabeledEdit;
    btnPesquisarCliente: TBitBtn;
    cbAtedente: TComboBox;
    Label4: TLabel;
    cbUsuario: TComboBox;
    Label5: TLabel;
    moObservacao: TMemo;
    Label7: TLabel;
    dsTabelaProduto: TDataSource;
    cltAmbientes: TCheckListBox;
    Label6: TLabel;
    Panel13: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    cbProduto: TComboBox;
    edtPreco: TLabeledEdit;
    moObservacaoProduto: TMemo;
    edtQuantidade: TLabeledEdit;
    edtTotalProduto: TLabeledEdit;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Label10: TLabel;
    edtTotal: TEdit;
    btnAlterarProdutos: TBitBtn;
    btnExcluirProdutos: TBitBtn;
    Panel8: TPanel;
    Label9: TLabel;
    Panel9: TPanel;
    dbgProdutos: TDBGrid;
    btnAdicionar: TBitBtn;
    Label8: TLabel;
    valorPedido: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
