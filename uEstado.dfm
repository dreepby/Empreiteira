inherited frmEstados: TfrmEstados
  Caption = 'Listagem de Estados'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Label1: TLabel
      Left = 9
      Top = 17
      ExplicitLeft = 9
      ExplicitTop = 17
    end
    inherited edtPesquisa: TEdit
      Left = 63
      Width = 675
      ExplicitLeft = 63
      ExplicitWidth = 675
    end
  end
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
              Title.Caption = 'UF '
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
          Left = 115
          Top = 95
          Width = 37
          Height = 27
          CharCase = ecUpperCase
          EditLabel.Width = 22
          EditLabel.Height = 13
          EditLabel.Caption = 'UF *'
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
          Left = 158
          Top = 95
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
          TabOrder = 1
          OnKeyPress = edtNomeKeyPress
        end
      end
    end
  end
  inherited dsTabela: TDataSource
    Left = 649
    Top = 117
  end
end
