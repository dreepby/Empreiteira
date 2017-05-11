object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Tela Principal'
  ClientHeight = 492
  ClientWidth = 812
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 232
    Top = 48
    object Listagem1: TMenuItem
      Caption = 'Listagem'
      object Estados2: TMenuItem
        Action = actListagemEstado
      end
      object Municipio1: TMenuItem
        Action = actListagemMunicipio
      end
    end
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object Estados1: TMenuItem
        Action = actEstados
      end
      object Municipios1: TMenuItem
        Action = actMunicipio
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
    object actListagemEstado: TAction
      Caption = 'Estados'
      OnExecute = actListagemEstadoExecute
    end
    object actListagemMunicipio: TAction
      Caption = 'Municipio'
      OnExecute = actListagemMunicipioExecute
    end
    object actMunicipio: TAction
      Caption = 'Municipios'
      OnExecute = actMunicipioExecute
    end
  end
end
