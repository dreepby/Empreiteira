inherited frmUsuario: TfrmUsuario
  Caption = 'Listagem de Usu'#225'rios'
  ClientWidth = 882
  ExplicitWidth = 888
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 882
    ExplicitWidth = 882
    inherited Label1: TLabel
      Left = 13
      Top = 17
      ExplicitLeft = 13
      ExplicitTop = 17
    end
    inherited edtPesquisa: TEdit
      Left = 173
      Width = 685
      ExplicitLeft = 173
      ExplicitWidth = 685
    end
    object cbPesquisa: TComboBox
      Left = 79
      Top = 14
      Width = 88
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
      Text = 'Nome'
      Items.Strings = (
        'Nome'
        'CPF')
    end
  end
  inherited Panel2: TPanel
    Width = 882
    ExplicitWidth = 882
    inherited PageControl1: TPageControl
      Width = 872
      ExplicitWidth = 872
      inherited tsTabela: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 864
        ExplicitHeight = 239
        inherited DBGrid1: TDBGrid
          Width = 864
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
        ExplicitWidth = 864
        ExplicitHeight = 239
        object Label2: TLabel
          Left = 19
          Top = 75
          Width = 28
          Height = 13
          Caption = 'CPF *'
        end
        object edtCPF: TMaskEdit
          Left = 19
          Top = 94
          Width = 131
          Height = 27
          EditMask = '999.999.999-99;1;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 14
          ParentFont = False
          TabOrder = 0
          Text = '   .   .   -  '
          OnKeyPress = edtCPFKeyPress
        end
        object edtNome: TLabeledEdit
          Left = 156
          Top = 94
          Width = 685
          Height = 27
          EditLabel.Width = 36
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome *'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 1
          OnKeyPress = edtNomeKeyPress
        end
      end
    end
  end
  inherited Panel3: TPanel
    Width = 882
    ExplicitWidth = 882
    inherited Panel4: TPanel
      Left = 127
      ExplicitLeft = 127
    end
  end
end
