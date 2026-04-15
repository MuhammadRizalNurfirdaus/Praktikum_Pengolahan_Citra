object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Konversi True Color ke Skala Keabuan'
  ClientHeight = 340
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Image1: TImage
    Left = 16
    Top = 64
    Width = 400
    Height = 257
    Proportional = True
    Stretch = True
  end
  object Image2: TImage
    Left = 448
    Top = 64
    Width = 400
    Height = 257
    Stretch = True
    Proportional = True
  end
  object ButtonMuatCitra: TButton
    Left = 16
    Top = 16
    Width = 121
    Height = 33
    Caption = 'Muat citra'
    TabOrder = 0
    OnClick = ButtonMuatCitraClick
  end
  object ButtonRerata: TButton
    Left = 152
    Top = 16
    Width = 153
    Height = 33
    Caption = 'Keabuan rerata'
    TabOrder = 1
    OnClick = ButtonRerataClick
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'Image Files (*.bmp;*.jpg;*.jpeg;*.png;*.gif;*.tiff)|*.bmp;*.jpg;' +
      '*.jpeg;*.png;*.gif;*.tiff|Bitmaps (*.bmp)|*.bmp|JPEG (*.jpg;*.jp' +
      'eg)|*.jpg;*.jpeg|PNG (*.png)|*.png|GIF (*.gif)|*.gif|All Files (' +
      '*.*)|*.*'
    Left = 16
    Top = 288
  end
end
