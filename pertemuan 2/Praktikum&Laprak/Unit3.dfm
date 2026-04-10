object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Tampil Citra'
  ClientHeight = 452
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Image1: TImage
    Left = 128
    Top = 16
    Width = 489
    Height = 409
    Stretch = True
  end
  object ButtonMuatCitra: TButton
    Left = 16
    Top = 16
    Width = 89
    Height = 25
    Caption = 'Muat citra'
    TabOrder = 0
    OnClick = ButtonMuatCitraClick
  end
  object CheckBoxCenter: TCheckBox
    Left = 16
    Top = 56
    Width = 97
    Height = 17
    Caption = 'Center'
    TabOrder = 1
    OnClick = CheckBoxCenterClick
  end
  object CheckBoxStretch: TCheckBox
    Left = 16
    Top = 80
    Width = 97
    Height = 17
    Caption = 'Stretch'
    TabOrder = 2
    OnClick = CheckBoxStretchClick
  end
  object CheckBoxProportional: TCheckBox
    Left = 16
    Top = 104
    Width = 97
    Height = 17
    Caption = 'Proportional'
    TabOrder = 3
    OnClick = CheckBoxProportionalClick
  end
  object CheckBoxAutoSize: TCheckBox
    Left = 16
    Top = 128
    Width = 97
    Height = 17
    Caption = 'AutoSize'
    TabOrder = 4
    OnClick = CheckBoxAutoSizeClick
  end
  object ButtonUkuranSemula: TButton
    Left = 16
    Top = 160
    Width = 97
    Height = 25
    Caption = 'Ukuran semula'
    TabOrder = 5
    OnClick = ButtonUkuranSemulaClick
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 
      'Image Files (*.bmp;*.jpg;*.jpeg)|*.bmp;*.jpg;*.jpeg|Bitmaps (*.b' +
      'mp)|*.bmp|JPEG (*.jpg;*.jpeg)|*.jpg;*.jpeg'
    Left = 16
    Top = 208
  end
end
