object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Penghalusan Seragam'
  ClientHeight = 420
  ClientWidth = 760
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 108
    Top = 14
    Width = 15
    Height = 15
    Caption = 'N :'
  end
  object Bevel1: TBevel
    Left = 12
    Top = 44
    Width = 736
    Height = 2
    Shape = bsTopLine
  end
  object Bevel2: TBevel
    Left = 12
    Top = 52
    Width = 360
    Height = 356
  end
  object Bevel3: TBevel
    Left = 388
    Top = 52
    Width = 360
    Height = 356
  end
  object Image1: TImage
    Left = 16
    Top = 56
    Width = 352
    Height = 348
    Center = True
    Proportional = True
    Stretch = True
  end
  object Image2: TImage
    Left = 392
    Top = 56
    Width = 352
    Height = 348
    Center = True
    Proportional = True
    Stretch = True
  end
  object Button1: TButton
    Left = 12
    Top = 10
    Width = 85
    Height = 25
    Caption = 'Muat citra'
    TabOrder = 0
    OnClick = Button1Click
  end
  object SpinEdit1: TSpinEdit
    Left = 125
    Top = 10
    Width = 55
    Height = 24
    MaxValue = 25
    MinValue = 1
    TabOrder = 1
    Value = 1
    OnChange = SpinEdit1Change
  end
  object OpenPictureDialog1: TOpenDialog
    Filter = 
      'Image Files|*.bmp;*.jpg;*.jpeg;*.png|Bitmap (*.bmp)|*.bmp|JPEG (' +
      '*.jpg;*.jpeg)|*.jpg;*.jpeg|PNG (*.png)|*.png|All Files (*.*)|*.*'
    Left = 680
    Top = 8
  end
end
