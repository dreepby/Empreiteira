inherited frmListagemMunicipios: TfrmListagemMunicipios
  Caption = 'Listagem de Municipios'
  FormStyle = fsMDIChild
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Label1: TLabel
      Width = 151
      Caption = 'Buscar Por Nome:'
      ExplicitWidth = 151
    end
    object edtPesquisa: TEdit
      Left = 195
      Top = 11
      Width = 329
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnPesquisa: TButton
      Left = 562
      Top = 11
      Width = 75
      Height = 31
      Caption = 'Pesquisar'
      TabOrder = 1
    end
  end
end
