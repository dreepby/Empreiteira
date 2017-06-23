inherited frmProduto: TfrmProduto
  Caption = 'Produtos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited PageControl1: TPageControl
      ActivePage = tsDados
      inherited tsTabela: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 746
        ExplicitHeight = 239
        inherited DBGrid1: TDBGrid
          Columns = <
            item
              Expanded = False
              FieldName = 'idProduto'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Descricao'
              Title.Caption = 'Descri'#231#227'o'
              Width = 564
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Preco'
              Title.Caption = 'Pre'#231'o'
              Width = 79
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
          Left = 264
          Top = 110
          Width = 39
          Height = 19
          Caption = 'Pre'#231'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 488
          Top = 0
          Width = 75
          Height = 19
          Caption = 'Ambientes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object edtDescricao: TLabeledEdit
          Left = 264
          Top = 78
          Width = 217
          Height = 27
          EditLabel.Width = 67
          EditLabel.Height = 19
          EditLabel.Caption = 'Descri'#231#227'o'
          EditLabel.Font.Charset = DEFAULT_CHARSET
          EditLabel.Font.Color = clWindowText
          EditLabel.Font.Height = -16
          EditLabel.Font.Name = 'Tahoma'
          EditLabel.Font.Style = []
          EditLabel.ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object CheckListBox1: TCheckListBox
          Left = 608
          Top = 0
          Width = 135
          Height = 236
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 19
          ParentFont = False
          TabOrder = 2
        end
        object clbAmbientes: TCheckListBox
          Left = 488
          Top = 32
          Width = 255
          Height = 204
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 19
          ParentFont = False
          TabOrder = 3
        end
        object edtPreco: TEdit
          Left = 264
          Top = 134
          Width = 217
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
    end
  end
end
