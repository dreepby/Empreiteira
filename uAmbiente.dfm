inherited frmAmbiente: TfrmAmbiente
  Caption = 'Listagem de Ambientes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Label1: TLabel
      Left = 17
      Top = 17
      ExplicitLeft = 17
      ExplicitTop = 17
    end
    inherited edtPesquisa: TEdit
      Left = 75
      Width = 670
      ExplicitLeft = 75
      ExplicitWidth = 670
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
          Left = 112
          Top = 95
          Width = 500
          Height = 27
          EditLabel.Width = 55
          EditLabel.Height = 13
          EditLabel.Caption = 'Descri'#231#227'o *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 40
          ParentFont = False
          TabOrder = 0
          OnKeyPress = edtDescricaoKeyPress
        end
      end
    end
  end
end
