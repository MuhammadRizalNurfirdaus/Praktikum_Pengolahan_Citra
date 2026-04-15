object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Pengolahan Citra'
  ClientHeight = 400
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  TextHeight = 15
  object Image1: TImage
    Left = 16
    Top = 16
    Width = 400
    Height = 350
    Stretch = True
    Proportional = True
  end
  object Image2: TImage
    Left = 448
    Top = 16
    Width = 400
    Height = 350
    Stretch = True
    Proportional = True
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 350
    object FileMenu: TMenuItem
      Caption = 'File'
      object MenuLoadImage: TMenuItem
        Caption = 'Load Image'
        OnClick = MenuLoadImageClick
      end
      object MenuSaveImage: TMenuItem
        Caption = 'Save Result'
        OnClick = MenuSaveImageClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object MenuExit: TMenuItem
        Caption = 'Exit'
        OnClick = MenuExitClick
      end
    end
    object ProcessMenu: TMenuItem
      Caption = 'Process'
      object MenuNegative: TMenuItem
        Caption = 'Citra Negatif'
        OnClick = MenuNegativeClick
      end
      object MenuGrayscale: TMenuItem
        Caption = 'Skala Keabuan'
        OnClick = MenuGrayscaleClick
      end
    end
    object HelpMenu: TMenuItem
      Caption = 'Help'
      object MenuAbout: TMenuItem
        Caption = 'About'
        OnClick = MenuAboutClick
      end
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'Image Files (*.bmp;*.jpg;*.jpeg;*.png;*.gif;*.tiff)|*.bmp;*.jpg;*.jpeg;*.png;*.gif;*.tiff|Bitmaps (*.bmp)|*.bmp|JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg|PNG (*.png)|*.png|GIF (*.gif)|*.gif|All Files (*.*)|*.*'
    Left = 16
    Top = 350
  end
  object SavePictureDialog1: TSavePictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp|JPEG (*.jpg)|*.jpg|PNG (*.png)|*.png'
    Left = 80
    Top = 350
  end
end
