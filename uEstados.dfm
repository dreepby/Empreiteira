inherited frmEstados: TfrmEstados
  Caption = 'Cadastro de Estado'
  ClientHeight = 239
  ClientWidth = 411
  Font.Height = -12
  FormStyle = fsMDIChild
  Visible = True
  OnCreate = FormCreate
  ExplicitWidth = 427
  ExplicitHeight = 277
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Top = 198
    Width = 411
    ExplicitTop = 198
    ExplicitWidth = 487
    inherited btnSalvar: TBitBtn
      Left = 207
      OnClick = btnSalvarClick
      ExplicitLeft = 207
    end
    inherited btnFechar: TBitBtn
      Left = 288
      ExplicitLeft = 288
    end
  end
  inherited Panel2: TPanel
    Width = 411
    Height = 198
    ExplicitLeft = -8
    ExplicitTop = -6
    ExplicitWidth = 411
    ExplicitHeight = 198
    object edtNome: TLabeledEdit
      Left = 40
      Top = 120
      Width = 329
      Height = 22
      EditLabel.Width = 36
      EditLabel.Height = 14
      EditLabel.Caption = 'Nome:'
      TabOrder = 0
    end
    object edtUF: TLabeledEdit
      Left = 40
      Top = 56
      Width = 153
      Height = 22
      CharCase = ecUpperCase
      EditLabel.Width = 18
      EditLabel.Height = 14
      EditLabel.Caption = 'UF:'
      TabOrder = 1
      OnExit = edtUFExit
    end
  end
end
