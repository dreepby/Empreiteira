inherited frmListagemMunicipios: TfrmListagemMunicipios
  Caption = 'Listagem de Municipios'
  FormStyle = fsMDIChild
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
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
      OnKeyPress = edtPesquisaKeyPress
    end
    object btnPesquisa: TButton
      Left = 562
      Top = 11
      Width = 75
      Height = 31
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = btnPesquisaClick
    end
  end
  inherited Panel2: TPanel
    inherited Panel4: TPanel
      inherited pnAlterar: TPanel
        inherited btnAlterar: TSpeedButton
          OnClick = btnAlterarClick
        end
      end
      inherited pnExcluir: TPanel
        inherited btnExcluir: TSpeedButton
          OnClick = btnExcluirClick
        end
      end
    end
    inherited pnCadastrar: TPanel
      inherited btnCadastrar: TSpeedButton
        OnClick = btnCadastrarClick
      end
    end
  end
  inherited Panel3: TPanel
    inherited DBGrid1: TDBGrid
      DataSource = dsTabela
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      Columns = <
        item
          Expanded = False
          FieldName = 'idMunicipio'
          Title.Caption = 'C'#243'digo'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 262
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'estado'
          Title.Caption = 'Estado'
          Width = 397
          Visible = True
        end>
    end
  end
end