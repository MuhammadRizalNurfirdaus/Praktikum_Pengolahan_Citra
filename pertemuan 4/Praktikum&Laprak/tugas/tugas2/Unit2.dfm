object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Peningkatan Kontras Citra'
  ClientHeight = 900
  ClientWidth = 1200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 1200
    Height = 900
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 1194
    ExplicitHeight = 883
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 1200
      Height = 70
      Align = alTop
      BevelOuter = bvNone
      BevelWidth = 2
      Color = 14671839
      ParentBackground = False
      TabOrder = 0
      ExplicitWidth = 1194
      object lblTitle: TLabel
        Left = 16
        Top = 12
        Width = 199
        Height = 21
        Caption = 'Peningkatan Kontras Citra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblFactor1: TLabel
        Left = 314
        Top = 18
        Width = 60
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Ringan'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblFactor2: TLabel
        Left = 380
        Top = 18
        Width = 60
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Sedang'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblFactor3: TLabel
        Left = 446
        Top = 18
        Width = 60
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Tinggi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblFactor4: TLabel
        Left = 512
        Top = 18
        Width = 60
        Height = 15
        Alignment = taCenter
        AutoSize = False
        Caption = 'Sangat Tinggi'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btnMuatCitra: TButton
        Left = 16
        Top = 38
        Width = 100
        Height = 25
        Caption = 'Muat Citra'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnMuatCitraClick
      end
      object btnProses: TButton
        Left = 122
        Top = 38
        Width = 100
        Height = 25
        Caption = 'Proses'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnProsesClick
      end
      object edtFactor: TEdit
        Left = 228
        Top = 38
        Width = 80
        Height = 23
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '1.50'
      end
      object btnFactor1: TButton
        Left = 314
        Top = 38
        Width = 60
        Height = 25
        Caption = '1.20'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = btnFactor1Click
      end
      object btnFactor2: TButton
        Left = 380
        Top = 38
        Width = 60
        Height = 25
        Caption = '1.50'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = btnFactor2Click
      end
      object btnFactor3: TButton
        Left = 446
        Top = 38
        Width = 60
        Height = 25
        Caption = '1.80'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = btnFactor3Click
      end
      object btnFactor4: TButton
        Left = 512
        Top = 38
        Width = 60
        Height = 25
        Caption = '2.20'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = btnFactor4Click
      end
    end
    object pnlImages: TPanel
      Left = 0
      Top = 70
      Width = 1200
      Height = 550
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 1194
      ExplicitHeight = 533
      object lblAsli: TLabel
        Left = 20
        Top = 10
        Width = 28
        Height = 21
        Caption = 'Asli'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblHasil: TLabel
        Left = 660
        Top = 10
        Width = 38
        Height = 21
        Caption = 'Hasil'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ScrollBox1: TScrollBox
        Left = 20
        Top = 35
        Width = 520
        Height = 500
        BevelInner = bvLowered
        BevelOuter = bvRaised
        TabOrder = 0
        object imgAsli: TImage
          Left = 0
          Top = 0
          Width = 516
          Height = 496
          Align = alClient
          Center = True
          Proportional = True
          Stretch = True
        end
      end
      object ScrollBox2: TScrollBox
        Left = 660
        Top = 35
        Width = 520
        Height = 500
        BevelInner = bvLowered
        BevelOuter = bvRaised
        TabOrder = 1
        object imgHasil: TImage
          Left = 0
          Top = 0
          Width = 516
          Height = 496
          Align = alClient
          Center = True
          Proportional = True
          Stretch = True
        end
      end
    end
    object pnlAnalisis: TPanel
      Left = 0
      Top = 620
      Width = 1200
      Height = 280
      Align = alBottom
      BevelOuter = bvNone
      Color = 14671839
      ParentBackground = False
      TabOrder = 2
      ExplicitTop = 603
      ExplicitWidth = 1194
      object lblAnalisisTitle: TLabel
        Left = 20
        Top = 10
        Width = 59
        Height = 21
        Caption = 'Analisis'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object memoAnalisis: TMemo
        Left = 20
        Top = 35
        Width = 1160
        Height = 230
        BevelInner = bvLowered
        BevelOuter = bvRaised
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        Lines.Strings = (
          'Silakan muat citra terlebih dahulu...')
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 0
        WordWrap = False
      end
    end
  end
  object OpenDialog: TOpenDialog
    Left = 1100
    Top = 600
  end
end
