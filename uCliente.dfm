inherited frmCliente: TfrmCliente
  Caption = 'Listagem de Clientes'
  ClientHeight = 553
  ClientWidth = 940
  OnKeyPress = FormKeyPress
  ExplicitWidth = 946
  ExplicitHeight = 582
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 940
    ExplicitWidth = 940
    inherited Label1: TLabel
      Left = 10
      Top = 17
      Width = 80
      Caption = 'Buscar por '
      ExplicitLeft = 10
      ExplicitTop = 17
      ExplicitWidth = 80
    end
    inherited edtPesquisa: TEdit
      Left = 254
      Width = 675
      ExplicitLeft = 254
      ExplicitWidth = 675
    end
    object cbPesquisa: TComboBox
      Left = 104
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
        object Label7: TLabel
          Left = 777
          Top = 120
          Width = 28
          Height = 13
          Caption = 'CEP *'
        end
        object Label2: TLabel
          Left = 23
          Top = 172
          Width = 42
          Height = 13
          Caption = 'Estado *'
        end
        object Label3: TLabel
          Left = 467
          Top = 172
          Width = 52
          Height = 13
          Caption = 'Municipio *'
        end
        object Label4: TLabel
          Left = 23
          Top = 222
          Width = 37
          Height = 13
          Caption = 'Bairro *'
        end
        object Label6: TLabel
          Left = 23
          Top = 270
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object edtCpfCnpj: TLabeledEdit
          Left = 21
          Top = 37
          Width = 153
          Height = 27
          EditLabel.Width = 57
          EditLabel.Height = 13
          EditLabel.Caption = 'CPF/CNPJ *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtNome: TLabeledEdit
          Left = 181
          Top = 37
          Width = 713
          Height = 27
          EditLabel.Width = 85
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome do cliente *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 1
        end
        object edtRua: TLabeledEdit
          Left = 21
          Top = 87
          Width = 739
          Height = 27
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'Rua *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 255
          ParentFont = False
          TabOrder = 2
        end
        object edtNumero: TLabeledEdit
          Left = 775
          Top = 87
          Width = 121
          Height = 27
          EditLabel.Width = 86
          EditLabel.Height = 13
          EditLabel.Caption = 'Numero da casa *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 3
        end
        object edtComplemento: TLabeledEdit
          Left = 21
          Top = 139
          Width = 739
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
          TabOrder = 4
        end
        object edtCep: TMaskEdit
          Left = 777
          Top = 139
          Width = 114
          Height = 27
          EditMask = '00000\-999;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 9
          ParentFont = False
          TabOrder = 5
          Text = '     -   '
        end
        object cbEstado: TComboBox
          Left = 21
          Top = 189
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
        object cbMunicipio: TComboBox
          Left = 465
          Top = 189
          Width = 430
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
        object cbBairro: TComboBox
          Left = 21
          Top = 237
          Width = 430
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
        end
        object edtTelefone: TLabeledEdit
          Left = 467
          Top = 237
          Width = 205
          Height = 27
          EditLabel.Width = 51
          EditLabel.Height = 13
          EditLabel.Caption = 'Telefone *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 10
          NumbersOnly = True
          ParentFont = False
          TabOrder = 9
        end
        object edtCelular: TLabeledEdit
          Left = 688
          Top = 237
          Width = 209
          Height = 27
          EditLabel.Width = 42
          EditLabel.Height = 13
          EditLabel.Caption = 'Celular *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 11
          NumbersOnly = True
          ParentFont = False
          TabOrder = 10
        end
        object moObservacao: TMemo
          Left = 21
          Top = 289
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
