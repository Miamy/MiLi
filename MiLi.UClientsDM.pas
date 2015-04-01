unit MiLi.UClientsDM;

interface

uses
  System.SysUtils, System.Classes, MiLi.UContacts, MiLi.UStrings,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, Vcl.ExtCtrls, Forms,
  IdIntercept, IdLogBase, IdLogFile, IdTCPConnection, IdTCPClient, IdGlobal,
  MiLi.UTypes;

type
  TClientsDM = class(TDataModule)
    UDPClientStatus: TIdUDPClient;
    TimerStatuses: TTimer;
    IdLogFile: TIdLogFile;
    ClientVideo: TIdTCPClient;
    ClientMessages: TIdTCPClient;
    UDPClientVideo: TIdUDPClient;
    procedure TimerStatusesTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    FConnected: boolean;
    FInWork: array[TMessageKind] of boolean;
    procedure SetConnected(const Value: boolean);
    procedure SetNotifyMessage(aMessage: integer);

    function GetClient(aKind: TMessageKind): TIdComponent;
    function GetInWork(Index: TMessageKind): boolean;
    procedure SetInWork(Index: TMessageKind; const Value: boolean);
  public
    { Public declarations }
    function SendStringBySlices(aKind: TMessageKind; aContact: TContact;
      const aCodedStr: string; aEncoding: IIdTextEncoding = nil): boolean;

    property Connected: boolean read FConnected write SetConnected;
    property InWork[Index: TMessageKind]: boolean read GetInWork write SetInWork;
  end;

var
  ClientsDM: TClientsDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses Mili.UConsts, Mili.UFunctions, Mili.USettings;

{$R *.dfm}

procedure TClientsDM.DataModuleCreate(Sender: TObject);
begin
  IdLogFile.Filename := GetAppDir + 'log.txt';
end;

procedure TClientsDM.SetConnected(const Value: boolean);
begin
  if FConnected = Value then
    exit;
  FConnected := Value;
  TimerStatuses.Enabled := FConnected;
  IdLogFile.Active := FConnected;
  if FConnected then
    SetNotifyMessage(CmdImOnline)
  else
    SetNotifyMessage(CmdImOffline);
end;

procedure TClientsDM.SetInWork(Index: TMessageKind; const Value: boolean);
begin
  FInWork[Index] := Value;
end;

procedure TClientsDM.SetNotifyMessage(aMessage: integer);
var
  i: integer;
begin
  for i := 0 to Contacts.Items.Count - 1 do
  begin
    if Application.Terminated then
      break;
    if Contacts.Items[i].InternalIP.IsEmpty then
      continue;
    if Contacts.Items[i].InternalIP = TSettings.IP then
      continue;
    if not Contacts.Items[i].IsValid then
      continue;

    UDPClientStatus.BoundIP := TSettings.IP;
    UDPClientStatus.BoundPort := TSettings.Port + Ord(mkNotify) + ClientServerPortDiff;
    UDPClientStatus.Send(Contacts.Items[i].ExternalIP,
      Contacts.Items[i].Port + Ord(mkNotify),
        IntToStr(aMessage) + ' ' + TSettings.UniqueName + ' ' + TSettings.FriendlyName +
        ' ' + TSettings.IP + ':' + IntToStr(TSettings.Port));
  end;
end;

function TClientsDM.GetClient(aKind: TMessageKind): TIdComponent;
begin
  Result := nil;
  case aKind of
    mkText:
      Result := ClientMessages;
    mkVideo:
      Result := ClientVideo;
    mkAudio: ;
    mkFile: ;
  end;
end;


function TClientsDM.GetInWork(Index: TMessageKind): boolean;
begin
  Result := FInWork[Index];
end;

function TClientsDM.SendStringBySlices(aKind: TMessageKind; aContact: TContact;
  const aCodedStr: string; aEncoding: IIdTextEncoding = nil): boolean;
var
  DataStr, Slice: string;
  Client: TIdComponent;
  TCPClient: TIdTCPClient;
begin
  Result := false;
  if not Assigned(aContact) or not aContact.IsValid then
    exit;

  Client := GetClient(aKind);
  if not Assigned(Client) or not (Client is TIdTCPClient) then
    exit;

  TCPClient := TIdTCPClient(Client);

  if InWork[aKind] then
    exit;

(*  if aKind = mkVideo then
  begin
    UDPClientVideo.BoundIP := TSettings.IP;
    UDPClientVideo.BoundPort := TSettings.Port + Ord(mkVideo) + ClientServerPortDiff;

  InWork[aKind] := true;
  try
     UDPClientVideo.Send(aContact.ExternalIP,
      aContact.Port + Ord(mkVideo), 'BEGIN');

    DataStr := aCodedStr;
    while Length(DataStr) > DefPacketSize do
    begin
      if Application.Terminated then
        exit;

      Slice := Copy(DataStr, 1, DefPacketSize);
      DataStr := Copy(DataStr, DefPacketSize + 1, MaxInt);
      UDPClientVideo.Send(aContact.ExternalIP,
      aContact.Port + Ord(mkVideo), Slice);

    end;
    if Length(DataStr) > 0 then
        UDPClientVideo.Send(aContact.ExternalIP,
      aContact.Port + Ord(mkVideo), DataStr);

    UDPClientVideo.Send(aContact.ExternalIP,
      aContact.Port + Ord(mkVideo), 'END');
  finally
    InWork[aKind] := false;
  end;

  end;
*)

  if TCPClient.Host <> aContact.InternalIP then
  begin
    if TCPClient.Connected then
      TCPClient.Disconnect;

    TCPClient.BoundIP := TSettings.IP;
    TCPClient.BoundPort := TSettings.Port + Ord(aKind) + ClientServerPortDiff;
    TCPClient.Host := aContact.ExternalIP;
    TCPClient.Port := aContact.Port + Ord(aKind);
    TCPClient.Connect;
    TCPClient.GetResponse(CmdOk);
  end;

  InWork[aKind] := true;
  try
    TCPClient.SendCmd('BEGIN', CmdOk);
    DataStr := aCodedStr;
    while Length(DataStr) > DefPacketSize do
    begin
      if Application.Terminated then
        exit;

      Slice := Copy(DataStr, 1, DefPacketSize);
      DataStr := Copy(DataStr, DefPacketSize + 1, MaxInt);
      TCPClient.SendCmd(Slice, CmdOk, aEncoding);
    end;
    if Length(DataStr) > 0 then
      TCPClient.SendCmd(DataStr, CmdOk, aEncoding);
    TCPClient.SendCmd('END', CmdOk);
  finally
    InWork[aKind] := false;
  end;
  Result := true;
end;

procedure TClientsDM.TimerStatusesTimer(Sender: TObject);
begin
  TimerStatuses.Enabled := false;
  try
    SetNotifyMessage(CmdImOnline);
  finally
    TimerStatuses.Enabled := Connected and not Application.Terminated;
  end;
end;

end.
