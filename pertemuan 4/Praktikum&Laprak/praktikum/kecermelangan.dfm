object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Modifikasi Kecemerlangan'
  ClientHeight = 502
  ClientWidth = 900
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object btnMuatCitra: TButton
    Left = 24
    Top = 20
    Width = 105
    Height = 29
    Caption = 'Muat Citra'
    TabOrder = 0
    OnClick = btnMuatCitraClick
  end
  object lblMerah: TLabel
    Left = 152
    Top = 10
    Width = 37
    Height = 15
    Caption = 'Merah'
  end
  object lblHijau: TLabel
    Left = 240
    Top = 10
    Width = 31
    Height = 15
    Caption = 'Hijau'
  end
  object lblBiru: TLabel
    Left = 328
    Top = 10
    Width = 23
    Height = 15
    Caption = 'Biru'
  end
  object edtMerah: TEdit
    Left = 152
    Top = 28
    Width = 73
    Height = 23
    TabOrder = 1
    Text = '0'
    OnChange = edtRGBChange
  end
  object edtHijau: TEdit
    Left = 240
    Top = 28
    Width = 73
    Height = 23
    TabOrder = 2
    Text = '0'
    OnChange = edtRGBChange
  end
  object edtBiru: TEdit
    Left = 328
    Top = 28
    Width = 73
    Height = 23
    TabOrder = 3
    Text = '0'
    OnChange = edtRGBChange
  end
  object chkSeragam: TCheckBox
    Left = 420
    Top = 31
    Width = 90
    Height = 17
    Caption = 'Seragam'
    TabOrder = 4
    OnClick = chkSeragamClick
  end
  object btnProses: TButton
    Left = 528
    Top = 20
    Width = 89
    Height = 29
    Caption = 'Proses'
    TabOrder = 5
    OnClick = btnProsesClick
  end
  object imgAsli: TImage
    Left = 24
    Top = 72
    Width = 417
    Height = 409
    Center = True
    Proportional = True
    Stretch = True
  end
  object imgHasil: TImage
    Left = 456
    Top = 72
    Width = 417
    Height = 409
    Center = True
    Proportional = True
    Stretch = True
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter =
      'File gambar|*.bmp;*.jpg;*.jpeg;*.png;*.gif|Semua file|*.*'
    Left = 744
    Top = 16
  end
end
