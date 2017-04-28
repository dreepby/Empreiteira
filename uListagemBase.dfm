object frmListagemBase: TfrmListagemBase
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
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
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 754
    Height = 57
    Align = alTop
    Color = clWhite
    ParentBackground = False
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
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 360
      Top = 8
      Width = 23
      Height = 22
    end
    object Panel4: TPanel
      Left = 326
      Top = 1
      Width = 427
      Height = 58
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      ExplicitLeft = 294
      ExplicitTop = 17
      object pnAlterar: TPanel
        Left = 103
        Top = 4
        Width = 93
        Height = 43
        Caption = 'Alterar'
        Color = 57825
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object SpeedButton2: TSpeedButton
          Left = -123
          Top = -31
          Width = 117
          Height = 64
          Flat = True
        end
        object btnAlterar: TSpeedButton
          Left = -8
          Top = -23
          Width = 117
          Height = 88
          Flat = True
          OnMouseEnter = btnAlterarMouseEnter
          OnMouseLeave = btnAlterarMouseLeave
        end
      end
      object pnExcluir: TPanel
        Left = 202
        Top = 4
        Width = 93
        Height = 43
        Caption = 'Excluir'
        Color = 5156336
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object SpeedButton3: TSpeedButton
          Left = -123
          Top = -31
          Width = 117
          Height = 64
          Flat = True
        end
        object btnExcluir: TSpeedButton
          Left = -8
          Top = -13
          Width = 117
          Height = 64
          Flat = True
          OnMouseEnter = btnExcluirMouseEnter
          OnMouseLeave = btnExcluirMouseLeave
        end
      end
      object pnFechar: TPanel
        Left = 301
        Top = 4
        Width = 93
        Height = 43
        Caption = 'Fechar'
        Color = 5198809
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindow
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        object SpeedButton4: TSpeedButton
          Left = -123
          Top = -31
          Width = 117
          Height = 64
          Flat = True
        end
        object btnFechar: TSpeedButton
          Left = -8
          Top = -13
          Width = 117
          Height = 64
          Flat = True
          OnClick = btnFecharClick
          OnMouseEnter = btnFecharMouseEnter
          OnMouseLeave = btnFecharMouseLeave
        end
      end
    end
    object pnCadastrar: TPanel
      Left = 330
      Top = 5
      Width = 93
      Height = 43
      Caption = 'Cadastrar'
      Color = 11251232
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object btnCadastrar: TSpeedButton
        Left = -12
        Top = -15
        Width = 117
        Height = 64
        Flat = True
        OnMouseEnter = btnCadastrarMouseEnter
        OnMouseLeave = btnCadastrarMouseLeave
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
  object dsTabela: TDataSource
    Left = 592
    Top = 200
  end
end
