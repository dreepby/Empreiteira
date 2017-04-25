object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Tela Principal'
  ClientHeight = 243
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 232
    Top = 48
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Estados1: TMenuItem
        Action = actEstados
      end
    end
    object Sobre1: TMenuItem
      Caption = 'Sobre'
    end
  end
  object ActionList1: TActionList
    Left = 232
    Top = 112
    object actEstados: TAction
      Caption = 'Estados'
      OnExecute = actEstadosExecute
    end
  end
end
