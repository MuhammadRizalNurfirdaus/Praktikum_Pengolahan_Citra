object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 634
  ClientWidth = 1071
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OnCreate = FormCreate
  TextHeight = 13
  object PanelLeft: TPanel
    Left = 24
    Top = 56
    Width = 470
    Height = 370
    BevelOuter = bvLowered
    BevelWidth = 2
    TabOrder = 0
    object Image1: TImage
      Left = 8
      Top = 8
      Width = 450
      Height = 310
      Center = True
      Proportional = True
      Stretch = True
    end
    object SpeedButtonMuat: TSpeedButton
      Left = 8
      Top = 336
      Width = 32
      Height = 32
      Hint = 'Muat Citra'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButtonMuatClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 568
    Top = 56
    object FILE1: TMenuItem
      Caption = 'FILE'
      object MUATCITRA1: TMenuItem
        Caption = 'MUAT CITRA'
        OnClick = MUATCITRA1Click
      end
      object EXIT1: TMenuItem
        Caption = 'EXIT'
        OnClick = EXIT1Click
      end
    end
    object OPERASI1: TMenuItem
      Caption = 'OPERASI'
    end
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 568
    Top = 120
  end
end
