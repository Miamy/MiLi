object ServersDM: TServersDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 246
  Width = 328
  object ServerStatus: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = ServerStatusUDPRead
    Left = 48
    Top = 24
  end
  object ServerMessages: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    Intercept = IdServerInterceptLogFile
    OnConnect = ServerMessagesConnect
    OnExecute = ServerMessagesExecute
    Left = 40
    Top = 104
  end
  object IdLogEvent: TIdLogEvent
    Left = 168
    Top = 40
  end
  object IdServerInterceptLogFile: TIdServerInterceptLogFile
    Left = 168
    Top = 110
  end
  object ServerVideo: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    OnConnect = ServerMessagesConnect
    OnExecute = ServerVideoExecute
    Left = 48
    Top = 176
  end
  object UDPServerVideo: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = UDPServerVideoUDPRead
    Left = 176
    Top = 176
  end
end
