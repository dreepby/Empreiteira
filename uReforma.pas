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
    edtCpf: TLabeledEdit;
    btnPesquisarCpf: TBitBtn;
    edtCnpj: TLabeledEdit;
    btnPesquisarCnpj: TBitBtn;
    cbAtedente: TComboBox;
    Label4: TLabel;
    cbUsuario: TComboBox;
    Label5: TLabel;
    moObservacao: TMemo;
    Label7: TLabel;
    cltAmbientes: TCheckListBox;
    Label6: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Label10: TLabel;
    edtTotal: TEdit;
    Panel8: TPanel;
    Label9: TLabel;
    Panel9: TPanel;
    dbgProdutos: TDBGrid;
    Panel10: TPanel;
    Panel11: TPanel;
    Label8: TLabel;
    cbAmbiente: TComboBox;
    Panel12: TPanel;
    Panel13: TPanel;
    btnAdicionarProduto: TBitBtn;
    cbProduto: TComboBox;
    Label11: TLabel;
    edtPreco: TLabeledEdit;
    moObservacaoProduto: TMemo;
    edtQuantidade: TLabeledEdit;
    Label12: TLabel;
    btnAlterarProdutos: TBitBtn;
    btnExcluirProdutos: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    dsTabelaProduto: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
