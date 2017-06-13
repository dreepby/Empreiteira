inherited frmAmbiente: TfrmAmbiente
  Caption = 'Listagem de Ambientes'
  PixelsPerInch = 96
  TextHeight = 13
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
              FieldName = 'idAmbientes'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Descricao'
              Title.Caption = 'Descri'#231#227'o'
              Width = 643
              Visible = True
            end>
        end
      end
      inherited tsDados: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 746
        ExplicitHeight = 239
        object edtDescricao: TLabeledEdit
          Left = 211
          Top = 95
          Width = 329
          Height = 27
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Descri'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
end
