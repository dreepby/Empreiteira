inherited frmListagemEstados: TfrmListagemEstados
  Caption = 'Listagem de Estados'
  FormStyle = fsMDIChild
  Visible = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited Panel4: TPanel
      ExplicitLeft = 326
      ExplicitTop = 1
      inherited pnFechar: TPanel
        inherited btnFechar: TSpeedButton
          OnMouseMove = btnFecharMouseMove
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
      Left = 2
      Align = alNone
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
    Left = 568
    Top = 8
  end
end
