inherited frmEstados: TfrmEstados
  Caption = 'Cadastro de Estado'
  ClientHeight = 216
  ClientWidth = 438
  Font.Height = -12
  FormStyle = fsMDIChild
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  ExplicitWidth = 444
  ExplicitHeight = 244
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Top = 175
    Width = 438
    ExplicitTop = 175
    ExplicitWidth = 438
    inherited Panel3: TPanel
      Left = 338
      ExplicitLeft = 338
      inherited btnSalvar: TSpeedButton
        Left = -16
        OnClick = SpeedButton1Click
        ExplicitLeft = -16
      end
    end
    inherited Panel4: TPanel
      Left = 260
      ExplicitLeft = 260
      inherited btnCancelar: TSpeedButton
        Left = -16
        Width = 104
        OnClick = SpeedButton2Click
        ExplicitLeft = -16
        ExplicitWidth = 104
      end
    end
  end
  inherited Panel2: TPanel
    Width = 438
    Height = 175
    ExplicitWidth = 438
    ExplicitHeight = 175
    object edtNome: TLabeledEdit
      Left = 48
      Top = 96
      Width = 329
      Height = 31
      EditLabel.Width = 32
      EditLabel.Height = 14
      EditLabel.Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TextHint = '   Nome'
    end
    object edtUF: TLabeledEdit
      Left = 48
      Top = 44
      Width = 329
      Height = 31
      CharCase = ecUpperCase
      EditLabel.Width = 14
      EditLabel.Height = 14
      EditLabel.Caption = 'UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      TextHint = '   UF'
      OnExit = edtUFExit
    end
  end
end
