object frmListagemBase: TfrmListagemBase
  Left = 0
  Top = 0
  Caption = 'Listagem Base'
  ClientHeight = 385
  ClientWidth = 754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 754
    Height = 57
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 32
      Top = 14
      Width = 63
      Height = 23
      Caption = 'Buscar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 325
    Width = 754
    Height = 60
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 506
    ExplicitWidth = 827
    object Panel4: TPanel
      Left = 326
      Top = 1
      Width = 427
      Height = 58
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 400
      ExplicitTop = 0
      ExplicitHeight = 60
      object btnFechar: TBitBtn
        Left = 298
        Top = 6
        Width = 82
        Height = 43
        Caption = 'Fechar'
        TabOrder = 0
      end
      object frmExcluir: TBitBtn
        Left = 210
        Top = 6
        Width = 82
        Height = 43
        Caption = 'Excluir'
        TabOrder = 1
      end
      object BitBtn1: TBitBtn
        Left = 115
        Top = 6
        Width = 89
        Height = 43
        Caption = 'Alterar'
        TabOrder = 2
      end
      object btnCadastrar: TBitBtn
        Left = 16
        Top = 6
        Width = 93
        Height = 43
        Caption = 'Cadastrar'
        TabOrder = 3
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 57
    Width = 754
    Height = 268
    Align = alClient
    TabOrder = 2
    ExplicitTop = 73
    ExplicitWidth = 827
    ExplicitHeight = 433
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 752
      Height = 266
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
end
