inherited frmUsuario: TfrmUsuario
  Caption = 'Listagem de Usu'#225'rios'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    object cbPesquisa: TComboBox
      Left = 101
      Top = 14
      Width = 88
      Height = 22
      Style = csOwnerDrawFixed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'Nome'
      Items.Strings = (
        'Nome'
        'CPF')
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
              FieldName = 'idUsuario'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Nome'
              Width = 397
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CPF'
              Width = 331
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
          Left = 259
          Top = 99
          Width = 19
          Height = 13
          Caption = 'CPF'
        end
        object edtNome: TLabeledEdit
          Left = 259
          Top = 56
          Width = 217
          Height = 21
          EditLabel.Width = 27
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome'
          TabOrder = 0
        end
        object edtCPF: TMaskEdit
          Left = 259
          Top = 118
          Width = 208
          Height = 21
          EditMask = '999.999.999-99;1;_'
          MaxLength = 14
          TabOrder = 1
          Text = '   .   .   -  '
        end
      end
    end
  end
end
