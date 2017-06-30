inherited frmCliente: TfrmCliente
  Caption = 'Listagem de Clientes'
  ClientHeight = 553
  ClientWidth = 940
  ExplicitWidth = 946
  ExplicitHeight = 581
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel [0]
    Left = 408
    Top = 360
    Width = 31
    Height = 13
    Caption = 'Label5'
  end
  inherited Panel1: TPanel
    Width = 940
    ExplicitWidth = 940
    inherited Label1: TLabel
      Width = 96
      Caption = 'Buscar por '
      ExplicitWidth = 96
    end
    inherited edtPesquisa: TEdit
      Left = 284
      Width = 513
      ExplicitLeft = 284
      ExplicitWidth = 513
    end
    object cbPesquisa: TComboBox
      Left = 134
      Top = 14
      Width = 144
      Height = 27
      Style = csOwnerDrawFixed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 21
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = 'CPF/CNPJ'
      Items.Strings = (
        'CPF/CNPJ'
        'Nome do cliente'
        'CEP')
    end
  end
  inherited Panel2: TPanel
    Width = 940
    Height = 441
    ExplicitWidth = 940
    ExplicitHeight = 441
    inherited PageControl1: TPageControl
      Width = 930
      Height = 431
      ActivePage = tsDados
      ExplicitWidth = 930
      ExplicitHeight = 431
      inherited tsTabela: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 922
        ExplicitHeight = 403
        inherited DBGrid1: TDBGrid
          Width = 922
          Height = 403
          Columns = <
            item
              Expanded = False
              FieldName = 'idCliente'
              Title.Caption = 'C'#243'digo'
              Width = 55
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Nome'
              Width = 285
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CPFCNPJ'
              Title.Caption = 'CPF/CNPJ'
              Width = 131
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Municipio'
              Width = 209
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Telefone'
              Width = 103
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Celular'
              Width = 104
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CEP'
              Width = 111
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Endereco'
              Title.Caption = 'Endere'#231'o'
              Width = 202
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Bairro'
              Width = 136
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Complemento'
              Width = 204
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Observacao'
              Title.Caption = 'Observa'#231#227'o'
              Width = 216
              Visible = True
            end>
        end
      end
      inherited tsDados: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 922
        ExplicitHeight = 403
        object Label2: TLabel
          Left = 23
          Top = 156
          Width = 33
          Height = 13
          Caption = 'Estado'
        end
        object Label3: TLabel
          Left = 475
          Top = 156
          Width = 43
          Height = 13
          Caption = 'Municipio'
        end
        object Label4: TLabel
          Left = 23
          Top = 206
          Width = 28
          Height = 13
          Caption = 'Bairro'
        end
        object Label6: TLabel
          Left = 23
          Top = 254
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object edtNome: TLabeledEdit
          Left = 181
          Top = 21
          Width = 714
          Height = 27
          EditLabel.Width = 76
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome do cliente'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 0
        end
        object edtCpfCnpj: TLabeledEdit
          Left = 21
          Top = 21
          Width = 154
          Height = 27
          EditLabel.Width = 48
          EditLabel.Height = 13
          EditLabel.Caption = 'CPF/CNPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object edtCelular: TLabeledEdit
          Left = 688
          Top = 221
          Width = 209
          Height = 27
          EditLabel.Width = 33
          EditLabel.Height = 13
          EditLabel.Caption = 'Celular'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = '00000000000'
        end
        object edtTelefone: TLabeledEdit
          Left = 467
          Top = 221
          Width = 205
          Height = 27
          EditLabel.Width = 42
          EditLabel.Height = 13
          EditLabel.Caption = 'Telefone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          Text = '0000000000'
        end
        object cbEstado: TComboBox
          Left = 21
          Top = 173
          Width = 430
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object cbMunicipio: TComboBox
          Left = 467
          Top = 173
          Width = 430
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object cbBairro: TComboBox
          Left = 21
          Top = 221
          Width = 430
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object edtRua: TLabeledEdit
          Left = 21
          Top = 71
          Width = 740
          Height = 27
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.Caption = 'Rua'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 255
          ParentFont = False
          TabOrder = 7
        end
        object edtComplemento: TLabeledEdit
          Left = 21
          Top = 123
          Width = 740
          Height = 27
          EditLabel.Width = 65
          EditLabel.Height = 13
          EditLabel.Caption = 'Complemento'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object edtNumero: TLabeledEdit
          Left = 775
          Top = 71
          Width = 122
          Height = 27
          EditLabel.Width = 77
          EditLabel.Height = 13
          EditLabel.Caption = 'Numero da casa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 9
        end
        object edtCep: TLabeledEdit
          Left = 775
          Top = 123
          Width = 122
          Height = 27
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.Caption = 'CEP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object moObservacao: TMemo
          Left = 21
          Top = 273
          Width = 876
          Height = 89
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 255
          ParentFont = False
          TabOrder = 11
          WantReturns = False
        end
      end
    end
  end
  inherited Panel3: TPanel
    Top = 498
    Width = 940
    ExplicitTop = 498
    ExplicitWidth = 940
    inherited Panel4: TPanel
      Left = 185
      ExplicitLeft = 185
    end
  end
  inherited dsTabela: TDataSource
    Left = 817
    Top = 13
  end
end
