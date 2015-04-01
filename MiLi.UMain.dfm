object FMain: TFMain
  Left = 0
  Top = 0
  Caption = 'Mili'
  ClientHeight = 522
  ClientWidth = 737
  Color = clGradientActiveCaption
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 257
    Top = 0
    Height = 503
    Beveled = True
    Color = clGradientActiveCaption
    ParentColor = False
    ExplicitLeft = 296
    ExplicitTop = 96
    ExplicitHeight = 100
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 503
    Width = 737
    Height = 19
    Panels = <
      item
        Style = psOwnerDraw
        Width = 30
      end
      item
        Width = 200
      end
      item
        Width = 50
      end>
    OnDrawPanel = StatusBarDrawPanel
  end
  object pnlLeft: TPanel
    Left = 0
    Top = 0
    Width = 257
    Height = 503
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'pnlLeft'
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 1
    object pnlMyInfo: TPanel
      Left = 0
      Top = 0
      Width = 257
      Height = 41
      Align = alTop
      BevelEdges = [beBottom]
      BevelKind = bkSoft
      BevelOuter = bvNone
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 0
      object cbOnline: TCheckBox
        Left = 32
        Top = 18
        Width = 97
        Height = 17
        Caption = 'Online'
        TabOrder = 0
        OnClick = cbOnlineClick
      end
      object Button2: TButton
        Left = 152
        Top = 10
        Width = 25
        Height = 25
        Caption = '5'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 176
        Top = 10
        Width = 25
        Height = 25
        Caption = '6'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 204
        Top = 10
        Width = 25
        Height = 25
        Caption = 'e'
        TabOrder = 3
        OnClick = Button4Click
      end
    end
    object pnlContacts: TPanel
      Left = 0
      Top = 41
      Width = 257
      Height = 462
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnlContacts'
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 1
      object btnAddContact: TButton
        Left = 24
        Top = 6
        Width = 33
        Height = 25
        Caption = '+'
        TabOrder = 1
        Visible = False
        OnClick = btnAddContactClick
      end
      object btnDeleteContact: TButton
        Left = 136
        Top = 6
        Width = 25
        Height = 25
        Caption = '-'
        TabOrder = 2
        Visible = False
      end
      object lbContacts: TVirtualStringTree
        Left = 0
        Top = 82
        Width = 257
        Height = 380
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clGradientActiveCaption
        DragOperations = []
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.MainColumn = -1
        Images = ImageListStatuses
        Indent = 2
        PopupMenu = pmContacts
        TabOrder = 0
        TreeOptions.MiscOptions = [toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning]
        TreeOptions.PaintOptions = [toShowRoot, toThemeAware, toUseBlendedImages]
        TreeOptions.SelectionOptions = [toFullRowSelect]
        TreeOptions.StringOptions = [toSaveCaptions]
        OnFocusChanged = lbContactsFocusChanged
        OnFocusChanging = lbContactsFocusChanging
        OnGetText = lbContactsGetText
        OnGetImageIndex = lbContactsGetImageIndex
        OnGetNodeDataSize = lbContactsGetNodeDataSize
        OnInitNode = lbContactsInitNode
        Columns = <>
      end
    end
  end
  object pnlRight: TPanel
    Left = 260
    Top = 0
    Width = 477
    Height = 503
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlRight'
    Color = clGradientActiveCaption
    ParentBackground = False
    TabOrder = 2
    object SplitterRight: TSplitter
      Left = 0
      Top = 289
      Width = 477
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Beveled = True
      OnMoved = SplitterRightMoved
      ExplicitLeft = 3
      ExplicitTop = 348
    end
    object pnlChat: TPanel
      Left = 0
      Top = 292
      Width = 477
      Height = 211
      Align = alClient
      BevelEdges = []
      BevelOuter = bvNone
      Caption = 'pnlChat'
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 0
      object SplitterChat: TSplitter
        Left = 0
        Top = 121
        Width = 477
        Height = 4
        Cursor = crVSplit
        Align = alBottom
        Color = clGradientActiveCaption
        ParentColor = False
        OnMoved = SplitterRightMoved
        ExplicitLeft = 1
        ExplicitTop = 112
        ExplicitWidth = 471
      end
      object pnlMessage: TPanel
        Left = 0
        Top = 125
        Width = 477
        Height = 86
        Align = alBottom
        BevelEdges = []
        BevelOuter = bvNone
        Caption = 'pnlMessage'
        Color = clGradientActiveCaption
        ParentBackground = False
        TabOrder = 0
        ExplicitLeft = 1
        ExplicitTop = 124
        ExplicitWidth = 475
        DesignSize = (
          477
          86)
        object MemoMessage: TMemo
          Left = 104
          Top = 0
          Width = 274
          Height = 86
          Align = alCustom
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnKeyUp = MemoMessageKeyUp
        end
        object btnSend: TButton
          Left = 384
          Top = 7
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Send'
          TabOrder = 1
          OnClick = btnSendClick
        end
        object Button1: TButton
          Left = 384
          Top = 55
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'start'
          TabOrder = 2
          OnClick = Button1Click
        end
        object CheckBox2: TCheckBox
          Left = 381
          Top = 38
          Width = 97
          Height = 17
          Anchors = [akRight, akBottom]
          Caption = 'Video'
          TabOrder = 3
          OnClick = CheckBox2Click
        end
      end
      object pnlHistory: TPanel
        Left = 0
        Top = 0
        Width = 477
        Height = 121
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlHistory'
        Color = clGradientActiveCaption
        ParentBackground = False
        TabOrder = 1
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 475
        ExplicitHeight = 119
        object memFPS: TMemo
          Left = 376
          Top = 0
          Width = 101
          Height = 121
          Align = alRight
          BevelEdges = [beLeft]
          BevelKind = bkSoft
          BevelOuter = bvNone
          BorderStyle = bsNone
          ScrollBars = ssVertical
          TabOrder = 1
        end
        object MemoHistory: TVirtualStringTree
          Left = 0
          Top = 0
          Width = 376
          Height = 121
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          Header.AutoSizeIndex = 0
          Header.Font.Charset = DEFAULT_CHARSET
          Header.Font.Color = clWindowText
          Header.Font.Height = -11
          Header.Font.Name = 'Tahoma'
          Header.Font.Style = []
          Header.Options = [hoShowSortGlyphs, hoHeightResize]
          NodeAlignment = naFromTop
          ParentFont = False
          ScrollBarOptions.ScrollBars = ssVertical
          TabOrder = 0
          TreeOptions.AutoOptions = [toAutoScrollOnExpand, toAutoTristateTracking, toAutoDeleteMovedNodes, toDisableAutoscrollOnFocus, toAutoChangeScale]
          TreeOptions.MiscOptions = [toEditable, toFullRepaintOnResize, toInitOnSave, toWheelPanning, toVariableNodeHeight]
          TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowRoot, toThemeAware, toUseBlendedImages]
          TreeOptions.SelectionOptions = [toExtendedFocus]
          OnGetText = MemoHistoryGetText
          OnPaintText = MemoHistoryPaintText
          OnGetNodeDataSize = lbContactsGetNodeDataSize
          OnInitNode = MemoHistoryInitNode
          OnMeasureTextHeight = MemoHistoryMeasureTextHeight
          OnResize = MemoHistoryResize
          ExplicitWidth = 401
          ExplicitHeight = 119
          Columns = <
            item
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible, coFixed, coAllowFocus]
              Position = 0
            end
            item
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible, coFixed, coAllowFocus, coWrapCaption]
              Position = 1
            end
            item
              Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coShowDropMark, coVisible, coFixed, coAllowFocus]
              Position = 2
            end>
        end
      end
    end
    object pnlContactCommon: TPanel
      Left = 0
      Top = 0
      Width = 477
      Height = 289
      Align = alTop
      BevelOuter = bvNone
      Caption = 'pnlContactCommon'
      Color = clGradientActiveCaption
      ParentBackground = False
      TabOrder = 1
      object pnlVideo: TPanel
        Left = 0
        Top = 39
        Width = 477
        Height = 250
        Align = alClient
        BevelOuter = bvNone
        Caption = 'pnlVideo'
        Color = clGradientActiveCaption
        ParentBackground = False
        TabOrder = 0
        object PaintBox1: TPaintBox
          Left = 2
          Top = 4
          Width = 321
          Height = 185
        end
        object ocvView: TocvView
          Left = 368
          Top = 128
          Width = 97
          Height = 65
          VideoSource = ocvCameraSource
          Proportional = True
          Center = True
          Frames = <>
        end
      end
      object pnlContactInfo: TPanel
        Left = 0
        Top = 0
        Width = 477
        Height = 39
        Margins.Left = 30
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Color = clGradientActiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object lblContactInfo: TLabel
          Left = 43
          Top = 10
          Width = 164
          Height = 18
          AutoSize = False
          Caption = '                                         '
        end
        object imgContactStatus: TImage
          Left = 8
          Top = 8
          Width = 25
          Height = 25
          Center = True
          Transparent = True
        end
      end
    end
  end
  object MainMenu: TMainMenu
    Images = ImageListStatuses
    Left = 200
    Top = 224
    object miMili: TMenuItem
      Caption = 'Mili'
      object miStatus: TMenuItem
        Caption = #1057#1090#1072#1090#1091#1089
        object miOnline: TMenuItem
          Caption = #1054#1085#1083#1072#1081#1085
          ImageIndex = 1
        end
        object miOffline: TMenuItem
          Caption = #1054#1092#1092#1083#1072#1081#1085
          ImageIndex = 0
        end
      end
      object miSaveVCard: TMenuItem
        Caption = #1047#1072#1087#1080#1089#1072#1090#1100' '#1074#1080#1079#1080#1090#1082#1091
        OnClick = miSaveVCardClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miExit: TMenuItem
        Caption = #1042#1099#1093#1086#1076
        OnClick = miExitClick
      end
    end
    object miContacts: TMenuItem
      Caption = #1050#1086#1085#1090#1072#1082#1090#1099
      object miLoadVCard: TMenuItem
        Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1074#1080#1079#1080#1090#1082#1091
        OnClick = miLoadVCardClick
      end
    end
    object miCalls: TMenuItem
      Caption = #1047#1074#1086#1085#1082#1080
    end
    object miTools: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      object miSettings: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080'...'
        OnClick = miSettingsClick
      end
    end
    object miHelp: TMenuItem
      Caption = #1055#1086#1084#1086#1097#1100
      object miAbout: TMenuItem
        Caption = 'O MiLi...'
      end
    end
  end
  object IdAntiFreeze: TIdAntiFreeze
    Left = 192
    Top = 24
  end
  object ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 336
    Top = 40
  end
  object ocvCameraSource: TocvCameraSource
    OnImage = ocvCameraSourceImage
    Camera = CAP_CAM_1
    Resolution = r640x360
    Left = 365
    Top = 325
  end
  object ImageListStatuses: TImageList
    BkColor = clWhite
    DrawingStyle = dsTransparent
    Masked = False
    ShareImages = True
    Left = 580
    Top = 40
    Bitmap = {
      494C010102005400540010001000FFFFFF00FF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFFFE00F5FCFA0064D5B10008BC
      830008BC8300F5FCFA00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FEFFFE00F5FCFA0064D5B10008BC
      830008BC8300F5FCFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F4FCF90086DEC2002CC6950001BA800012BF880000BA7F0000BA
      7F0000BA7F0061D4B000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00DBF5ED0026C492001EC28E000000FF000000FF000000FF000000FF000000
      FF000000FF0008BC8300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4FC
      F90026C4920000BA7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA
      7F0000BA7F0008BC8300FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00F4FC
      F90026C4920051D0A8000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF0008BC8300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0086DE
      C20000BA7F0000BA7F0000BA7F0063D5B10000BA7F0000BA7F0000BA7F0000BA
      7F0000BA7F0064D5B100FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF0086DE
      C2001EC28E000000FF00FFFFFF00FFFFFF000000FF00FFFFFF00FFFFFF000000
      FF000000FF0064D5B100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF002CC6
      950000BA7F0000BA7F006DD7B600FFFFFF005BD3AD0000BA7F0000BA7F0000BA
      7F0000BA7F00F5FCFA00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF002CC6
      95000000FF000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF00F5FCFA00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0005BB
      820000BA7F0020C38F00FDFEFE00B1EAD800FFFFFF0067D6B30000BA7F0000BA
      7F0000BA7F00FEFFFE00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF0005BB
      82000000FF000000FF000000FF00FFFFFF00FFFFFF00FFFFFF000000FF000000
      FF000000FF00FEFFFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001BA
      800000BA7F0003BB810045CDA20003BB8100EBFAF500FDFEFE0052D0A80000BA
      7F0000BA7F00FEFFFE00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF0014C0
      89000000FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      FF006DD7B600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000BA
      7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA7F0012BF880077DABB000BBD
      850000BA7F00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF004BCE
      A5000000FF00FFFFFF00FFFFFF000000FF000000FF00FFFFFF00FFFFFF000000
      FF0010BE8700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000BA
      7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA
      7F0026C49200FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0037C9
      9B0026C49200FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000BA
      7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA7F0000BA7F0026C4
      9200DBF5ED00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF003ACA
      9C000000FF000000FF000000FF000000FF000000FF000000FF0012BF880026C4
      9200DBF5ED00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000BA
      7F0000BA7F0000BA7F0000BA7F0012BF880005BB82002CC6950086DEC200F4FC
      F900FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF0000BA
      7F002FC797000000FF0041CCA00013BF890005BB82002CC6950086DEC200F4FC
      F900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0061D4
      B00008BC830008BC830064D5B100F5FCFA00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF00000000FFFFFF0300000000
      FF03F80300000000F003E00300000000E003E00300000000E363E10300000000
      E3E3E08300000000E1C3E00300000000E7E7E00700000000E667E00700000000
      E007E00700000000E007E00F00000000E00FE0FF00000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object pmContacts: TPopupMenu
    OnPopup = pmContactsPopup
    Left = 128
    Top = 337
    object miSetConnection: TMenuItem
      Caption = 'Connect'
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miDelete: TMenuItem
      Caption = 'Delete'
    end
  end
  object ocvFileSource1: TocvFileSource
    OnImage = ocvFileSource1Image
    Left = 373
    Top = 428
  end
  object SaveDialog: TSaveDialog
    Left = 56
    Top = 161
  end
  object OpenDialog: TOpenDialog
    Left = 136
    Top = 161
  end
end
