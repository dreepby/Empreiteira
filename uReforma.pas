unit uReforma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadastroBase, Data.DB, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst;

type
  TfrmReforma = class(TfrmCadastroBase)
    btnDetalhes: TBitBtn;
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
    Label6: TLabel;
    Label7: TLabel;
    moObservacao: TMemo;
    cltAmbientes: TCheckListBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
