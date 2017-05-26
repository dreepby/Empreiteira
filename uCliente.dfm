inherited frmCliente: TfrmCliente
  Caption = 'Listagem de Clientes'
  ClientHeight = 553
  ExplicitHeight = 582
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel [0]
    Left = 408
    Top = 360
    Width = 31
    Height = 13
    Caption = 'Label5'
  end
  inherited Panel2: TPanel
    Height = 441
    inherited PageControl1: TPageControl
      Height = 431
      inherited tsTabela: TTabSheet
        inherited DBGrid1: TDBGrid
          Height = 403
        end
      end
      inherited tsDados: TTabSheet
        ExplicitTop = 27
        ExplicitWidth = 870
        ExplicitHeight = 453
        object Label2: TLabel
          Left = 116
          Top = 118
          Width = 33
          Height = 13
          Caption = 'Estado'
        end
        object Label3: TLabel
          Left = 394
          Top = 118
          Width = 43
          Height = 13
          Caption = 'Municipio'
        end
        object Label4: TLabel
          Left = 116
          Top = 170
          Width = 28
          Height = 13
          Caption = 'Bairro'
        end
        object Label6: TLabel
          Left = 394
          Top = 269
          Width = 58
          Height = 13
          Caption = 'Observa'#231#227'o'
        end
        object edtCpf: TLabeledEdit
          Left = 116
          Top = 40
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
          Left = 394
          Top = 40
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
          Left = 116
          Top = 88
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
          Left = 395
          Top = 88
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
          Left = 394
          Top = 285
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
          Left = 394
          Top = 188
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
          Left = 116
          Top = 236
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
          Left = 394
          Top = 236
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
          Left = 116
          Top = 285
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
          Left = 116
          Top = 137
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
          Left = 394
          Top = 137
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
          Left = 116
          Top = 189
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
  end
end
