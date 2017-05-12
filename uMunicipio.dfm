inherited frmMunicipio: TfrmMunicipio
  Caption = 'Cadastro de Municipios'
  ClientHeight = 216
  ClientWidth = 444
  FormStyle = fsMDIChild
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  ExplicitWidth = 450
  ExplicitHeight = 244
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 175
    Width = 444
    ExplicitTop = 175
    ExplicitWidth = 444
    inherited Panel3: TPanel
      Left = 245
      Width = 72
      Height = 26
      ExplicitLeft = 245
      ExplicitWidth = 72
      ExplicitHeight = 26
      inherited btnSalvar: TSpeedButton
        Left = -13
        Top = -10
        OnClick = btnSalvarClick
        ExplicitLeft = -13
        ExplicitTop = -10
      end
    end
    inherited Panel4: TPanel
      Left = 324
      Top = 5
      ExplicitLeft = 324
      ExplicitTop = 5
      inherited btnCancelar: TSpeedButton
        Left = -11
        Top = -16
        ExplicitLeft = -11
        ExplicitTop = -16
      end
    end
  end
  inherited Panel2: TPanel
    Width = 444
    Height = 175
    ExplicitWidth = 444
    ExplicitHeight = 175
    object Label1: TLabel
      Left = 48
      Top = 81
      Width = 33
      Height = 13
      Caption = 'Estado'
    end
    object edtNome: TLabeledEdit
      Left = 48
      Top = 44
      Width = 329
      Height = 27
      EditLabel.Width = 32
      EditLabel.Height = 14
      EditLabel.Caption = 'Nome'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -12
      EditLabel.Font.Name = 'Tahoma'
      EditLabel.Font.Style = []
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtNomeKeyPress
    end
    object cbUf: TComboBox
      Left = 48
      Top = 96
      Width = 329
      Height = 27
      AutoDropDown = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyPress = cbUfKeyPress
    end
  end
end
