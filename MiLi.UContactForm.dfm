object FContactForm: TFContactForm
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Dialog'
  ClientHeight = 179
  ClientWidth = 384
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 8
    Top = 8
    Width = 281
    Height = 161
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 10
    Height = 13
    Caption = 'IP'
  end
  object Label2: TLabel
    Left = 40
    Top = 128
    Width = 31
    Height = 13
    Caption = 'Name:'
  end
  object Label3: TLabel
    Left = 40
    Top = 80
    Width = 24
    Height = 13
    Caption = 'Port:'
  end
  object OKBtn: TButton
    Left = 300
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelBtn: TButton
    Left = 300
    Top = 38
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object edIP: TEdit
    Left = 109
    Top = 18
    Width = 169
    Height = 21
    TabOrder = 2
    Text = '93.185.181.210'
  end
  object Button1: TButton
    Left = 207
    Top = 38
    Width = 25
    Height = 25
    Caption = 'h'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 232
    Top = 38
    Width = 25
    Height = 25
    Caption = 'w'
    TabOrder = 4
  end
  object Button3: TButton
    Left = 253
    Top = 38
    Width = 25
    Height = 25
    Caption = 'M'
    TabOrder = 5
  end
  object edName: TEdit
    Left = 109
    Top = 122
    Width = 169
    Height = 21
    TabOrder = 6
  end
  object edPort: TSpinEdit
    Left = 112
    Top = 72
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 32111
  end
end
