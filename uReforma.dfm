inherited frmReforma: TfrmReforma
  Caption = 'Listagem de Reformas'
  ClientHeight = 472
  ClientWidth = 977
  ExplicitWidth = 983
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 977
    ExplicitWidth = 977
    inherited Label1: TLabel
      Left = 16
      ExplicitLeft = 16
    end
    inherited edtPesquisa: TEdit
      Left = 88
      Top = 11
      Width = 858
      ExplicitLeft = 88
      ExplicitTop = 11
      ExplicitWidth = 858
    end
  end
  inherited Panel2: TPanel
    Width = 977
    Height = 360
    ExplicitWidth = 977
    ExplicitHeight = 360
    inherited PageControl1: TPageControl
      Width = 967
      Height = 350
      ExplicitWidth = 967
      ExplicitHeight = 350
      inherited tsTabela: TTabSheet
        ExplicitWidth = 959
        ExplicitHeight = 322
        inherited DBGrid1: TDBGrid
          Width = 959
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
              Width = 307
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'total'
              Title.Caption = 'Total'
              Width = 172
              Visible = True
            end>
        end
      end
      inherited tsDados: TTabSheet
        ExplicitWidth = 959
        ExplicitHeight = 322
        object pageControl2: TPageControl
          Left = 0
          Top = 0
          Width = 959
          Height = 322
          ActivePage = tsPedido
          Align = alClient
          TabOrder = 0
          object tsPedido: TTabSheet
            Caption = 'Pedido'
            object Label2: TLabel
              Left = 380
              Top = 7
              Width = 82
              Height = 13
              Caption = 'Data do pedido *'
            end
            object Label3: TLabel
              Left = 641
              Top = 7
              Width = 88
              Height = 13
              Caption = 'Data de entrega *'
            end
            object Label4: TLabel
              Left = 92
              Top = 59
              Width = 51
              Height = 13
              Caption = 'Atendente'
            end
            object Label5: TLabel
              Left = 92
              Top = 111
              Width = 144
              Height = 13
              Caption = 'Usuario que est'#225' cadastrando'
            end
            object Label7: TLabel
              Left = 92
              Top = 159
              Width = 64
              Height = 13
              Caption = 'Obeserva'#231#227'o'
            end
            object edtCpfCnpj: TLabeledEdit
              Left = 92
              Top = 26
              Width = 202
              Height = 27
              EditLabel.Width = 106
              EditLabel.Height = 13
              EditLabel.Caption = 'CPF/CNPJ do cliente *'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              MaxLength = 14
              ParentFont = False
              TabOrder = 0
            end
            object btnPesquisarCliente: TBitBtn
              Left = 294
              Top = 26
              Width = 24
              Height = 27
              Caption = 'P'
              TabOrder = 1
            end
            object dtpPedido: TDateTimePicker
              Left = 380
              Top = 26
              Width = 199
              Height = 27
              Date = 42903.660658750000000000
              Time = 42903.660658750000000000
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object dtpEntrega: TDateTimePicker
              Left = 641
              Top = 26
              Width = 201
              Height = 27
              Date = 42903.660658750000000000
              Time = 42903.660658750000000000
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object cbAtendente: TComboBox
              Left = 92
              Top = 78
              Width = 750
              Height = 27
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object cbUsuario: TComboBox
              Left = 92
              Top = 126
              Width = 750
              Height = 27
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
            object moObservacao: TMemo
              Left = 92
              Top = 178
              Width = 750
              Height = 95
              MaxLength = 120
              TabOrder = 6
              WantReturns = False
            end
          end
          object tsProdutos: TTabSheet
            Caption = 'Produtos'
            ImageIndex = 1
            object Label6: TLabel
              Left = 3
              Top = 8
              Width = 106
              Height = 13
              Caption = 'Ambientes da reforma'
            end
            object cltAmbientes: TCheckListBox
              Left = 3
              Top = 24
              Width = 186
              Height = 257
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -16
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 19
              ParentFont = False
              TabOrder = 0
            end
            object Panel13: TPanel
              Left = 195
              Top = -3
              Width = 401
              Height = 294
              BevelOuter = bvNone
              TabOrder = 1
              object Label11: TLabel
                Left = 0
                Top = 24
                Width = 38
                Height = 13
                Caption = 'Produto'
              end
              object Label12: TLabel
                Left = 3
                Top = 131
                Width = 58
                Height = 13
                Caption = 'Observa'#231#227'o'
              end
              object cbProduto: TComboBox
                Left = 0
                Top = 43
                Width = 321
                Height = 27
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
              end
              object edtQuantidade: TLabeledEdit
                Left = 0
                Top = 93
                Width = 100
                Height = 27
                EditLabel.Width = 56
                EditLabel.Height = 13
                EditLabel.Caption = 'Quantidade'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                MaxLength = 10
                NumbersOnly = True
                ParentFont = False
                TabOrder = 1
              end
              object moObservacaoProduto: TMemo
                Left = 0
                Top = 150
                Width = 321
                Height = 104
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -16
                Font.Name = 'Tahoma'
                Font.Style = []
                Lines.Strings = (
                  '')
                MaxLength = 255
                ParentFont = False
                TabOrder = 2
                WantReturns = False
              end
              object btnAdicionar: TBitBtn
                Left = 167
                Top = 262
                Width = 75
                Height = 25
                Caption = 'Adicionar'
                TabOrder = 3
              end
              object btnCancelarProduto: TBitBtn
                Left = 248
                Top = 262
                Width = 74
                Height = 24
                Caption = 'Cancelar'
                TabOrder = 4
              end
              object edtPreco: TLabeledEdit
                Left = 112
                Top = 93
                Width = 65
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
                TabOrder = 5
              end
              object edtTotalProduto: TLabeledEdit
                Left = 192
                Top = 93
                Width = 130
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
                TabOrder = 6
              end
            end
            object Panel5: TPanel
              Left = 524
              Top = 0
              Width = 427
              Height = 294
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 2
              object Panel8: TPanel
                Left = 0
                Top = 0
                Width = 427
                Height = 41
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 0
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
                object Label8: TLabel
                  Left = 172
                  Top = 16
                  Width = 142
                  Height = 19
                  Caption = 'Total do pedido: R$'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clWindowText
                  Font.Height = -16
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                end
                object valorPedido: TLabel
                  Left = 320
                  Top = 16
                  Width = 9
                  Height = 19
                  Caption = '0'
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
                TabOrder = 1
                object dbgProdutos: TDBGrid
                  Left = 0
                  Top = 0
                  Width = 427
                  Height = 212
                  Align = alClient
                  DataSource = dsTabelaProduto
                  Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
                  TabOrder = 0
                  TitleFont.Charset = DEFAULT_CHARSET
                  TitleFont.Color = clWindowText
                  TitleFont.Height = -11
                  TitleFont.Name = 'Tahoma'
                  TitleFont.Style = []
                  Columns = <
                    item
                      Expanded = False
                      FieldName = 'Produto'
                      Width = 87
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'Quantidade'
                      Title.Caption = 'Quant.'
                      Width = 38
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'precouni'
                      Title.Caption = 'Pre'#231'o Un.'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'total'
                      Title.Caption = 'Total'
                      Visible = True
                    end
                    item
                      Expanded = False
                      FieldName = 'observacao'
                      Title.Caption = 'Observa'#231#227'o'
                      Width = 128
                      Visible = True
                    end>
                end
              end
              object Panel6: TPanel
                Left = 0
                Top = 253
                Width = 427
                Height = 41
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 2
                object Panel7: TPanel
                  Left = 219
                  Top = 0
                  Width = 208
                  Height = 41
                  Align = alRight
                  BevelOuter = bvNone
                  TabOrder = 0
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
            end
          end
        end
      end
    end
  end
  inherited Panel3: TPanel
    Top = 417
    Width = 977
    ExplicitTop = 417
    ExplicitWidth = 977
    inherited Panel4: TPanel
      Left = 222
      ExplicitLeft = 222
      inherited btnInserir: TBitBtn
        Left = 127
        Top = 1
        Width = 95
        ExplicitLeft = 127
        ExplicitTop = 1
        ExplicitWidth = 95
      end
      inherited BtnAlterar: TBitBtn
        Left = 228
        Top = 1
        Width = 95
        ExplicitLeft = 228
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
    end
  end
  inherited dsTabela: TDataSource
    Left = 681
    Top = 13
  end
  object dsTabelaProduto: TDataSource
    DataSet = FDMemTable1
    Left = 753
    Top = 5
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 880
    Top = 8
    object FDMemTable1Quantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object FDMemTable1total: TFloatField
      FieldName = 'total'
    end
    object FDMemTable1observacao: TStringField
      FieldName = 'observacao'
      Size = 255
    end
    object FDMemTable1precouni: TFloatField
      FieldName = 'precouni'
    end
    object FDMemTable1idAmbiente: TIntegerField
      FieldName = 'idAmbiente'
    end
    object FDMemTable1Produto: TStringField
      FieldName = 'Produto'
    end
    object FDMemTable1idProduto: TIntegerField
      FieldName = 'idProduto'
    end
  end
end
