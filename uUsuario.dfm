inherited frmUsuario: TfrmUsuario
  Caption = 'Listagem de Usu'#225'rios'
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
        object edtNome: TLabeledEdit
          Left = 312
          Top = 80
          Width = 217
          Height = 21
          EditLabel.Width = 27
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome'
          TabOrder = 0
        end
        object edtCPF: TLabeledEdit
          Left = 312
          Top = 128
          Width = 217
          Height = 21
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.Caption = 'CPF'
          TabOrder = 1
        end
      end
    end
  end
end
