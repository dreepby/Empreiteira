object frmCadastroBase: TfrmCadastroBase
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro Base'
  ClientHeight = 331
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 290
    Width = 515
    Height = 41
    Align = alBottom
    Color = clBtnHighlight
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 280
    ExplicitWidth = 505
    object Panel3: TPanel
      Left = 370
      Top = 6
      Width = 73
      Height = 27
      Caption = 'Salvar'
      Color = 6076508
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object btnSalvar: TSpeedButton
        Left = -8
        Top = -8
        Width = 97
        Height = 41
        Flat = True
        OnMouseEnter = btnSalvarMouseEnter
        OnMouseLeave = btnSalvarMouseLeave
      end
    end
    object Panel4: TPanel
      Left = 292
      Top = 6
      Width = 72
      Height = 27
      Caption = 'Cancelar'
      Color = 5198809
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object btnCancelar: TSpeedButton
        Left = -8
        Top = -8
        Width = 88
        Height = 49
        Flat = True
        OnClick = btnCancelarClick
        OnMouseEnter = btnCancelarMouseEnter
        OnMouseLeave = btnCancelarMouseLeave
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 515
    Height = 290
    Align = alClient
    Color = clBtnHighlight
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 505
    ExplicitHeight = 280
  end
end