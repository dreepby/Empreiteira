inherited frmCliente: TfrmCliente
  Caption = 'Listagem de Clientes'
  ClientHeight = 553
  ClientWidth = 986
  Position = poDesigned
  ExplicitWidth = 992
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
    Width = 986
    inherited Label1: TLabel
      Width = 96
      Caption = 'Buscar por '
      ExplicitWidth = 96
    end
    inherited edtPesquisa: TEdit
      Left = 355
      Top = 14
      ExplicitLeft = 355
      ExplicitTop = 14
    end
    inherited btnPesquisa: TButton
      Left = 722
      Top = 14
      ExplicitLeft = 722
      ExplicitTop = 14
    end
    object cbPesquisa: TComboBox
      Left = 134
      Top = 19
      Width = 203
      Height = 21
      TabOrder = 2
      Items.Strings = (
        'Nome do cliente'
        'Rua'
        'Bairro'
        'CEP'
        'Municipio'
        'Estado')
    end
  end
  inherited Panel2: TPanel
    Width = 986
    Height = 441
    ExplicitHeight = 441
    inherited PageControl1: TPageControl
      Width = 976
      Height = 431
      ExplicitHeight = 431
      inherited tsTabela: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 746
        ExplicitHeight = 403
        inherited DBGrid1: TDBGrid
          Width = 968
          Height = 403
          Columns = <
            item
              Expanded = False
              FieldName = 'idCliente'
              Title.Caption = 'C'#243'digo'
              Width = 53
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Nome'
              Width = 164
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CPF'
              Width = 103
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CNPJ'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Telefone'
              Width = 101
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Observacao'
              Title.Caption = 'Observa'#231#227'o'
              Width = 151
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'endereco'
              Title.Caption = 'Endere'#231'o'
              Width = 246
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Complemento'
              Width = 107
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CEP'
              Width = 88
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'bairro'
              Title.Caption = 'Bairro'
              Width = 87
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'municipio'
              Title.Caption = 'Municipio'
              Width = 129
              Visible = True
            end>
        end
      end
      inherited tsDados: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 746
        ExplicitHeight = 403
        object Label2: TLabel
          Left = 220
          Top = 126
          Width = 33
          Height = 13
          Caption = 'Estado'
        end
        object Label3: TLabel
          Left = 498
          Top = 126
          Width = 43
          Height = 13
          Caption = 'Municipio'
        end
        object Label4: TLabel
          Left = 220
          Top = 178
          Width = 28
          Height = 13
          Caption = 'Bairro'
        end
        object Label6: TLabel
          Left = 498
          Top = 277
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object edtCpf: TLabeledEdit
          Left = 220
          Top = 48
          Width = 233
          Height = 27
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.Caption = 'CPF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtCnpj: TLabeledEdit
          Left = 498
          Top = 48
          Width = 233
          Height = 27
          EditLabel.Width = 25
          EditLabel.Height = 13
          EditLabel.Caption = 'CNPJ'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object frmTelefone: TLabeledEdit
          Left = 220
          Top = 96
          Width = 233
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
          TabOrder = 2
        end
        object edtCelular: TLabeledEdit
          Left = 499
          Top = 96
          Width = 233
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
          TabOrder = 3
        end
        object moObservacao: TMemo
          Left = 498
          Top = 293
          Width = 233
          Height = 89
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          Lines.Strings = (
            '')
          ParentFont = False
          TabOrder = 4
        end
        object edtRua: TLabeledEdit
          Left = 498
          Top = 196
          Width = 233
          Height = 27
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.Caption = 'Rua'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object edtNumero: TLabeledEdit
          Left = 220
          Top = 244
          Width = 233
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
          TabOrder = 6
        end
        object edtComplemento: TLabeledEdit
          Left = 498
          Top = 244
          Width = 233
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
          TabOrder = 7
        end
        object edtCep: TLabeledEdit
          Left = 220
          Top = 293
          Width = 233
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
          TabOrder = 8
        end
        object cbEstado: TComboBox
          Left = 220
          Top = 145
          Width = 233
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
        end
        object cbMunicipio: TComboBox
          Left = 498
          Top = 145
          Width = 233
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
        end
        object cbBairro: TComboBox
          Left = 220
          Top = 197
          Width = 233
          Height = 27
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
        end
      end
    end
  end
  inherited Panel3: TPanel
    Top = 498
    Width = 986
    ExplicitTop = 498
    inherited Panel4: TPanel
      Left = 485
    end
  end
  inherited dsTabela: TDataSource
    Left = 817
    Top = 13
  end
end
