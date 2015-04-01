unit MiLi.UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  IdException, Vcl.AppEvnts, IdGlobal, ocv.comp.View, ocv.comp.Types,
  ocv.comp.Source, IdCoderMIME, Jpeg, IdLogDebug, IdLogEvent, IdIntercept,
  IdLogBase, IdLogFile, IdServerInterceptLogBase, IdServerInterceptLogFile,
  Vcl.ImgList, ocv.highgui_c, VirtualTrees, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Menus, Vcl.Controls, IdBaseComponent, IdAntiFreezeBase,
  Vcl.IdAntiFreeze, Forms, MiLi.UContacts, MiLi.UStrings, IdSocketHandle,
  Vcl.Dialogs, Mili.UHistory;

type
  TFMain = class(TForm)
    MainMenu: TMainMenu;
    StatusBar: TStatusBar;
    pnlLeft: TPanel;
    Splitter1: TSplitter;
    pnlRight: TPanel;
    pnlMyInfo: TPanel;
    pnlContacts: TPanel;
    pnlChat: TPanel;
    SplitterRight: TSplitter;
    pnlContactCommon: TPanel;
    pnlVideo: TPanel;
    pnlContactInfo: TPanel;
    pnlMessage: TPanel;
    SplitterChat: TSplitter;
    pnlHistory: TPanel;
    IdAntiFreeze: TIdAntiFreeze;
    cbOnline: TCheckBox;
    MemoMessage: TMemo;
    btnSend: TButton;
    ApplicationEvents: TApplicationEvents;
    btnAddContact: TButton;
    btnDeleteContact: TButton;
    ocvCameraSource: TocvCameraSource;
    ocvView: TocvView;
    PaintBox1: TPaintBox;
    ImageListStatuses: TImageList;
    pmContacts: TPopupMenu;
    miDelete: TMenuItem;
    miSetConnection: TMenuItem;
    N1: TMenuItem;
    ocvFileSource1: TocvFileSource;
    Button1: TButton;
    CheckBox2: TCheckBox;
    Button2: TButton;
    Button3: TButton;
    miMili: TMenuItem;
    miStatus: TMenuItem;
    N2: TMenuItem;
    miExit: TMenuItem;
    miOnline: TMenuItem;
    miOffline: TMenuItem;
    miContacts: TMenuItem;
    miCalls: TMenuItem;
    miTools: TMenuItem;
    miHelp: TMenuItem;
    miAbout: TMenuItem;
    miSettings: TMenuItem;
    memFPS: TMemo;
    lbContacts: TVirtualStringTree;
    lblContactInfo: TLabel;
    imgContactStatus: TImage;
    Button4: TButton;
    MemoHistory: TVirtualStringTree;
    miLoadVCard: TMenuItem;
    miSaveVCard: TMenuItem;
    SaveDialog: TSaveDialog;
    OpenDialog: TOpenDialog;

    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);

    procedure SplitterRightMoved(Sender: TObject);

    procedure cbOnlineClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnAddContactClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);

    procedure ocvCameraSourceImage(Sender: TObject; var IplImage: IocvImage);
    procedure ocvFileSource1Image(Sender: TObject; var IplImage: IocvImage);

    procedure pmContactsPopup(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

    procedure Button1Click(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure miSettingsClick(Sender: TObject);

    procedure lbContactsGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure lbContactsFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure lbContactsFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure lbContactsInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure lbContactsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure lbContactsGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure Button4Click(Sender: TObject);
    procedure miSaveVCardClick(Sender: TObject);
    procedure miLoadVCardClick(Sender: TObject);
    procedure MemoHistoryInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure MemoHistoryGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure MemoHistoryResize(Sender: TObject);
    procedure MemoHistoryPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure MemoHistoryMeasureTextHeight(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      const Text: string; var Extent: Integer);
    procedure MemoMessageKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    SendVideoStream, ReceiveVideoStream: TStringStream;
    jpgSend, jpgReceive: TJpegImage;
    FConnected: boolean;
    ContactIndex, HistoryItemIndex: integer;

    procedure SetVideoWindowVisibility(aVisible: boolean);
    procedure RightSideResize;

    procedure ClientStatusChanged(Sender: TObject; const aData: string);
    procedure TextMessageReceived(Sender: TObject; const aData: string);
    procedure ImageReceived(Sender: TObject; const aData: string);

    procedure SetConnected(aValue: boolean);

    function GetCurrentContact: TContact;
    function GetContactFromNode(aNode: PVirtualNode): TContact;

    function GetStatusBitmap(aValue: boolean): TBitmap;

    procedure FillContactList;
    procedure SelectContact;
    procedure FillHistory;

    procedure CurrContactChanging(aNode: PVirtualNode); overload;
    procedure CurrContactChanging(aContact: TContact); overload;
    procedure CurrContactChanged(aNode: PVirtualNode);
    procedure UpdateContactInfoPanel(aContact: TContact);
  public
    { Public declarations }

    property Connected: boolean read FConnected write SetConnected;
    property CurrentContact: TContact read GetCurrentContact;
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

uses
  MiLi.UContactForm, MiLi.UClientsDM, MiLi.UServersDM, Mili.UFunctions,
  Mili.UConsts, MiLi.UTypes, Mili.USettingsForm, Mili.USettings;


procedure TFMain.ApplicationEventsException(Sender: TObject; E: Exception);
begin
  if E is EIdConnClosedGracefully then
  else if not Application.Terminated then
    Application.ShowException(E);
end;

procedure TFMain.btnAddContactClick(Sender: TObject);
begin
  if TFContactForm.AddContact('') then
//    Contacts.FillList(lbContacts.Items);
end;

procedure TFMain.btnSendClick(Sender: TObject);
var
  LastMessageIndex: integer;
begin
  if MemoMessage.Lines.Text.IsEmpty then
    exit;
  LastMessageIndex := CurrentContact.History.AddTextMessage(true, MemoMessage.Lines.Text);
  FillHistory;
  try
    CurrentContact.History.Items[LastMessageIndex].Delivered :=
      ClientsDM.SendStringBySlices(mkText, CurrentContact,
        StrToSendStr(MemoMessage.Lines.Text), IndyTextEncoding_UTF8);
  except
    on E: Exception do
      if E is EIdConnClosedGracefully then
        CurrentContact.History.Items[LastMessageIndex].Delivered := true
      else
      showmessage(e.message);
  end;
  MemoMessage.Lines.Clear;
end;

procedure TFMain.Button1Click(Sender: TObject);
begin
  ocvFileSource1.Enabled := not ocvFileSource1.Enabled;
  if ocvFileSource1.Enabled then
    Button1.Caption := 'stop'
  else
    Button1.Caption := 'start';
end;

procedure TFMain.Button2Click(Sender: TObject);
begin
Connected := false;
  TSettings.IP := '192.168.0.5';
Connected := true;
end;

procedure TFMain.Button3Click(Sender: TObject);
begin
Connected := false;
  TSettings.IP := '192.168.0.6';
Connected := true;
end;

procedure TFMain.Button4Click(Sender: TObject);
begin
Connected := false;
  TSettings.IP := '93.185.181.210';
Connected := true;
end;

procedure TFMain.cbOnlineClick(Sender: TObject);
begin
  Connected := cbOnline.Checked;
end;

procedure TFMain.CheckBox2Click(Sender: TObject);
begin
//  SetVideoWindowVisibility(CheckBox2.Checked);
  ocvCameraSource.Enabled := CheckBox2.Checked;
  if ocvCameraSource.Enabled then
    FrameNumber := 0;
end;


procedure TFMain.SelectContact;
var
  Data: PItemRec;
  Node: PVirtualNode;
begin
  if lbContacts.GetFirst = nil then
    exit;
  if not TSettings.LastContact.IsEmpty then
  begin
    Node :=lbContacts.GetFirst;
    while Assigned(Node) do
    begin
      Data := lbContacts.GetNodeData(Node);
      if Contacts.Items[Data.Index].UniqueName = TSettings.LastContact then
      begin
        lbContacts.FocusedNode := Node;
        lbContacts.Selected[Node] := true;
        exit;
      end;
      Node := lbContacts.GetNext(Node);
    end;
  end;

  lbContacts.FocusedNode := lbContacts.GetFirst;
  lbContacts.Selected[lbContacts.GetFirst] := true;
end;

procedure TFMain.SetConnected(aValue: boolean);
begin
  FConnected := aValue;
  ServersDM.Connected := FConnected;
  ClientsDM.Connected := FConnected;
  if not FConnected then
  begin
    Contacts.Disconnect;
    Contacts.BringOffline;
    lbContacts.Invalidate;
  end;
  StatusBar.Panels[1].Text := Format(sBindingStr, [TSettings.IP, TSettings.Port]);
  StatusBar.Invalidate;
  UpdateContactInfoPanel(CurrentContact);
end;


procedure TFMain.ClientStatusChanged(Sender: TObject; const aData: string);
var
  Command, Data, ContactUniqueName, ContactFriendlyName: string;
  Contact: TContact;
begin
  Command := GetToken(aData, ' ', 1);
  ContactUniqueName := GetToken(aData, ' ', 2);
  ContactFriendlyName := GetToken(aData, ' ', 3);
  Data := GetToken(aData, ' ', 4);
  Contact := Contacts.FindByUniqueName(ContactUniqueName);
  if Assigned(Contact) then
  begin
    Contact.Online := StrToInt(Command) = CmdImOnline;
    Contact.ExternalIP := TIdSocketHandle(Sender).PeerIP;
    Contact.InternalIP := GetToken(Data, ':', 1);
    Contact.Port := StrToIntDef(GetToken(Data, ':', 2), 0);

    lbContacts.Invalidate;

    if CurrentContact = Contact then
      UpdateContactInfoPanel(CurrentContact);
  end
  else
    memFPS.Lines.Add(ContactUniqueName)
end;

procedure TFMain.CurrContactChanged(aNode: PVirtualNode);
var
  Contact: TContact;
begin
  MemoHistory.Clear;
  Contact := GetContactFromNode(aNode);
  if Assigned(Contact) then
  begin
    Contact.History.Load;
    if FileExists(Contact.History.FileName) then
      UpdateContactInfoPanel(Contact);
    FillHistory;

    TSettings.LastContact := Contact.UniqueName;
  end;
end;

procedure TFMain.CurrContactChanging(aContact: TContact);
begin
  if Assigned(aContact) then
    aContact.History.Save;
  lblContactInfo.Caption := '';
end;

procedure TFMain.CurrContactChanging(aNode: PVirtualNode);
var
  Contact: TContact;
begin
  Contact := GetContactFromNode(aNode);
  CurrContactChanging(Contact);
end;

procedure TFMain.TextMessageReceived(Sender: TObject; const aData: string);
begin
  if Assigned(CurrentContact) then
    CurrentContact.History.AddTextMessage(false, aData);
  FillHistory;
  memFPS.Lines.Add(aData);
end;


procedure TFMain.UpdateContactInfoPanel(aContact: TContact);
begin
  if Assigned(aContact) then
  begin
    lblContactInfo.Caption := aContact.FriendlyName;
    imgContactStatus.Picture.Bitmap.Assign(GetStatusBitmap(aContact.Online));
  end
  else
  begin
    lblContactInfo.Caption := '';
    imgContactStatus.Picture.Bitmap.Canvas.Brush.Color := clGradientActiveCaption;
    imgContactStatus.Picture.Bitmap.Canvas.FillRect(imgContactStatus.BoundsRect);
  end;
end;

procedure TFMain.FillContactList;
var
  Node: PVirtualNode;
  Contact: TContact;
begin
  lbContacts.BeginUpdate;
  try
    lbContacts.Clear;

    ContactIndex := 0;
    for Contact in Contacts.Items do
    begin
      Node := lbContacts.AddChild(nil);
      lbContacts.ValidateNode(Node, false);
      Inc(ContactIndex);
    end;
  finally
    lbContacts.EndUpdate;
  end;
end;

procedure TFMain.FillHistory;
var
  Node: PVirtualNode;
  HistoryItem: THistoryItem;
begin
  MemoHistory.BeginUpdate;
  try
    MemoHistory.Clear;

    HistoryItemIndex := 0;
    for HistoryItem in CurrentContact.History.Items do
    begin
      Node := MemoHistory.AddChild(nil);
      MemoHistory.ValidateNode(Node, false);
      Inc(HistoryItemIndex);
    end;
  finally
    MemoHistory.EndUpdate;
  end;
  MemoHistory.ScrollIntoView(MemoHistory.GetLast, false);
end;

procedure TFMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  SetConnected(false);
  CurrContactChanging(CurrentContact);
  Contacts.Save;

  TSettings.WriteFormDimensions(Self);
  TSettings.WriteProperty(Self, 'pnlLeftWidth', pnlLeft.Width);
  TSettings.WriteProperty(Self, 'pnlVideoHeight', pnlVideo.Height);
  TSettings.WriteProperty(Self, 'pnlMessageHeight', pnlMessage.Height);
  TSettings.Done;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  if not DirectoryExists(GetDataDir) then
    CreateDir(GetDataDir);

  TSettings.Init;
  if TSettings.IP = ZeroIP then
    TSettings.IP := GetExternalIP;

  TSettings.ReadFormDimensions(Self, Width, Height);
  pnlLeft.Width := TSettings.ReadProperty(Self, 'pnlLeftWidth', pnlLeft.Width);
  pnlVideo.Height := TSettings.ReadProperty(Self, 'pnlVideoHeight', pnlVideo.Height);
  pnlMessage.Height := TSettings.ReadProperty(Self, 'pnlMessageHeight', pnlMessage.Height);
//  SetVideoWindowVisibility(false);


  Contacts := TContacts.Create;
  Contacts.Load;
//  Contacts.FillList(lbContacts.Items);
  FillContactList;
  SelectContact;

  SendVideoStream := TStringStream.Create;
  ReceiveVideoStream := TStringStream.Create;
  jpgReceive := TJpegImage.Create;
  jpgReceive.CompressionQuality := 60;

  jpgSend := TJpegImage.Create;
  jpgSend.CompressionQuality := 60;


  if TSettings.AutoConnect then
    cbOnline.Checked := true;

  ServersDM.OnClientStatusChanged := ClientStatusChanged;
  ServersDM.OnTextMessageReceived := TextMessageReceived;
  ServersDM.OnImageReceived := ImageReceived;

  ocvFileSource1.FileName := GetAppDir + '7.avi';
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  Contacts.Free;
  SendVideoStream.Free;
  ReceiveVideoStream.Free;
  jpgReceive.Free;
  jpgSend.Free;
end;

function TFMain.GetContactFromNode(aNode: PVirtualNode): TContact;
var
  Data: PItemRec;
begin
  Result := nil;
  if Assigned(aNode) then
  begin
    Data := lbContacts.GetNodeData(aNode);
    if Assigned(Data) then
      Result := Contacts.Items[Data.Index];
  end;
end;

function TFMain.GetCurrentContact: TContact;
begin
  Result := GetContactFromNode(lbContacts.FocusedNode);
end;


function TFMain.GetStatusBitmap(aValue: boolean): TBitmap;
begin
  Result := TBitmap.Create;
  Result.Transparent := true;
  Result.TransparentMode := tmFixed;
  Result.TransparentColor := clWhite;

  ImageListStatuses.GetBitmap(Ord(aValue), Result);
end;

procedure TFMain.ImageReceived(Sender: TObject; const aData: string);
begin
  SetVideoWindowVisibility(true);
  ReceiveVideoStream.Clear;
  ReceiveVideoStream.WriteString(StrFromMime(aData));
  ReceiveVideoStream.Position := 0;
//ReceiveVideoStream.SaveToFile('c:\1.jpg');
  try
    jpgReceive.LoadFromStream(ReceiveVideoStream);
    PaintBox1.Canvas.StretchDraw(PaintBox1.Canvas.ClipRect, jpgReceive);
  except on E: Exception do
  end;
end;

procedure TFMain.lbContactsFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
begin
  CurrContactChanged(Node);
end;

procedure TFMain.lbContactsFocusChanging(Sender: TBaseVirtualTree; OldNode,
  NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  CurrContactChanging(OldNode);
end;

procedure TFMain.lbContactsGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PItemRec;
begin
  Data := Sender.GetNodeData(Node);
  ImageIndex := Ord(Contacts.Items[Data.Index].Online);
end;

procedure TFMain.lbContactsGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TItemRec);
end;

procedure TFMain.lbContactsGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Data: PItemRec;
begin
  Data := Sender.GetNodeData(Node);
  CellText :=  Contacts.Items[Data.Index].FriendlyName;
end;

procedure TFMain.lbContactsInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PItemRec;
begin
  Data := Sender.GetNodeData(Node);
  Data.Index := ContactIndex;
end;

procedure TFMain.MemoHistoryGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PItemRec;
  HistoryItem: THistoryItem;
begin
  if not Assigned(CurrentContact) then
    exit;
  Data := Sender.GetNodeData(Node);
  if Data.Index >= CurrentContact.History.Items.Count then
    exit;
  HistoryItem := CurrentContact.History.Items[Data.Index];
  assert(assigned(HistoryItem));
  case Column of
    0:
      if HistoryItem.Own then
        CellText := TSettings.FriendlyName
      else
        CellText := CurrentContact.FriendlyName;
    1:
      CellText := HistoryItem.AdditionalInfo;
    2:
      if TDate(HistoryItem.TimeStamp) = TDate(Now) then
        CellText := HistoryItem.Time
      else
        CellText := HistoryItem.Date + ' ' + HistoryItem.Time;
  end;
end;

procedure TFMain.MemoHistoryInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PItemRec;
  NodeText: string;
  DC: HDC;
  TM: TTextMetric;
begin
//Node.Align := 20;
  Data := Sender.GetNodeData(Node);
  Data.Index := HistoryItemIndex;
  NodeText := CurrentContact.History.Items[Data.Index].AdditionalInfo;

  if not NodeText.IsEmpty then
  begin

    DC := CreateCompatibleDC(0);
    GetTextMetrics(DC, TM);
    Include(InitialStates, ivsMultiline);
    Sender.NodeHeight[Node] := (Length(NodeText) * TM.tmMaxCharWidth div Sender.Width + 1) *
      TM.tmHeight;
    DeleteDC(DC);
  end
  else
    Sender.NodeHeight[Node] := TVirtualStringTree(Sender).DefaultNodeHeight;
end;

procedure TFMain.MemoHistoryMeasureTextHeight(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const Text: string; var Extent: Integer);
begin
  if Sender.MultiLine[Node] then
  begin
//    TargetCanvas.Font := Sender.Font;
//    Extent := MemoHistory.ComputeNodeHeight(TargetCanvas, Node, 0);
  end;
end;

procedure TFMain.MemoHistoryPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  Data: PItemRec;
  HistoryItem: THistoryItem;
begin
  if (MemoHistory.FocusedColumn = Column) and (vsSelected in Node.States) then
    TargetCanvas.Font.Color := clWhite
  else
  begin
    Data := Sender.GetNodeData(Node);
    HistoryItem := CurrentContact.History.Items[Data.Index];
    case Column of
      0:
        if HistoryItem.Own then
          TargetCanvas.Font.Color := clNavy
        else
          TargetCanvas.Font.Color := clSkyBlue;
      1:
      begin
        TargetCanvas.Font.Color := clBlack;
        if HistoryItem.Own and not HistoryItem.Delivered then
          TargetCanvas.Font.Color := clRed;
      end;
      2: TargetCanvas.Font.Color := clGray;
    end;
  end;
end;

procedure TFMain.MemoHistoryResize(Sender: TObject);
begin
  MemoHistory.Header.Columns[0].Width := 100;
  MemoHistory.Header.Columns[1].Width := MemoHistory.Width - 250;
  MemoHistory.Header.Columns[2].Width := 150;
end;

procedure TFMain.MemoMessageKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key <> VK_RETURN then
    exit;
  if (TSettings.ChatSendingType = 0) or (ssCtrl in Shift) or (ssRight in Shift) then
  begin
    Key := 0;
    btnSendClick(btnSend);
  end;
end;

procedure TFMain.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFMain.miLoadVCardClick(Sender: TObject);
var
  List: TStringList;
  Contact: TContact;
  UniqueName: string;
  ExistingContact: boolean;
begin
  OpenDialog.DefaultExt := DefVCardExt;
  OpenDialog.Filter := 'Визитки MiLi|*' + DefVCardExt;
  OpenDialog.InitialDir := GetDataDir;
  if not OpenDialog.Execute then
    exit;
  List := TStringList.Create;
  try
    List.LoadFromFile(OpenDialog.FileName);
    if List.IndexOfName('UniqueName') = 1 then
    begin
      ShowMessage('Файл ' + ExtractFileName(OpenDialog.FileName) +
        'не является файлом визитки MiLi.');
      exit;
    end;

    UniqueName := List.Values['UniqueName'];
    Contact := Contacts.FindByUniqueName(UniqueName);
    ExistingContact := Assigned(Contact);
    if not ExistingContact then
      Contact := TContact.Create(UniqueName);
    Contact.FriendlyName := List.Values['FriendlyName'];
    Contact.InternalIP := List.Values['InternalIP'];
    Contact.ExternalIP := List.Values['ExternalIP'];
    Contact.Port := StrToIntDef(List.Values['Port'], TSettings.Port);
    if not ExistingContact then
      Contacts.Items.Add(Contact);

    FillContactList;
  finally
    List.Free;
  end;
end;

procedure TFMain.miSaveVCardClick(Sender: TObject);
var
  List: TStringList;
begin
  SaveDialog.DefaultExt := DefVCardExt;
  SaveDialog.Filter := 'Визитки MiLi|*' + DefVCardExt;
  SaveDialog.InitialDir := GetDataDir;
  SaveDialog.FileName := TSettings.FriendlyName;
  if not SaveDialog.Execute then
    exit;
  List := TStringList.Create;
  try
    List.Add('UniqueName=' + TSettings.UniqueName);
    List.Add('FriendlyName=' + TSettings.FriendlyName);
    List.Add('InternalIP=' + GetInternalIP);
    List.Add('ExternalIP=' + GetExternalIP);
    List.Add('Port=' + IntToStr(TSettings.Port));
    List.SaveToFile(SaveDialog.FileName);
  finally
    List.Free;
  end;
end;

procedure TFMain.miSettingsClick(Sender: TObject);
begin
  if TFSettingsForm.ShowForm then
end;

procedure TFMain.ocvCameraSourceImage(Sender: TObject; var IplImage: IocvImage);
var
  Bmp: TBitmap;
  DataString: string;
begin
  if not ocvCameraSource.Enabled then
    exit;
Inc(FrameNumber);
  Bmp := IplImage.AsBitmap;
  if Assigned(Bmp) then
  begin
    jpgSend.Assign(Bmp);
    Bmp.Free;
  end
  else
    exit;

  SendVideoStream.Clear;
  jpgSend.SaveToStream(SendVideoStream);

  DataString := SendVideoStream.DataString;
  DataString := StrToMime(DataString);

   if ClientsDM.SendStringBySlices(mkVideo, CurrentContact, DataString) then
     memFPS.Lines.Add(IntToStr(FrameNumber) + '  + ')
   else
     memFPS.Lines.Add(IntToStr(FrameNumber));
end;

procedure TFMain.ocvFileSource1Image(Sender: TObject; var IplImage: IocvImage);
var
  Bmp: TBitmap;
  DataString: string;
begin
  if not ocvFileSource1.Enabled then
    exit;
  Bmp := IplImage.AsBitmap;
  if Assigned(Bmp) then
  begin
    jpgSend.Assign(Bmp);
    Bmp.Free;
  end
  else
    exit;

  SendVideoStream.Clear;
  jpgSend.SaveToStream(SendVideoStream);

  DataString := SendVideoStream.DataString;
  DataString := StrToMime(DataString);

//  if CurrentContact = nil then
//    ImageReceived(nil, SendVideoStream.DataString)
//  else
    ClientsDM.SendStringBySlices(mkVideo, CurrentContact, DataString);
end;

procedure TFMain.pmContactsPopup(Sender: TObject);
begin
//  if lbContacts.ItemIndex = -1 then
//  begin
//    miSetConnection.Enabled := false;
//    exit;
//  end;
//  miSetConnection.Enabled := true;
//  if Contacts[lbContacts.ItemIndex].Connected then
//    miSetConnection.Caption := 'Disconnect'
//  else
//    miSetConnection.Caption := 'Connect';
end;

procedure TFMain.RightSideResize;
begin
  pnlContactCommon.Height := pnlContactInfo.Height;
  if pnlVideo.Visible then
  begin
    pnlContactCommon.Height := pnlContactCommon.Height + pnlVideo.Height;
//    pnlContactCommon.Align := alTop;
  end
//  else
//    pnlContactCommon.Align := alClient;
end;

procedure TFMain.SetVideoWindowVisibility(aVisible: boolean);
begin
  if pnlVideo.Visible = aVisible then
    exit;
  pnlVideo.Visible := aVisible;
  SplitterRight.Visible := aVisible;
  RightSideResize;
end;

procedure TFMain.SplitterRightMoved(Sender: TObject);
begin
  RightSideResize;
end;

procedure TFMain.StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
var
  bmp: TBitmap;
begin
  if Panel.Index  <> 0 then
    exit;

  bmp := GetStatusBitmap(Connected);
  try
//bmp.Transparent := true;
//bmp.TransparentMode := tmAuto;
//bmp.TransparentColor := clWhite;
    BitBlt(StatusBar.Canvas.Handle, Rect.Left + 0, Rect.Top + 0, bmp.Width, bmp.Height,
      bmp.Canvas.Handle, 0, 0, SRCAND);
  finally
    bmp.Free;
  end;

end;

end.
