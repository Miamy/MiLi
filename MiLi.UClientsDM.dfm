object ClientsDM: TClientsDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 260
  Width = 318
  object UDPClientStatus: TIdUDPClient
    Port = 0
    Left = 48
    Top = 32
  end
  object TimerStatuses: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = TimerStatusesTimer
    Left = 158
    Top = 28
  end
  object IdLogFile: TIdLogFile
    Left = 182
    Top = 124
  end
  object ClientVideo: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 48
    Top = 112
  end
  object ClientMessages: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 232
    Top = 200
  end
  object UDPClientVideo: TIdUDPClient
    Port = 0
    Left = 48
    Top = 184
  end
end
