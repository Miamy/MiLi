unit MiLi.UContacts;

interface

uses
  Classes, Windows, IniFiles, SysUtils, Forms, IdHTTP, Vcl.ComCtrls,
  System.Generics.Collections, Mili.UHistory;

type
  TContact = class
  private
    FUniqueName: string;
    FFriendlyName: string;
    FInternalIP: string;
    FExternalIP: string;
    FPort: Word;
    FOnline: boolean;
    FConnected: boolean;
    FHistory: THistory;
    function GetHistory: THistory;
  public
    constructor Create(const aUniqueName: string); reintroduce; overload;
    constructor Create; overload;
    destructor Destroy; override;

    procedure LoadFromFile(aReader: TReader);
    procedure SaveToFile(aWriter: TWriter);

    procedure Load(aIniFile: TIniFile);
    procedure Save(aIniFile: TIniFile);

    function IsValid: boolean;

    property UniqueName: string read FUniqueName write FUniqueName;
    property FriendlyName: string read FFriendlyName write FFriendlyName;
    property InternalIP: string read FInternalIP write FInternalIP;
    property ExternalIP: string read FExternalIP write FExternalIP;
    property Port: Word read FPort write FPort;

    property Online: boolean read FOnline write FOnline;
    property Connected: boolean read FConnected write FConnected;
    property History: THistory read GetHistory;
  end;
  TContactClass = class of TContact;

  TContacts = class
  private
    FItems: TObjectList<TContact>;
  protected
    function GetFileName: string;
  public
    constructor Create;
    destructor Destroy; override;

    procedure FillList(aList: TListItems);
    procedure LoadFromFile;
    procedure SaveToFile;
    procedure Load;
    procedure Save;

    function FindByUniqueName(const aName: string): TContact;
    procedure Disconnect;
    procedure BringOffline;

    property Items: TObjectList<TContact> read FItems write FItems;
  end;


var
  Contacts: TContacts;

implementation

{ TContact }

uses
  Mili.UFunctions, Mili.USettings, Mili.UConsts;

constructor TContact.Create(const aUniqueName: string);
begin
  inherited Create;
  FUniqueName := aUniqueName;
end;

constructor TContact.Create;
begin
  inherited Create;
  FUniqueName := GetUniqueString;
  FOnline := false;
  FConnected := false;
end;

destructor TContact.Destroy;
begin
  if Assigned(FHistory) then
    FHistory.Free;
  inherited;
end;

function TContact.GetHistory: THistory;
begin
  if not Assigned(FHistory) then
    FHistory := THistory.Create(FUniqueName);
  Result := FHistory;
end;

function TContact.IsValid: boolean;
begin
  Result := (InternalIP <> ZeroIP) and (ExternalIP <> ZeroIP) and
    (Port <> 0);
end;

procedure TContact.Load(aIniFile: TIniFile);
begin
  FUniqueName := aIniFile.ReadString(FUniqueName, 'UniqueName',  '');
  FFriendlyName := aIniFile.ReadString(FUniqueName, 'FriendlyName',  '');
  FInternalIP := aIniFile.ReadString(FUniqueName, 'InternalIP',  '');
  FExternalIP := aIniFile.ReadString(FUniqueName, 'ExternalIP',  '');
  FPort := aIniFile.ReadInteger(FUniqueName, 'Port',  0);
end;

procedure TContact.LoadFromFile(aReader: TReader);
begin
  FriendlyName := aReader.ReadString;
  InternalIP := aReader.ReadString;
  Port := aReader.ReadInteger;
end;

procedure TContact.Save(aIniFile: TIniFile);
begin
  aIniFile.WriteString(FUniqueName, 'UniqueName',  FUniqueName);
  aIniFile.WriteString(FUniqueName, 'FriendlyName',  FFriendlyName);
  aIniFile.WriteString(FUniqueName, 'InternalIP',  FInternalIP);
  aIniFile.WriteString(FUniqueName, 'ExternalIP',  FExternalIP);
  aIniFile.WriteInteger(FUniqueName, 'Port',  FPort);
end;

procedure TContact.SaveToFile(aWriter: TWriter);
begin
  aWriter.WriteString(FriendlyName);
  aWriter.WriteString(InternalIP);
  aWriter.WriteInteger(Port);
end;

{ TContacts }

procedure TContacts.BringOffline;
var
  Contact: TContact;
begin
  for Contact in FItems do
    Contact.Online := false;
end;

constructor TContacts.Create;
begin
  FItems := TObjectList<TContact>.Create;
end;

destructor TContacts.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TContacts.Disconnect;
var
  Contact: TContact;
begin
  for Contact in FItems do
    Contact.Connected := false;
end;

procedure TContacts.FillList(aList: TListItems);
var
  Contact: TContact;
begin
  aList.Clear;
  for Contact in FItems do
    aList.Add.Caption := Contact.FriendlyName;
end;

function TContacts.FindByUniqueName(const aName: string): TContact;
var
  Contact: TContact;
begin
  for Contact in FItems do
    if Contact.UniqueName = aName then
    begin
      Result := Contact;
      exit;
    end;
  Result := nil;
end;

function TContacts.GetFileName: string;
begin
  Result := GetDataDir + ContactListFileName;
end;

procedure TContacts.Load;
var
 IniFile: TIniFile;
 Sections: TStringList;
 i: integer;
 Contact: TContact;
begin
  FItems.Clear;
  if not FileExists(GetFileName) then
    exit;
  Sections := TStringList.Create;
  IniFile := TIniFile.Create(GetFileName);
  try
    IniFile.ReadSections(Sections);
    for i := 0 to Sections.Count - 1 do
    begin
      Contact := TContactClass.Create(Sections[i]);
      Contact.Load(IniFile);
      FItems.Add(Contact);
    end;
  finally
    IniFile.Free;
    Sections.Free;
  end;
end;

procedure TContacts.LoadFromFile;
var
  Stream: TStream;
  Reader: TReader;
  Contact: TContact;
begin
  FItems.Clear;
  if not FileExists(GetFileName) then
    exit;
  Stream := TFileStream.Create(GetFileName, fmOpenRead);
  try
    Reader := TReader.Create(Stream, 64);
    try
      while not Reader.EndOfList do
      begin
        Contact := TContactClass.Create;
        Contact.LoadFromFile(Reader);
        FItems.Add(Contact);
//      Reader.Close;
      end;
    finally
      Reader.Free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TContacts.Save;
var
 IniFile: TIniFile;
 Contact: TContact;
begin
  IniFile := TIniFile.Create(GetFileName);
  try
    for Contact in FItems do
    begin
      Contact.Save(IniFile);
    end;
  finally
    IniFile.Free;
  end;
end;

procedure TContacts.SaveToFile;
var
  Stream: TStream;
  Writer: TWriter;
  Contact: TContact;
begin
  Stream := TFileStream.Create(GetFileName, fmCreate);
  try
    Writer := TWriter.Create(Stream, 64);
    try
      for Contact in FItems do
        Contact.SaveToFile(Writer);
//      Writer.Close;
    finally
      Writer.Free;
    end;
  finally
    Stream.Free;
  end;
end;

end.
