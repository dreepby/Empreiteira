inherited frmMunicipio: TfrmMunicipio
  Caption = 'Listagem de Municipios'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Label1: TLabel
      Left = 25
      Top = 17
      ExplicitLeft = 25
      ExplicitTop = 17
    end
    inherited edtPesquisa: TEdit
      Left = 83
      Width = 655
      ExplicitLeft = 83
      ExplicitWidth = 655
    end
  end
  inherited Panel2: TPanel
    inherited PageControl1: TPageControl
      inherited tsTabela: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 746
        ExplicitHeight = 239
        inherited DBGrid1: TDBGrid
          Columns = <
            item
              Expanded = False
              FieldName = 'idMunicipio'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Nome'
              Width = 145
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'estado'
              Title.Caption = 'Estado'
              Width = 500
              Visible = True
            end>
        end
      end
      inherited tsDados: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 746
        ExplicitHeight = 239
        object Label2: TLabel
          Left = 147
          Top = 103
          Width = 42
          Height = 13
          Caption = 'Estado *'
        end
        object edtNome: TLabeledEdit
          Left = 147
          Top = 68
          Width = 430
          Height = 27
          EditLabel.Width = 36
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 38
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtNomeKeyPress
        end
        object cbEstado: TComboBox
          Left = 147
          Top = 122
          Width = 430
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnKeyPress = cbEstadoKeyPress
        end
      end
    end
  end
  inherited dsTabela: TDataSource
    Left = 721
    Top = 61
  end
end
