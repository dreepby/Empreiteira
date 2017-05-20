inherited frmEstados: TfrmEstados
  Caption = 'Listagem de Estados'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited PageControl1: TPageControl
      inherited tsTabela: TTabSheet
        inherited DBGrid1: TDBGrid
          Columns = <
            item
              Expanded = False
              FieldName = 'idUf'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'UF'
              Width = 86
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Nome'
              Width = 559
              Visible = True
            end>
        end
      end
      inherited tsDados: TTabSheet
        object edtUF: TLabeledEdit
          Left = 203
          Top = 68
          Width = 329
          Height = 27
          CharCase = ecUpperCase
          EditLabel.Width = 13
          EditLabel.Height = 13
          EditLabel.Caption = 'UF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtUFKeyPress
        end
        object edtNome: TLabeledEdit
          Left = 203
          Top = 120
          Width = 329
          Height = 27
          EditLabel.Width = 27
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnKeyPress = edtNomeKeyPress
        end
      end
    end
  end
end
