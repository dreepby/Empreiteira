inherited frmProduto: TfrmProduto
  Caption = 'Produtos'
  ClientWidth = 757
  ExplicitWidth = 763
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 757
    ExplicitWidth = 757
    inherited Label1: TLabel
      Left = 9
      Top = 17
      ExplicitLeft = 9
      ExplicitTop = 17
    end
    inherited edtPesquisa: TEdit
      Left = 67
      Width = 661
      ExplicitLeft = 67
      ExplicitWidth = 661
    end
  end
  inherited Panel2: TPanel
    Width = 757
    ExplicitWidth = 757
    inherited PageControl1: TPageControl
      Width = 747
      ExplicitWidth = 747
      inherited tsTabela: TTabSheet
        ExplicitWidth = 739
        inherited DBGrid1: TDBGrid
          Width = 739
          Columns = <
            item
              Expanded = False
              FieldName = 'idProduto'
              Title.Caption = 'C'#243'digo'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Descricao'
              Title.Caption = 'Descri'#231#227'o'
              Width = 380
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Preco'
              Title.Caption = 'Pre'#231'o'
              Width = 224
              Visible = True
            end>
        end
      end
      inherited tsDados: TTabSheet
        ExplicitWidth = 739
        object Label3: TLabel
          Left = 80
          Top = 3
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
        object Label2: TLabel
          Left = 348
          Top = 105
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
        object clbAmbientes: TCheckListBox
          Left = 80
          Top = 24
          Width = 217
          Height = 204
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ItemHeight = 19
          ParentFont = False
          TabOrder = 0
        end
        object edtDescricao: TLabeledEdit
          Left = 347
          Top = 72
          Width = 289
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
          MaxLength = 20
          ParentFont = False
          TabOrder = 1
          OnKeyPress = edtDescricaoKeyPress
        end
        object edtPreco: TEdit
          Left = 347
          Top = 127
          Width = 289
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnKeyPress = edtPrecoKeyPress
        end
      end
    end
  end
  inherited Panel3: TPanel
    Width = 757
    ExplicitWidth = 757
    inherited Panel4: TPanel
      Left = 2
      ExplicitLeft = 2
    end
  end
end
