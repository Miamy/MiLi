unit Mili.UHistory;

interface

uses
  System.Generics.Collections, System.SysUtils, Classes, MiLi.UTypes, StrUtils;

type
  THistoryItem = class(TPersistent)
  private
    FOwn: boolean;
    FTimeStamp: TDateTime;
    FDelivered: boolean;

    function GetDate: string;
    function GetTime: string;
    function GetIntTimeStamp: string;
  protected
//    function GetId: string; virtual; abstract;
    function Save: string;
    function GetAdditionalInfo: string; virtual;
    procedure SetAdditionalInfo(const Value: string); virtual;

  public
    constructor Create(aOwn: boolean; aTimeStamp: TDateTime); overload;
    constructor Create(aOwn: boolean; const aDateTime: string); overload;
    constructor Create(aOwn: boolean; const aDateTime, anAdditional: string); overload; virtual; abstract;

    property Own: boolean read FOwn;
    property TimeStamp: TDateTime read FTimeStamp write FTimeStamp;
    property Date: string read GetDate;
    property Time: string read GetTime;
    property IntTimeStamp: string read GetIntTimeStamp;

    property AdditionalInfo: string read GetAdditionalInfo write SetAdditionalInfo;
    property Delivered: boolean read FDelivered write FDelivered;
  end;
  THistoryItemClass = class of THistoryItem;

  TFileItem = class(THistoryItem)
  private
    FFileName: string;
  protected
    function GetAdditionalInfo: string; override;
    procedure SetAdditionalInfo(const Value: string); override;
  public
    constructor Create(aOwn: boolean; const aDateTime, anAdditional: string); override;
    property FileName: string read GetAdditionalInfo write SetAdditionalInfo;
  end;
  TFileItemClass = class of TFileItem;

  TTextItem = class(THistoryItem)
  private
    FMessage: string;
  protected
    function GetAdditionalInfo: string; override;
    procedure SetAdditionalInfo(const Value: string); override;
  public
    constructor Create(aOwn: boolean; const aDateTime, anAdditional: string); override;
    property MessageText: string read GetAdditionalInfo write SetAdditionalInfo;
  end;
  TTextItemClass = class of TTextItem;

  TServiceItem = class(THistoryItem)
  private
    FServiceMessage: TServiceMessage;
    FServiceMessageStr: string;
  protected
    function GetAdditionalInfo: string; override;
    procedure SetAdditionalInfo(const Value: string); override;
  public
    constructor Create(aOwn: boolean; const aDateTime, anAdditional: string); override;
    property ServiceMessageStr: string read GetAdditionalInfo write SetAdditionalInfo;
  end;
  TServiceItemClass = class of TServiceItem;

  THistoryItemFactory = class
  public
    class function CreateItem(const aDescription: string): THistoryItem;
  end;

  THistory = class
  private
    FInterlocutor: string;
    FItems: TObjectList<THistoryItem>;
    function GetFileName: string;
  public
    constructor Create(const aInterlocutor: string);
    destructor Destroy; override;

    procedure Load;
    procedure Save;

    function AddTextMessage(aOwn: boolean; const aMessageText: string): integer;
    function AddFileMessage(aOwn: boolean; const aMessageText: string): integer;
    function AddServiceMessage(aOwn: boolean; const aMessageText: string): integer;

    property Interlocutor: string read FInterlocutor;
    property FileName: string read GetFileName;
    property Items: TObjectList<THistoryItem> read FItems write FItems;
  end;


implementation

uses
  Mili.UFunctions, Mili.UConsts;

{ THistory }

function THistory.AddFileMessage(aOwn: boolean; const aMessageText: string): integer;
begin
  Result := FItems.Add(TFileItem.Create(aOwn, '', aMessageText));
end;

function THistory.AddServiceMessage(aOwn: boolean; const aMessageText: string): integer;
begin
  Result := FItems.Add(TServiceItem.Create(aOwn, '', aMessageText));
end;

function THistory.AddTextMessage(aOwn: boolean; const aMessageText: string): integer;
begin
  Result := FItems.Add(TTextItem.Create(aOwn, '', aMessageText));
end;

constructor THistory.Create(const aInterlocutor: string);
begin
  FInterlocutor := aInterlocutor;
  FItems := TObjectList<THistoryItem>.Create;
end;

destructor THistory.Destroy;
begin
  FItems.Free;
  inherited;
end;

function THistory.GetFileName: string;
begin
  Result := GetDataDir + Interlocutor + '.dat';
end;

procedure THistory.Load;
var
  i: integer;
  Strings: TStringList;
begin
  if not FileExists(FileName) then
    exit;

  FItems.Clear;
  Strings := TStringList.Create;
  try
    Strings.LoadFromFile(FileName);
    for i := 0 to Strings.Count - 1 do
      if not Strings[i].IsEmpty then
        FItems.Add(THistoryItemFactory.CreateItem(Strings[i]));
  finally
    Strings.Free;
  end;
end;

procedure THistory.Save;
var
  i: integer;
  Strings: TStringList;
begin
  Strings := TStringList.Create;
  try
    for i := 0 to FItems.Count - 1 do
      Strings.Add(FItems[i].Save);

    Strings.SaveToFile(FileName);
  finally
    Strings.Free;
  end;
end;

{ THistoryItem }

constructor THistoryItem.Create(aOwn: boolean; aTimeStamp: TDateTime);
begin
  FOwn := aOwn;
  FTimeStamp := aTimeStamp;
end;


constructor THistoryItem.Create(aOwn: boolean; const aDateTime: string);
var
  CurrDateTime: string;
begin
  if aDateTime = '' then
    Create(aOwn, Now)
  else
  begin
    CurrDateTime := ReplaceStr(aDateTime, '.', FormatSettings.DecimalSeparator);
    CurrDateTime := ReplaceStr(CurrDateTime, ',', FormatSettings.DecimalSeparator);
    Create(aOwn, StrToFloatDef(CurrDateTime, Now));
  end;
end;

function THistoryItem.GetAdditionalInfo: string;
begin
  Result := '';
end;

function THistoryItem.GetDate: string;
begin
  Result := FormatDateTime('d mmm yy', FTimeStamp);
end;

function THistoryItem.GetIntTimeStamp: string;
begin
  Result := FloatToStr(FTimeStamp);
end;

function THistoryItem.GetTime: string;
begin
  Result := FormatDateTime('hh:nn', FTimeStamp);
end;

function THistoryItem.Save: string;
begin
  Result := ClassName + HistoryItemsDelimiter + IntToStr(Ord(Own)) + HistoryItemsDelimiter +
    IntTimeStamp + HistoryItemsDelimiter + AdditionalInfo + HistoryItemsDelimiter +
    IntToStr(Ord(Delivered));
  Result := StrToSendStr(Result);
end;

procedure THistoryItem.SetAdditionalInfo(const Value: string);
begin
end;

{ THistoryItemFactory }

class function THistoryItemFactory.CreateItem(
  const aDescription: string): THistoryItem;
var
  ItemClassName: string;
  Item: THistoryItemClass;
  Description: string;
begin
  Description := StrFromSendStr(aDescription);
  ItemClassName := GetToken(Description, HistoryItemsDelimiter, 1);
  Item := THistoryItemClass(GetClass(ItemClassName));
  Result := Item.Create(
    GetToken(Description, HistoryItemsDelimiter, 2) = '1',
    GetToken(Description, HistoryItemsDelimiter, 3),
    GetToken(Description, HistoryItemsDelimiter, 4));
  Result.Delivered := StrToIntDef(GetToken(Description, HistoryItemsDelimiter, 5), 1) = 1;
end;

{ TFileItem }

constructor TFileItem.Create(aOwn: boolean; const aDateTime,
  anAdditional: string);
begin
  inherited Create(aOwn, aDateTime);
  FileName := anAdditional;
end;

function TFileItem.GetAdditionalInfo: string;
begin
  Result := FFileName;
end;

procedure TFileItem.SetAdditionalInfo(const Value: string);
begin
  FFileName := Value;
end;

{ TServiceItem }

constructor TServiceItem.Create(aOwn: boolean; const aDateTime,
  anAdditional: string);
begin
  inherited Create(aOwn, aDateTime);
  ServiceMessageStr := anAdditional;
end;


function TServiceItem.GetAdditionalInfo: string;
begin
  Result := FServiceMessageStr;
end;

procedure TServiceItem.SetAdditionalInfo(const Value: string);
begin
  FServiceMessageStr := Value;
  FServiceMessage := TServiceMessage(StrToInt(FServiceMessageStr));
end;

{ TTextItem }

constructor TTextItem.Create(aOwn: boolean; const aDateTime,
  anAdditional: string);
begin
  inherited Create(aOwn, aDateTime);
  MessageText := anAdditional;
end;


function TTextItem.GetAdditionalInfo: string;
begin
  Result := FMessage;
end;

procedure TTextItem.SetAdditionalInfo(const Value: string);
begin
  FMessage := Value;
end;

initialization

  RegisterClasses([TTextItem, TServiceItem, TFileItem]);

finalization

  UnRegisterClasses([TTextItem, TServiceItem, TFileItem]);

end.
