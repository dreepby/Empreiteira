inherited frmBairros: TfrmBairros
  Caption = 'Cadastro de Bairro'
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
      ExplicitLeft = 245
      inherited btnSalvar: TSpeedButton
        OnClick = btnSalvarClick
      end
    end
    inherited Panel4: TPanel
      Left = 324
      ExplicitLeft = 324
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
      Width = 43
      Height = 13
      Caption = 'Municipio'
    end
    object edtNome: TLabeledEdit
      Left = 48
      Top = 44
      Width = 329
      Height = 27
      EditLabel.Width = 27
      EditLabel.Height = 13
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
    object cbMunicipio: TComboBox
      Left = 48
      Top = 100
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
      OnKeyPress = cbMunicipioKeyPress
    end
  end
end
