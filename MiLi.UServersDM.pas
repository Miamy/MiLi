unit MiLi.UServersDM;

interface

uses
  System.SysUtils, System.Classes, MiLi.UContacts, MiLi.UStrings, Dialogs,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPServer, IdGlobal, IdSocketHandle,
  IdContext, IdCustomTCPServer, IdTCPServer, StrUtils, IdIntercept,
  IdServerInterceptLogBase, IdServerInterceptLogFile, IdLogBase, IdLogEvent, Forms,
  MiLi.UTypes;

type
  TTCPServerEvent = procedure(Sender: TObject; const aData: string) of object;

  TServersDM = class(TDataModule)
    ServerStatus: TIdUDPServer;
    ServerMessages: TIdTCPServer;
    IdLogEvent: TIdLogEvent;
    IdServerInterceptLogFile: TIdServerInterceptLogFile;
    ServerVideo: TIdTCPServer;
    UDPServerVideo: TIdUDPServer;

    procedure DataModuleCreate(Sender: TObject);

    procedure ServerStatusUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure UDPServerVideoUDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);

    procedure ServerMessagesConnect(AContext: TIdContext);
    procedure ServerMessagesExecute(AContext: TIdContext);
    procedure ServerVideoExecute(AContext: TIdContext);
  private
    FConnected: boolean;
    ImageString, MessageString: string;
    VideoInWork, MessageInWork: boolean;

    FOnClientStatusChanged: TTCPServerEvent;
    FOnClientDisconnected: TTCPServerEvent;
    FOnImageReceived: TTCPServerEvent;
    FOnTextMessageReceived: TTCPServerEvent;
    FOnClientConnected: TTCPServerEvent;

    procedure SetConnected(const Value: boolean);
    procedure SendOkToClient(AContext: TIdContext);

    procedure SetupServerInstance(aServer: TIdTCPServer; aPort: Word);
    function IsPacketIllegal(aContext: TIdContext; aKind: TMessageKind): boolean;
  public
    { Public declarations }
    property Connected: boolean read FConnected write SetConnected;
    property OnClientStatusChanged: TTCPServerEvent read FOnClientStatusChanged write FOnClientStatusChanged;
    property OnClientConnected: TTCPServerEvent read FOnClientConnected write FOnClientConnected;
    property OnClientDisconnected: TTCPServerEvent read FOnClientDisconnected write FOnClientDisconnected;
    property OnTextMessageReceived: TTCPServerEvent read FOnTextMessageReceived write FOnTextMessageReceived;
    property OnImageReceived: TTCPServerEvent read FOnImageReceived write FOnImageReceived;
  end;

var
  ServersDM: TServersDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Mili.UConsts, Mili.UFunctions, Mili.USettings;

{$R *.dfm}

{ TServersDM }

procedure TServersDM.DataModuleCreate(Sender: TObject);
begin
  IdServerInterceptLogFile.Filename := GetAppDir + 'log_srv.txt';
end;

procedure TServersDM.ServerMessagesConnect(AContext: TIdContext);
begin
  SendOkToClient(AContext);
end;

procedure TServersDM.ServerMessagesExecute(AContext: TIdContext);
var
  ReceivedString: string;
begin
  if IsPacketIllegal(AContext, mkText) then
    exit;
  with AContext.Connection.IOHandler do
  try
    {$IFDEF VER240}
      ReceivedString := ReadLn(TEncoding.UTF8);
    {$ELSE}
      ReceivedString := ReadLn(IndyTextEncoding_UTF8);
    {$ENDIF}
    if not MessageInWork and (ReceivedString = 'BEGIN') then
    begin
      MessageString := '';
      MessageInWork := true;
    end
    else if MessageInWork and (ReceivedString = 'END') then
    begin
      if Assigned(OnTextMessageReceived) then
        OnTextMessageReceived(AContext, StrFromSendStr(MessageString));
      MessageInWork := false;
    end
    else if MessageInWork then
      MessageString := MessageString + ReceivedString;
    SendOkToClient(AContext);
//{  AContext.Connection.IOHandler.}WriteLn(IntToStr(CmdOk));

  except
    on E: Exception do
    begin
      WriteLn('500-Unknown Internal Error');
      WriteLn('500 ' + StringReplace(E.Message, #10, ' ', [rfReplaceAll]));
      raise;
    end;
  end;
end;


function TServersDM.IsPacketIllegal(aContext: TIdContext; aKind: TMessageKind): boolean;
begin
  Result := //aContext.Connection.Connected or not aContext.Connection.IOHandler.Connected or
     (aContext.Binding.Port <> TSettings.Port + Ord(aKind) {+ ClientServerPortDiff}) or
     (aContext.Binding.PeerIP = TSettings.IP);
end;

procedure TServersDM.SendOkToClient(AContext: TIdContext);
begin
//  if AContext.Connection.IOHandler.Host.IsEmpty then
//    AContext.Connection.IOHandler.Host :=
//      AContext.Connection.Socket.Binding.PeerIP;
//  if AContext.Connection.IOHandler.Port = 0 then
//    AContext.Connection.IOHandler.Port :=
//      AContext.Connection.Socket.Binding.Port - ClientServerPortDiff;

//    AContext.Connection.Socket.Port :=
//      AContext.Connection.Socket.Binding.Port - ClientServerPortDiff;

  AContext.Connection.Socket.WriteLn(IntToStr(CmdOk));
end;

procedure TServersDM.SetConnected(const Value: boolean);
begin
  FConnected := Value;

  ServerStatus.DefaultPort := TSettings.Port + Ord(mkNotify);
  ServerStatus.Active := FConnected;

//  UDPServerVideo.DefaultPort := TSettings.Port + Ord(mkVideo);
//  UDPServerVideo.Active := FConnected;

  SetupServerInstance(ServerMessages, TSettings.Port + Ord(mkText));
  SetupServerInstance(ServerVideo, TSettings.Port + Ord(mkVideo));
end;

procedure TServersDM.SetupServerInstance(aServer: TIdTCPServer; aPort: Word);
begin
  aServer.DefaultPort := aPort;
  if not Connected then
    aServer.StopListening;
  aServer.Active := Connected;
  if Connected then
    aServer.StartListening;
end;

procedure TServersDM.ServerStatusUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  if Assigned(OnClientStatusChanged) then
    OnClientStatusChanged(ABinding, BytesToString(AData));
end;

procedure TServersDM.ServerVideoExecute(AContext: TIdContext);
var
  ReceivedString: string;
begin
  if IsPacketIllegal(AContext, mkVideo) then
    exit;

  with AContext.Connection.IOHandler do
  try
    ReceivedString := ReadLn;
    if not VideoInWork and (ReceivedString = 'BEGIN') then
    begin
      ImageString := '';
      VideoInWork := true;
    end
    else if VideoInWork and (ReceivedString = 'END') then
    begin
      if Assigned(OnImageReceived) then
        OnImageReceived(AContext, ImageString);
      VideoInWork := false;
    end
    else if VideoInWork then
      ImageString := ImageString + ReceivedString;
    SendOkToClient(AContext);
  except
    on E: Exception do
    begin
      raise;
    end;
  end;
end;

procedure TServersDM.UDPServerVideoUDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  ReceivedString: string;
begin
//  if IsPacketIllegal(AContext, mkVideo) then
    exit;

//  with AContext.Connection.IOHandler do
  try
    ReceivedString := BytesToString(AData);
    if not VideoInWork and (ReceivedString = 'BEGIN') then
    begin
      ImageString := '';
      VideoInWork := true;
    end
    else if VideoInWork and (ReceivedString = 'END') then
    begin
      if Assigned(OnImageReceived) then
        OnImageReceived(ABinding, ImageString);
      VideoInWork := false;
    end
    else if VideoInWork then
      ImageString := ImageString + ReceivedString;
//    SendOkToClient(AContext);
  except
    on E: Exception do
    begin
      raise;
    end;
  end;
end;

end.
