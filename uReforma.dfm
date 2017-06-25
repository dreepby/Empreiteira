inherited frmReforma: TfrmReforma
  Caption = 'Listagem de Reformas'
  ClientHeight = 472
  ClientWidth = 821
  ExplicitWidth = 827
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 821
    ExplicitWidth = 821
  end
  inherited Panel2: TPanel
    Width = 821
    Height = 360
    ExplicitWidth = 821
    ExplicitHeight = 360
    inherited PageControl1: TPageControl
      Width = 811
      Height = 350
      ActivePage = tsDados
      ExplicitWidth = 811
      ExplicitHeight = 350
      inherited tsTabela: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 24
        ExplicitWidth = 803
        ExplicitHeight = 322
        inherited DBGrid1: TDBGrid
          Width = 803
          Height = 322
          Columns = <
            item
              Expanded = False
              FieldName = 'idReforma'
              Title.Caption = 'C'#243'digo'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DataDoPedido'
              Title.Caption = 'Data do pedido'
              Width = 104
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DataDeEntrega'
              Title.Caption = 'Data de entrega'
              Width = 88
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'cliente'
              Title.Caption = 'Cliente'
              Width = 180
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'observacao'
              Title.Caption = 'Observacao'
              Width = 190
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'total'
              Title.Caption = 'Total'
              Width = 78
              Visible = True
            end>
        end
      end
      inherited tsDados: TTabSheet
        ExplicitTop = 27
        ExplicitWidth = 803
        ExplicitHeight = 322
        object pageControl2: TPageControl
          Left = 0
          Top = 0
          Width = 803
          Height = 322
          ActivePage = tsProdutos
          Align = alClient
          TabOrder = 0
          object tsPedido: TTabSheet
            Caption = 'Pedido'
            object Label2: TLabel
              Left = 117
              Top = 13
              Width = 73
              Height = 13
              Caption = 'Data do pedido'
            end
            object Label3: TLabel
              Left = 341
              Top = 13
              Width = 79
              Height = 13
              Caption = 'Data de entrega'
            end
            object Label4: TLabel
              Left = 117
              Top = 115
              Width = 51
              Height = 13
              Caption = 'Atendente'
            end
            object Label5: TLabel
              Left = 341
              Top = 115
              Width = 144
              Height = 13
              Caption = 'Usuario que est'#225' cadastrando'
            end
            object Label7: TLabel
              Left = 117
              Top = 175
              Width = 64
              Height = 13
              Caption = 'Obeserva'#231#227'o'
            end
            object Label6: TLabel
              Left = 563
              Top = 13
              Width = 106
              Height = 13
              Caption = 'Ambientes da reforma'
            end
            object dtpPedido: TDateTimePicker
              Left = 117
              Top = 32
              Width = 186
              Height = 27
              Date = 42903.660658750000000000
              Time = 42903.660658750000000000
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object dtpEntrega: TDateTimePicker
              Left = 341
              Top = 32
              Width = 186
              Height = 27
              Date = 42903.660658750000000000
              Time = 42903.660658750000000000
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object edtCpf: TLabeledEdit
              Left = 117
              Top = 82
              Width = 186
              Height = 27
              EditLabel.Width = 68
              EditLabel.Height = 13
              EditLabel.Caption = 'CPF do cliente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object btnPesquisarCpf: TBitBtn
              Left = 279
              Top = 82
              Width = 24
              Height = 27
              Caption = 'P'
              TabOrder = 3
            end
            object edtCnpj: TLabeledEdit
              Left = 341
              Top = 80
              Width = 186
              Height = 27
              EditLabel.Width = 74
              EditLabel.Height = 13
              EditLabel.Caption = 'CNPJ do cliente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object btnPesquisarCnpj: TBitBtn
              Left = 503
              Top = 80
              Width = 24
              Height = 27
              Caption = 'P'
              TabOrder = 5
            end
            object cbAtedente: TComboBox
              Left = 117
              Top = 134
              Width = 186
              Height = 27
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
            end
            object cbUsuario: TComboBox
              Left = 341
              Top = 134
              Width = 186
              Height = 27
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object moObservacao: TMemo
              Left = 117
              Top = 191
              Width = 186
              Height = 95
              TabOrder = 8
            end
            object cltAmbientes: TCheckListBox
              Left = 563
              Top = 29
              Width = 186
              Height = 257
              BorderStyle = bsNone
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 19
              ParentFont = False
              TabOrder = 9
            end
          end
          object tsProdutos: TTabSheet
            Caption = 'Produtos'
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 31
            object Panel5: TPanel
              Left = 368
              Top = 0
              Width = 427
              Height = 294
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 0
              object Panel6: TPanel
                Left = 0
                Top = 253
                Width = 427
                Height = 41
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 0
                ExplicitTop = 285
                object Panel7: TPanel
                  Left = 219
                  Top = 0
                  Width = 208
                  Height = 41
                  Align = alRight
                  BevelOuter = bvNone
                  TabOrder = 0
                  ExplicitLeft = 240
                  ExplicitTop = 1
                  ExplicitHeight = 39
                  object Label10: TLabel
                    Left = 11
                    Top = 10
                    Width = 42
                    Height = 19
                    Caption = 'Total:'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -16
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object edtTotal: TEdit
                    Left = 59
                    Top = 8
                    Width = 141
                    Height = 27
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -16
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    ReadOnly = True
                    TabOrder = 0
                  end
                end
                object btnAlterarProdutos: TBitBtn
                  Left = 0
                  Top = 6
                  Width = 75
                  Height = 25
                  Caption = 'Alterar'
                  TabOrder = 1
                end
                object btnExcluirProdutos: TBitBtn
                  Left = 81
                  Top = 6
                  Width = 75
                  Height = 25
                  Caption = 'Excluir'
                  TabOrder = 2
                end
              end
              object Panel8: TPanel
                Left = 0
                Top = 0
                Width = 427
                Height = 41
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                ExplicitLeft = 74
                ExplicitTop = 81
                ExplicitWidth = 185
                object Label9: TLabel
                  Left = 0
                  Top = 16
                  Width = 63
                  Height = 19
                  Caption = 'Produtos'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                end
              end
              object Panel9: TPanel
                Left = 0
                Top = 41
                Width = 427
                Height = 212
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 2
                ExplicitLeft = 266
                ExplicitTop = 224
                ExplicitWidth = 185
                ExplicitHeight = 41
                object dbgProdutos: TDBGrid
                  Left = 0
                  Top = 0
                  Width = 427
                  Height = 212
                  Align = alClient
                  DataSource = dsTabelaProduto
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'Tahoma'
                  TitleFont.Style = []
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'idProdutoReforma'
                      Title.Caption = 'C'#243'digo'
                      Width = 40
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'Quantidade'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'Produto'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'PrecoUni'
                      Title.Caption = 'Pre'#231'o Un.'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'Total'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'Observacao'
                      Width = 93
                      Visible = True
                    end>
                end
              end
            end
            object Panel10: TPanel
              Left = 0
              Top = 0
              Width = 368
              Height = 294
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              ExplicitLeft = -6
              ExplicitTop = 3
              ExplicitWidth = 344
              object Panel11: TPanel
                Left = 0
                Top = 0
                Width = 368
                Height = 41
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
                ExplicitLeft = 66
                ExplicitTop = 151
                ExplicitWidth = 185
                object Label8: TLabel
                  Left = 8
                  Top = 9
                  Width = 161
                  Height = 19
                  Caption = 'Ambiente selecionado:'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                end
                object cbAmbiente: TComboBox
                  Left = 175
                  Top = 9
                  Width = 145
                  Height = 26
                  Style = csOwnerDrawFixed
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ItemHeight = 20
                  ParentFont = False
                  TabOrder = 0
                end
              end
              object Panel12: TPanel
                Left = 0
                Top = 259
                Width = 368
                Height = 35
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 1
                ExplicitWidth = 344
                object btnAdicionarProduto: TBitBtn
                  Left = 177
                  Top = 6
                  Width = 75
                  Height = 25
                  Caption = 'Adicionar'
                  TabOrder = 0
                end
              end
              object Panel13: TPanel
                Left = 0
                Top = 41
                Width = 368
                Height = 218
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 2
                ExplicitLeft = 104
                ExplicitTop = 7
                object Label11: TLabel
                  Left = 13
                  Top = 21
                  Width = 38
                  Height = 13
                  Caption = 'Produto'
                end
                object Label12: TLabel
                  Left = 177
                  Top = 73
                  Width = 58
                  Height = 13
                  Caption = 'Observa'#231#227'o'
                end
                object cbProduto: TComboBox
                  Left = 13
                  Top = 40
                  Width = 145
                  Height = 27
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                end
                object edtPreco: TLabeledEdit
                  Left = 177
                  Top = 40
                  Width = 121
                  Height = 27
                  EditLabel.Width = 48
                  EditLabel.Height = 13
                  EditLabel.Caption = 'Pre'#231'o UN.'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 1
                end
                object moObservacaoProduto: TMemo
                  Left = 177
                  Top = 92
                  Width = 185
                  Height = 89
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  Lines.Strings = (
                    '')
                  ParentFont = False
                  TabOrder = 2
                end
                object edtQuantidade: TLabeledEdit
                  Left = 13
                  Top = 93
                  Width = 145
                  Height = 27
                  EditLabel.Width = 56
                  EditLabel.Height = 13
                  EditLabel.Caption = 'Quantidade'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  NumbersOnly = True
                  ParentFont = False
                  TabOrder = 3
                end
                object LabeledEdit1: TLabeledEdit
                  Left = 13
                  Top = 141
                  Width = 145
                  Height = 27
                  EditLabel.Width = 24
                  EditLabel.Height = 13
                  EditLabel.Caption = 'Total'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  NumbersOnly = True
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 4
                end
              end
            end
          end
        end
      end
    end
  end
  inherited Panel3: TPanel
    Top = 417
    Width = 821
    ExplicitTop = 417
    ExplicitWidth = 821
    inherited Panel4: TPanel
      Left = 66
      ExplicitLeft = 66
      inherited btnInserir: TBitBtn
        Left = 23
        Top = 1
        Width = 95
        ExplicitLeft = 23
        ExplicitTop = 1
        ExplicitWidth = 95
      end
      inherited BtnAlterar: TBitBtn
        Left = 124
        Top = 1
        Width = 95
        ExplicitLeft = 124
        ExplicitTop = 1
        ExplicitWidth = 95
      end
      inherited BtnSalvar: TBitBtn
        Left = 326
        Width = 95
        ExplicitLeft = 326
        ExplicitWidth = 95
      end
      inherited BtnCancelar: TBitBtn
        Left = 427
        Width = 95
        ExplicitLeft = 427
        ExplicitWidth = 95
      end
      inherited btnExcluir: TBitBtn
        Left = 528
        Top = 1
        Width = 95
        ExplicitLeft = 528
        ExplicitTop = 1
        ExplicitWidth = 95
      end
      inherited BtnFechar: TBitBtn
        Top = 1
        Width = 95
        ExplicitTop = 1
        ExplicitWidth = 95
      end
      object btnDetalhes: TBitBtn
        Left = 225
        Top = 1
        Width = 95
        Height = 44
        Hint = 'Edit'
        Caption = '&Detalhes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Font.Quality = fqProof
        Glyph.Data = {
          36200000424D3620000000000000360000002800000040000000200000000100
          20000000000000200000D60D0000D60D00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFB
          FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EAEA
          EA00FCFCFC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE90
          7200DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008C8C
          8C009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC8B
          6D00B85E3300DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008A8A
          8A00757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC8B
          6D00B85E3300B85E3300DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008A8A
          8A0075757500757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FCF8F600F9F2
          EF00F9F2EF00F9F2EF00FAF4F100FDFBF900FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FCF9F800FAF4F100F9F1ED00F8F0EC00F9F2EE00F9F2EF00C77F
          5D00B85E3300B85E3300B85E3300DAAB9500FFFFFF00FFFFFF00E2E2E200D8D8
          D800D8D8D800D8D8D800DADADA00E8E8E800F9F9F900FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FAFAFA00E4E4E400DBDBDB00D6D6D600D5D5D500D7D7D700D8D8D8008484
          84007575750075757500757575009B9B9B00FBFBFB00FFFFFF00BA623800B85E
          3300B85E3300B85E3300B85E3300B85E3300B95F3500D8A78F00F7EDE800FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAF4F100DAAA
          9400BB643B00B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300DAAB9500FFFFFF00777777007575
          7500757575007575750075757500757575007676760099999900D0D0D000FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DADADA009B9B
          9B00787878007575750075757500757575007575750075757500757575007575
          7500757575007575750075757500757575009B9B9B00FBFBFB00B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300DEB3
          9F00FFFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E3C0AF00B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300DCAF9A00757575007575
          750075757500757575007575750075757500757575007575750075757500A0A0
          A000F6F6F600FFFFFF00FFFFFF00FFFFFF00FCFCFC00A8A8A800757575007575
          7500757575007575750075757500757575007575750075757500757575007575
          750075757500757575007575750075757500757575009E9E9E00B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300D2997D00FFFFFF00FFFFFF00FFFFFF00DEB39F00B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300DCAF9A00757575007575
          7500757575007575750075757500757575007575750075757500757575007575
          750091919100F9F9F900FFFFFF00FEFEFE00A0A0A00075757500757575007575
          7500757575007575750075757500757575007575750075757500757575007575
          750075757500757575007575750075757500757575009E9E9E00BA623800B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300DEB4A000FFFFFF00EED9CF00B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300DAAB9500FFFFFF00777777007575
          7500757575007575750075757500757575007575750075757500757575007575
          750075757500A1A1A100FFFFFF00BCBCBC007575750075757500757575007575
          7500757575007575750075757500757575007575750075757500757575007575
          7500757575007575750075757500757575009B9B9B00FBFBFB00FCF8F600F9F2
          EF00F9F2EF00F9F2EF00F9F0ED00F1DED500D2997D00B85E3300B85E3300B85E
          3300B85E3300B85E3300F6EBE500F7EDE900B85E3300B85E3300B85E3300B85E
          3300CB886900EFDCD200F8F0EC00F9F2EF00F9F2EF00F9F2EF00F9F2EF00C77F
          5D00B85E3300B85E3300B85E3300DAAB9500FFFFFF00FFFFFF00E2E2E200D8D8
          D800D8D8D800D8D8D800D6D6D600C1C1C1009191910075757500757575007575
          75007575750075757500CECECE00D1D1D1007575750075757500757575007575
          750088888800BEBEBE00D4D4D400D8D8D800D8D8D800D8D8D800D8D8D8008484
          84007575750075757500757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E9CDC000B85E3300B85E
          3300B85E3300B85E3300C3775300FFFEFE00CE907200B85E3300B85E3300DEB3
          9F00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC8B
          6D00B85E3300B85E3300DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFDFD00B2B2B200757575007575
          7500757575007575750080808000F8F8F8008C8C8C007575750075757500A0A0
          A000FCFCFC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008A8A
          8A0075757500757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DAAA9400B85E
          3300B85E3300B85E3300B85E3300EFDCD200F7ECE700B85E3300CB8A6B00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC8B
          6D00B85E3300DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE009B9B9B007575
          7500757575007575750075757500BEBEBE00CFCFCF00757575008A8A8A00FAFA
          FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008A8A
          8A00757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFBFA00BA63
          3900B85E3300B85E3300B85E3300C3775300FFFFFF00CD8D6E00FAF4F100FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE90
          7200DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EAEAEA007777
          770075757500757575007575750080808000F9F9F9008B8B8B00DCDCDC00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008C8C
          8C009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E2BE
          AD00B85E3300B85E3300B85E3300B85E3300F3E3DC00FDFAF900FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFC
          FB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A7A7
          A70075757500757575007575750075757500C6C6C600E7E7E700FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EBEB
          EB00FCFCFC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFA
          F900B85E3300B85E3300B85E3300B85E3300CA876700FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E6E6
          E6007575750075757500757575007575750088888800FEFEFE00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DBAC9600B85E3300B85E3300B85E3300B85E3300F8EFEA00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF009C9C9C0075757500757575007575750075757500D3D3D300FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFA
          F900FAF4F100B85E3300B85E3300B85E3300B85E3300D5A08600FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFB
          FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7E7
          E700DADADA007575750075757500757575007575750095959500FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EAEA
          EA00FCFCFC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFCFB00C377
          5300FFFEFE00CF937600B85E3300B85E3300B85E3300B85E3300FAF4F100FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE90
          7200DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EBEBEB008080
          8000F7F7F7008E8E8E0075757500757575007575750075757500DADADA00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008C8C
          8C009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D8A79000B85E
          3300EDD7CD00F7EDE900B85E3300B85E3300B85E3300B85E3300CD8D6E00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC8B
          6D00B85E3300DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00999999007575
          7500BABABA00D1D1D100757575007575750075757500757575008B8B8B00FAFA
          FA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008A8A
          8A00757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EACEC100B85E3300B85E
          3300C0704A00FFFEFE00D1967A00B85E3300B85E3300B85E3300B85E3300DFB6
          A300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC8B
          6D00B85E3300B85E3300DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFEFE00B3B3B300757575007575
          75007D7D7D00F6F6F6009090900075757500757575007575750075757500A2A2
          A200FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008A8A
          8A0075757500757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FCF8F600F9F2
          EF00F9F2EF00F9F2EF00F9F0ED00F1E0D800D39B8100B85E3300B85E3300B85E
          3300B85E3300EDD5CA00FCF8F600BA623800B85E3300B85E3300B85E3300B85E
          3300CA876700EFDAD100F8F0EC00F9F2EF00F9F2EF00F9F2EF00F9F2EF00C77F
          5D00B85E3300B85E3300B85E3300DAAB9500FFFFFF00FFFFFF00E2E2E200D8D8
          D800D8D8D800D8D8D800D6D6D600C2C2C2009292920075757500757575007575
          750075757500B9B9B900E2E2E200777777007575750075757500757575007575
          750088888800BDBDBD00D4D4D400D8D8D800D8D8D800D8D8D800D8D8D8008484
          84007575750075757500757575009B9B9B00FBFBFB00FFFFFF00BA623800B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300E0B8A500FFFFFF00ECD3C700B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300DAAB9500FFFFFF00777777007575
          7500757575007575750075757500757575007575750075757500757575007575
          750075757500A4A4A400FFFFFF00B6B6B6007575750075757500757575007575
          7500757575007575750075757500757575007575750075757500757575007575
          7500757575007575750075757500757575009B9B9B00FBFBFB00B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300D2997D00FFFFFF00FFFFFF00FFFFFF00DFB6A200B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300DCAF9A00757575007575
          7500757575007575750075757500757575007575750075757500757575007575
          750091919100F9F9F900FFFFFF00FEFEFE00A2A2A20075757500757575007575
          7500757575007575750075757500757575007575750075757500757575007575
          750075757500757575007575750075757500757575009E9E9E00B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300E1BA
          A800FFFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E7C9BA00B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300B85E3300DCAF9A00757575007575
          750075757500757575007575750075757500757575007575750075757500A5A5
          A500F7F7F700FFFFFF00FFFFFF00FFFFFF00FCFCFC00AFAFAF00757575007575
          7500757575007575750075757500757575007575750075757500757575007575
          750075757500757575007575750075757500757575009E9E9E00BA623800B85E
          3300B85E3300B85E3300B85E3300B85E3300B9613600DBAC9600F8F0EC00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FAF3F000DDB1
          9D00BA623800B85E3300B85E3300B85E3300B85E3300B85E3300B85E3300B85E
          3300B85E3300B85E3300B85E3300B85E3300DAAB9500FFFFFF00777777007575
          750075757500757575007575750075757500767676009C9C9C00D5D5D500FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00D9D9D9009F9F
          9F00777777007575750075757500757575007575750075757500757575007575
          7500757575007575750075757500757575009B9B9B00FBFBFB00FCF8F600F9F2
          EF00F9F2EF00F9F2EF00FAF3F000FDFBF900FFFEFE00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FDFBFA00FAF4F100F9F2EF00F9F2EF00F9F2EF00F9F2EF00C77F
          5D00B85E3300B85E3300B85E3300DAAB9500FFFFFF00FFFFFF00E2E2E200D8D8
          D800D8D8D800D8D8D800DADADA00E8E8E800F9F9F900FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FBFBFB00EAEAEA00DBDBDB00D8D8D800D8D8D800D8D8D800D8D8D8008484
          84007575750075757500757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC8B
          6D00B85E3300B85E3300DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008A8A
          8A0075757500757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CC8B
          6D00B85E3300DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008A8A
          8A00757575009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CE90
          7200DAAB9500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008C8C
          8C009B9B9B00FBFBFB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFC
          FB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EBEB
          EB00FCFCFC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 6
      end
    end
  end
  inherited dsTabela: TDataSource
    Left = 681
    Top = 13
  end
  object dsTabelaProduto: TDataSource
    Left = 753
    Top = 5
  end
end
