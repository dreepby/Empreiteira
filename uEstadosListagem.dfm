inherited frmListagemEstados: TfrmListagemEstados
  Caption = 'Listagem de Estados'
  FormStyle = fsMDIChild
  Visible = True
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Label1: TLabel
      Width = 157
      Caption = 'Buscar Por Nome :'
      ExplicitWidth = 157
    end
    object btnPesquisa: TButton
      Left = 562
      Top = 15
      Width = 75
      Height = 36
      Caption = 'Pesquisar'
      TabOrder = 0
      OnClick = btnPesquisaClick
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
      TabOrder = 1
      OnKeyPress = edtPesquisaKeyPress
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
        Left = -24
        OnClick = btnCadastrarClick
        ExplicitLeft = -24
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
          FieldName = 'idUF'
          Title.Caption = 'C'#243'digo'
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'UF'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 358
          Visible = True
        end>
    end
  end
  inherited dsTabela: TDataSource
    Left = 8
    Top = 8
  end
end
