object FrmMain: TFrmMain
  Left = 498
  Top = 313
  BorderStyle = bsSingle
  Caption = 'QrCode Generator'
  ClientHeight = 337
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 23
  object Image1: TImage
    Left = 8
    Top = 8
    Width = 321
    Height = 321
  end
  object Label1: TLabel
    Left = 343
    Top = 43
    Width = 132
    Height = 23
    Caption = 'Propriedades:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 335
    Top = 135
    Width = 88
    Height = 23
    Caption = 'Tamanho'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 335
    Top = 203
    Width = 250
    Height = 23
    Caption = 'N'#237'vel de corre'#231#227'o de erros'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtnGenerate: TButton
    Left = 544
    Top = 288
    Width = 95
    Height = 41
    Caption = 'Gerar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = BtnGenerateClick
  end
  object MemoData: TMemo
    Left = 335
    Top = 88
    Width = 312
    Height = 9
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'Sample Data')
    MaxLength = 2000
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object EditWidth: TMaskEdit
    Left = 335
    Top = 164
    Width = 69
    Height = 31
    EditMask = '!999;1; '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 3
    ParentFont = False
    TabOrder = 2
    Text = '300'
  end
  object EditHeight: TMaskEdit
    Left = 461
    Top = 164
    Width = 69
    Height = 31
    EditMask = '!999;1; '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 3
    ParentFont = False
    TabOrder = 3
    Text = '300'
  end
  object ComboBoxErrCorrLevel: TComboBox
    Left = 335
    Top = 232
    Width = 296
    Height = 31
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 4
    Text = 'L  - [Default] Allows recovery of up to 7% data loss'
    OnChange = BtnGenerateClick
    Items.Strings = (
      'L  - [Default] Allows recovery of up to 7% data loss'
      'M - Allows recovery of up to 15% data loss'
      'Q - Allows recovery of up to 25% data loss'
      'H - Allows recovery of up to 30% data loss')
  end
end
