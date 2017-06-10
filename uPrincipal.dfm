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
      object Municipios1: TMenuItem
        Action = actMunicipio
      end
      object Bairros1: TMenuItem
        Action = actBairro
      end
      object Clientes1: TMenuItem
        Action = actCliente
      end
      object actAmbiente1: TMenuItem
        Action = actAmbiente
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
    object actMunicipio: TAction
      Caption = 'Municipios'
      OnExecute = actMunicipioExecute
    end
    object actBairro: TAction
      Caption = 'Bairros'
      OnExecute = actBairroExecute
    end
    object actCliente: TAction
      Caption = 'Clientes'
      OnExecute = actClienteExecute
    end
    object actAmbiente: TAction
      Caption = 'Ambiente'
      OnExecute = actAmbienteExecute
    end
  end
end
