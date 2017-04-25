inherited frmEstados: TfrmEstados
  Caption = 'Estados'
  FormStyle = fsMDIChild
  Position = poDesktopCenter
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl1: TPageControl
    ExplicitLeft = 0
    ExplicitTop = 0
    inherited TabSheet1: TTabSheet
      ExplicitWidth = 464
      ExplicitHeight = 215
      inherited Panel1: TPanel
        ExplicitTop = 174
        ExplicitWidth = 464
        inherited Panel2: TPanel
          ExplicitLeft = 214
          inherited btnExcluir: TBitBtn
            OnClick = nil
          end
        end
      end
    end
    inherited TabSheet2: TTabSheet
      ExplicitWidth = 464
      ExplicitHeight = 215
    end
  end
end
