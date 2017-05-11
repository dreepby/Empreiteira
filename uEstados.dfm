inherited frmEstados: TfrmEstados
  Caption = 'Cadastro de Estado'
  ClientHeight = 216
  ClientWidth = 438
  Font.Height = -12
  FormStyle = fsMDIChild
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
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
      Left = 245
      ExplicitLeft = 245
      inherited btnSalvar: TSpeedButton
        Left = -13
        OnClick = SpeedButton1Click
        ExplicitLeft = -13
      end
    end
    inherited Panel4: TPanel
      Left = 324
      ExplicitLeft = 324
      inherited btnCancelar: TSpeedButton
        Left = -8
        Top = -16
        Width = 104
        OnClick = SpeedButton2Click
        ExplicitLeft = -8
        ExplicitTop = -16
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
      Height = 27
      EditLabel.Width = 32
      EditLabel.Height = 14
      EditLabel.Caption = 'Nome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtNomeKeyPress
    end
    object edtUF: TLabeledEdit
      Left = 48
      Top = 44
      Width = 329
      Height = 27
      CharCase = ecUpperCase
      EditLabel.Width = 14
      EditLabel.Height = 14
      EditLabel.Caption = 'UF'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtUFKeyPress
    end
  end
end
