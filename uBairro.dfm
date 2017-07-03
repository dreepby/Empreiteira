inherited frmBairro: TfrmBairro
  Caption = 'Listagem de Bairros'
  ClientWidth = 762
  ExplicitWidth = 768
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 762
    ExplicitWidth = 762
    inherited Label1: TLabel
      Left = 21
      Top = 17
      ExplicitLeft = 21
      ExplicitTop = 17
    end
    inherited edtPesquisa: TEdit
      Left = 79
      Width = 664
      ExplicitLeft = 79
      ExplicitWidth = 664
    end
  end
  inherited Panel2: TPanel
    Width = 762
    ExplicitWidth = 762
    inherited PageControl1: TPageControl
      Width = 752
      ExplicitWidth = 752
      inherited tsTabela: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 744
        ExplicitHeight = 239
        inherited DBGrid1: TDBGrid
          Width = 744
          Columns = <
            item
              Expanded = False
              FieldName = 'idBairro'
              Title.Caption = 'C'#243'digo'
              Width = 46
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nome'
              Title.Caption = 'Nome'
              Width = 212
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nomeMunicipio'
              Title.Caption = 'Municipio'
              Width = 241
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'nomeEstado'
              Title.Caption = 'Estado'
              Width = 204
              Visible = True
            end>
        end
      end
      inherited tsDados: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 744
        ExplicitHeight = 239
        object Label2: TLabel
          Left = 131
          Top = 131
          Width = 52
          Height = 13
          Caption = 'Municipio *'
        end
        object Label3: TLabel
          Left = 131
          Top = 79
          Width = 42
          Height = 13
          Caption = 'Estado *'
        end
        object edtNome: TLabeledEdit
          Left = 131
          Top = 46
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
          TabOrder = 0
          OnKeyPress = edtNomeKeyPress
        end
        object cbMunicipio: TComboBox
          Left = 131
          Top = 150
          Width = 430
          Height = 27
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 2
          OnKeyPress = cbMunicipioKeyPress
        end
        object cbEstado: TComboBox
          Left = 131
          Top = 98
          Width = 430
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 1
          OnKeyPress = cbEstadoKeyPress
        end
      end
    end
  end
  inherited Panel3: TPanel
    Width = 762
    ExplicitWidth = 762
    inherited Panel4: TPanel
      Left = 7
      ExplicitLeft = 7
    end
  end
end
