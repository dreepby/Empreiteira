inherited frmUsuario: TfrmUsuario
  Caption = 'Listagem de Usu'#225'rios'
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
        ExplicitLeft = -5
        ExplicitTop = 16
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
          Top = 120
          Width = 214
          Height = 21
          EditMask = '999.999.999-99;0;_'
          MaxLength = 14
          TabOrder = 1
          Text = ''
        end
      end
    end
  end
end
