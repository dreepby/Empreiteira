inherited frmProduto: TfrmProduto
  Caption = 'Produtos'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited PageControl1: TPageControl
      inherited tsDados: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 746
        ExplicitHeight = 239
        object Label2: TLabel
          Left = 150
          Top = 111
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
        object edtDescricao: TLabeledEdit
          Left = 149
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
          TabOrder = 1
        end
        object edtPreco: TMaskEdit
          Left = 150
          Top = 131
          Width = 216
          Height = 27
          EditMask = '999.999,99;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 2
          Text = '   .   ,  '
        end
        object CheckListBox2: TCheckListBox
          Left = 488
          Top = 3
          Width = 255
          Height = 233
          ItemHeight = 13
          TabOrder = 3
        end
      end
    end
  end
end
